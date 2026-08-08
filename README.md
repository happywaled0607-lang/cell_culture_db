# Cell Culture Laboratory Management System

Course project for Fundamentals of Databases. Contains database schema, sample dataset, relational views, stored procedures, functions, and a Streamlit web application for managing cell culture laboratory workflows.

## Overview
The system manages and tracks:
- Cell lines, organism sources, and biosafety levels
- Culture vessels and media formulations
- Incubators and environmental conditions
- Cell passages and seeding densities
- Quality control observations and contamination testing
- Cryopreserved inventory stocks and storage locations
- Research staff and active laboratory experiments

## Tech Stack
- **Database**: MySQL 8.0+
- **Language**: Python 3.x
- **Web UI**: Streamlit
- **Libraries**: `mysql-connector-python`, `pandas`

## Repo Structure

    ├── sql/
    │   ├── create_tables.sql         # Schema definitions & table constraints
    │   ├── load_data.sql             # Test dataset
    │   ├── queries.sql               # Analytical queries, joins & aggregations
    │   ├── views.sql                 # Database views
    │   └── triggers_procedures.sql   # Stored procedure & function
    ├── src/
    │   └── app.py                    # Streamlit web application
    ├── diagrams/
    │   └── ERD.png                   # Entity-Relationship Diagram
    ├── README.md                     # Setup instructions & project documentation
    ├── report.pdf                    # Complete written report
    └── presentation.pptx             # Defense slides

## Setup & Running

### 1. Database Setup
Execute the SQL files in order inside MySQL Workbench:
1. `sql/create_tables.sql`
2. `sql/load_data.sql`
3. `sql/queries.sql`
4. `sql/views.sql`
5. `sql/triggers_procedures.sql`

### 2. Web App (Streamlit)
Install required dependencies:

    pip install streamlit mysql-connector-python pandas

Ensure your local MySQL password matches the connection config in `src/app.py`, then run:

    streamlit run src/app.py
