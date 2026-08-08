import mysql.connector
import pandas as pd
import streamlit as st

# Page Configuration
st.set_page_config(
    page_title="Cell Culture Lab Manager", page_icon="🧫", layout="wide"
)


# Database Connection
def get_db_connection():
    try:
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="PASSWORD",  # Replace with your MySQL password
            database="cell_culture_db",
        )
        return conn
    except mysql.connector.Error as err:
        st.error(f"Database Connection Error: {err}")
        return None


# Header
st.title("🧫 Cell Culture Laboratory Management System")
st.markdown(
    "Interactive portal for viewing lab inventories, tracking cell passages, and running database operations."
)

# Sidebar Navigation
st.sidebar.header("Navigation Control")
menu = st.sidebar.radio(
    "Select Action",
    [
        "Database Overview & Search",
        "Add New Cell Line",
        "Update Incubator Status",
        "Delete Contamination Test",
    ],
)

# 1. READ & SEARCH SECTION
if menu == "Database Overview & Search":
    st.subheader("🔍 Database Tables & Views Explorer")

    tables = [
        "cell_lines",
        "passages",
        "incubators",
        "media_types",
        "culture_vessels",
        "experiments",
        "observations",
        "contamination_tests",
        "cryopreserved_stocks",
        "vw_active_passages",
        "vw_cryo_inventory",
    ]

    selected_table = st.selectbox("Choose Table or View to Browse", tables)
    search_term = st.text_input("Search Keyword across records")

    conn = get_db_connection()
    if conn:
        query = f"SELECT * FROM {selected_table}"
        df = pd.read_sql(query, conn)
        conn.close()

        if search_term:
            df_filtered = df[
                df.astype(str).apply(
                    lambda x: x.str.contains(search_term, case=False).any(),
                    axis=1,
                )
            ]
            st.dataframe(df_filtered, use_container_width=True)
            st.info(
                f"Showing {len(df_filtered)} matching records out of {len(df)} total."
            )
        else:
            st.dataframe(df, use_container_width=True)
            st.caption(f"Total Records: {len(df)}")

# 2. CREATE SECTION
elif menu == "Add New Cell Line":
    st.subheader("➕ Register New Cell Line")

    with st.form("add_cell_line_form"):
        cell_line_name = st.text_input(
            "Cell Line Name (e.g., U-87 MG)", max_chars=100
        )
        organism = st.text_input("Organism (e.g., Homo sapiens)")
        tissue_source = st.text_input("Tissue Source (e.g., Brain Glioblastoma)")
        biosafety_level = st.slider("Biosafety Level (BSL)", 1, 4, 1)

        submitted = st.form_submit_button("Add Cell Line")

        if submitted:
            if not cell_line_name or not organism or not tissue_source:
                st.warning("Please fill in all required fields.")
            else:
                conn = get_db_connection()
                if conn:
                    cursor = conn.cursor()
                    insert_query = """
                    INSERT INTO cell_lines (cell_line_name, organism, tissue_source, biosafety_level)
                    VALUES (%s, %s, %s, %s)
                    """
                    try:
                        cursor.execute(
                            insert_query,
                            (
                                cell_line_name,
                                organism,
                                tissue_source,
                                biosafety_level,
                            ),
                        )
                        conn.commit()
                        st.success(
                            f"Cell line '{cell_line_name}' successfully inserted into database!"
                        )
                    except mysql.connector.Error as err:
                        st.error(f"SQL Error: {err}")
                    finally:
                        cursor.close()
                        conn.close()

# 3. UPDATE SECTION
elif menu == "Update Incubator Status":
    st.subheader("⚙️ Update Incubator Operational Status")

    conn = get_db_connection()
    if conn:
        incubators_df = pd.read_sql(
            "SELECT incubator_id, model_number, status FROM incubators", conn
        )
        conn.close()

        st.dataframe(incubators_df, use_container_width=True)

        incubator_id = st.number_input(
            "Enter Incubator ID to Update",
            min_value=1,
            step=1,
            value=int(incubators_df["incubator_id"].min()),
        )
        new_status = st.selectbox(
            "Select New Status", ["Operational", "Maintenance", "Offline"]
        )

        if st.button("Apply Status Update"):
            conn = get_db_connection()
            if conn:
                cursor = conn.cursor()
                update_query = (
                    "UPDATE incubators SET status = %s WHERE incubator_id = %s"
                )
                try:
                    cursor.execute(update_query, (new_status, incubator_id))
                    conn.commit()
                    if cursor.rowcount > 0:
                        st.success(
                            f"Incubator ID {incubator_id} updated to '{new_status}'!"
                        )
                    else:
                        st.error("Incubator ID not found.")
                except mysql.connector.Error as err:
                    st.error(f"SQL Error: {err}")
                finally:
                    cursor.close()
                    conn.close()

# 4. DELETE SECTION
elif menu == "Delete Contamination Test":
    st.subheader("🗑️ Delete Contamination Test Record")

    conn = get_db_connection()
    if conn:
        tests_df = pd.read_sql("SELECT * FROM contamination_tests", conn)
        conn.close()

        st.dataframe(tests_df, use_container_width=True)

        test_id_to_delete = st.number_input(
            "Enter Test ID to Delete",
            min_value=1,
            step=1,
            value=int(tests_df["test_id"].min()) if not tests_df.empty else 1,
        )

        if st.button("Delete Record"):
            conn = get_db_connection()
            if conn:
                cursor = conn.cursor()
                delete_query = (
                    "DELETE FROM contamination_tests WHERE test_id = %s"
                )
                try:
                    cursor.execute(delete_query, (test_id_to_delete,))
                    conn.commit()
                    if cursor.rowcount > 0:
                        st.success(
                            f"Contamination test record ID {test_id_to_delete} removed successfully."
                        )
                    else:
                        st.error("Test ID not found.")
                except mysql.connector.Error as err:
                    st.error(f"SQL Error: {err}")
                finally:
                    cursor.close()
                    conn.close()
