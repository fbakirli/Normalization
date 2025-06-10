# Database Normalization 

## Introduction

This project provides an SQL script designed to demonstrate and implement database normalization concepts. The script performs the process of normalizing a database from Unnormalized Form to Third Normal Form basde on a sample dataset. It includes creating, modifying, and managing tables to establish normalized relationships among entities, which are books, authors, publishers, and courses.

## Table of Contents

- [Introduction](#introduction)
- [Dependencies](#dependencies)
- [Usage](#usage)
- [Troubleshooting](#troubleshooting)


### Dependencies

Before running the script, make sure your setup meets these requirements:

Operating System: Windows 10, macOS, or Linux
Database Management System:
PostgreSQL (preferred, tested on version 12 or later)
MySQL (requires syntax adjustments for compatibility)

Permissions: You need a database user with permissions to create, drop, and modify tables.

SQL Client: Any terminal-based or graphical client, such as pgAdmin, DBeaver, or MySQL Workbench. Preferred is pgAdmin, as the script was tested with it.


### Usage

#### Setup

1. Download the sql files in this repo
2. Open *pgAdmin 4*
3. Create a database
4. Open the Query Tool in pgAdmin
5. Click 'Open File' and choose assignment3.sql if you only want the script, but if you also want the procedure, choose NormalizationProcedure.sql
6. Find the 'Unnormalized.csv' file in your directories, copy its location and paste it in this query, inside the first quotation marks( 'your:\file\location'):
   
    COPY unnorm (CRN, ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Years, Course_Name)
   
    FROM 'your:\file\location'
   
    DELIMITER ',' CSV HEADER ENCODING 'ISO-8859-1';
   
   
You are ready to go! Execute the script to save the procedure, which also performs the normalization techniques. You can call the procedure anytime by:

```sql
CALL normalize_database();
```
    
### Troubleshooting

#### Common Issues and Solutions

1. **Incorrect File Path**  
   - Make sure the file path to `Unnormalized.csv` is accurately specified for your operating system:  
     - On Linux or macOS, use forward slashes (`/`).  
     - On Windows, ensure the path uses double backslashes (`\\`) or is enclosed in quotes to avoid errors.  
   - Example:  
     ```bash
     "/path/to/Unnormalized.csv"  # Linux/macOS
     "C:\\path\\to\\Unnormalized.csv"  # Windows
     ```

2. **Access Denied Errors**  
   - If you encounter permission issues, update the folder permissions to allow the script to read/write the file:  
     - On Linux, use the `chmod` command:  
       ```bash
       chmod 777 [folder_path]
       ```
     - On Windows, ensure the folder isn’t marked as “Read-Only” in its properties.

3. **File Format or Data Errors**  
   - Confirm that the `Unnormalized.csv` file follows the expected format, including:  
     - Correct column headers.
     - Consistent data types for each field.  
   - If you're unsure, open the file in a text editor or spreadsheet application to verify its structure.  
   - Example: Ensure headers like `ISBN`, `Title`, `Author` are present and properly aligned.

4. **Database Connection Errors**  
   - Check your database configuration to ensure the credentials, host, and port match the setup in your script.  
   - Ensure the database server is running and accessible from your machine.

5. **Script Execution Issues**  
   - If the script fails mid-execution, review error messages carefully for clues. Missing prerequisites, such as required tables or prior steps, may cause these errors.

#### Need Additional Help?

If you're unable to resolve an issue, you can:
- Review the list of common errors and verify each step.
- Reach out for support via email: [fbakirli17945@ada.edu.az](mailto:fbakirli17945@ada.edu.az). Please provide a detailed description of the issue, along with any error messages or logs.
- Consult the documentation for your database management system for further guidance.
