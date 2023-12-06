# Conduit Mid Year Filing Analysis: 2024 Cycle 

This work uses Washington Post's FastFec package to download specific filings from ActBlue and WinRed that are cleaned with python and loaded into a SQLite database, before being analyzed and visualized in R. 

As a warning: these files contain millions of rows of contribution data, so you'll need to be patient when working with them 

## Contents

### **etl_actblue_my_2019.ipynb**

This Jupyter Notebook file is an example of the ETL process for this work. Using Pandas, I load the SA11AI (individual contributions) file from fastfec output folder, examine and clean the data, and load the resulting table into a locally stored sqlite database. This script depends on the following files:


1. **function_load_large_csv.py**
    
    To facilitate efficient loading of the large SA11AI csv files

2. **objects.py**

    Not included in this repo, but a basic config file where I save file paths and other static objects unique to my workflow

This script can be used as a model for additional ActBlue filings. With WinRed filings, recipient committee information is stored in the `contribution_purpose` column instead of `memo_text_description`

### **my_conduit_analysis.rmd**

This RMarkdown file contains the code that generated **my_conduit_analysis.pdf** and depends on the following R scripts:

1. **sql_queries_ab_2019.r**
    
    The SQL queries related to the 2019 ActBlue mid year filing table

2. **sql_queries_ab_2023.r**

    The SQL queries related to the 2023 ActBlue mid year filing table

3. **sql_queries_wr_23.r**

    The SQL queries related to the 2023 WinRed mid year filing table

4. **sql_queries_wr_ab_xcycle.r**

    The SQL queries that include data from both WinRed and ActBlue and or both cycles.

### **my_conduit_analysis.pdf**

The result of this work, a report on information gathered from analyzing ActBlue and WinRed's 2023 midyear filings. There is *a lot* more information that you can get from these filings, this work represents more basic topline analyses. 
