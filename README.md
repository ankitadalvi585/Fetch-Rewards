## Fetch Rewards Take Home Assessment

[Details & Questions for the Assessment](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/Questions_for_FetchRewardsAssessment.pdf)

### Qs 1. First: Review Existing Unstructured Data and Diagram a New Structured Relational Data Model

> Attachments to refer:                               
    [FetchRewardsAssessment.pynb](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/FetchRewardsAssessment.ipynb)                                       
    [FetchRewardsAssessment.drawio](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/1.%20FetchRewardsAssessment.drawio)                      
    [JSON Files](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/JSONFiles_FetchRewardsAssessment.zip)

Run the FetchRewardsAssessment.pynb file to extract data from json files and convert it into respective dataframes/CSV's

**Steps to run pynb file:**
	
 	1. Open the pynb file in Jupyter Notebook.
	2. Make sure the JSON files are in the same folder as the pynb file. If not, you can change the path to the json files in the code.
	3. Place the cursor on the code cell or markdown and click on 'Run' option in the tool bar or press Shift+Enter. This will execute the code or markdown text in that particular cell.

Open the FetchRewardsAssessment.drawio file for the relational data model created as per my understanding of the data (Screenshot for the same attached below).

Structured Relational Data model for JSON files provided is as below:

![image](https://github.com/user-attachments/assets/68bd50ca-10f6-49df-bb6e-f9a726cd463b)


### Qs 2. Second: Write queries that directly answer predetermined questions from a business stakeholder

> Attachment to refer: [FetchRewardsAssessment.sql](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/2.%20FetchRewardsAssessment.sql)

Created Receipts, RewardReceiptItemList, Brands, Users table in SQL Server Management Studio by importing the flat files (CSV's) and executed queries in the 'FetchRewardsAssessment.sql' to obtain answers to the questions asked. 

**Refer [FetchRewardsAssessment.sql](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/2.%20FetchRewardsAssessment.sql) file for explanation of the queries developed for the below questions.**

Questions: 

1. When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

    Result: Average Spend is greater for 'Accepted' ('Finished') rewardReceiptStatus.

    > Considered 'FINISHED' as 'Accepted' as there was no such status as 'Accepted' in the 'rewardsReceiptStatus' column.

    **Query**:

       SELECT rewardsReceiptStatus, ROUND(AVG(totalSpent),2) AS averageSpend 
        FROM Receipts
        WHERE rewardsReceiptStatus in ('FINISHED', 'REJECTED')
        GROUP BY rewardsReceiptStatus
        ORDER BY AVG(totalSpent) DESC;

    ![image](https://github.com/user-attachments/assets/6e1069be-f631-4c8e-930b-bb4f3b426e5b)

3. When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
   
    Result: Total number of items purchased is greater for 'Accepted' ('Finished') rewardReceiptStatus.

    > Considered 'FINISHED' as 'Accepted' as there was no such status as 'Accepted' in the 'rewardsReceiptStatus' column.

    **Query**:

       SELECT rewardsReceiptStatus, SUM(purchasedItemCount) as totalItems 
        FROM Receipts
        WHERE rewardsReceiptStatus in ('FINISHED', 'REJECTED')
        GROUP BY rewardsReceiptStatus
        ORDER BY sum(purchasedItemCount) DESC;
   
    ![image](https://github.com/user-attachments/assets/9fbe5ea8-2198-49af-a914-4c2f3a54a01d)

5. Which brand has the most spend among users who were created within the past 6 months?

    Result: BEN AND JERRY'S brand has the most spend among users who were created within the past 6 months

    **Query**:

       WITH ReceiptTotals AS (
        SELECT 
            ri.brandCode,
            ROUND(SUM(r.totalSpent),2) AS summedTotalSpent
        FROM 
		    receipts r INNER JOIN RewardReceiptItemList ri ON r.id=ri.id
		    INNER JOIN users u ON r.userId = u.id
        WHERE u.createdDate > DATEADD(MONTH, -6, (Select MAX(createddate) from users)) 
              AND ri.brandCode IS NOT NULL
        GROUP BY ri.brandCode
        )
        SELECT top 1 *
        FROM ReceiptTotals
        ORDER BY summedTotalSpent DESC;

    ![image](https://github.com/user-attachments/assets/6e3abdfd-860d-423f-b596-50966c78f54c)

7. Which brand has the most transactions among users who were created within the past 6 months?

    Result: HY-VEE brand has the most transactions among users who were created within the past 6 months

    **Query**:

       WITH ReceiptCount AS (
        SELECT 
            ri.brandCode,
            COUNT(r.id) AS transactionCount
        FROM 
		    receipts r INNER JOIN RewardReceiptItemList ri ON r.id=ri.id
		    INNER JOIN users u ON r.userId = u.id
        WHERE 
		    u.createdDate > DATEADD(MONTH, -6, (Select MAX(createddate) from users)) 
		    AND ri.brandCode IS NOT NULL
        GROUP BY 
		    ri.brandCode
        )
        SELECT top 1 *
        FROM ReceiptCount
        ORDER BY transactionCount DESC;

    ![image](https://github.com/user-attachments/assets/541c74fb-a6bd-4d2a-9e36-1c4a229a3a91)


### Qs 3. Third: Evaluate Data Quality Issues in the Data Provided

> Attachment to refer: [FetchRewardsAssessment_DQ.sql](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/3.%20FetchRewardsAssessment_DQ.sql)

Identified Data Quality issues as mentioned below. Detailed Analysis are present in the 'FetchRewardsAssessment_DQ.sql' file.

1. JSON Files: Date format in json files is in epoch time format (Unix Time stamp) which needed additional processing.
2. Found brandcodes in RewardReceiptItems table which are not present in brands table and vice versa. Considering Brands as the dimension table, all of the brandcodes in RewardReceiptItems table should be present in Brands table. Significant amount of data will be missing when we query between Brands & RewardReceiptItems tables using joins.
3. Duplicate records in the Users table.
4. Data completeness and standardization issues for categorical (text) columns.


### Qs 4. Fourth: Communicate with Stakeholders

> Attachment to refer: [Email_Communication.txt](https://github.com/ankitadalvi585/Fetch-Rewards/blob/main/4.%20Email_Communication.txt)

Constructed the email below to be sent to stakeholder/ and have mentioned it in 'Email_Communication.txt' file.

    Hi Team,

	I hope you're doing well. I have conducted an initial review of the Fetch Rewards data files (receipts, brands, users) and identified several data quality issues that could impact analysis and reporting. I have below questions/concerns about the data provided.

	Questions about the data:

	1. Why is the date stored in epoch format instead of a standard date format?
	2. Why are some brand codes missing in the Brands table but present in RewardReceiptItemList?
	3. Are the duplicate records in the Users table removed correctly, and do they impact reporting?
	4. What is the purpose of columns in RewardReceiptItemList that are mostly NULL?
	5. Can we standardize category and category codes to avoid inconsistencies?
	6. Why do some Boolean columns have empty (NULL) values instead of True/False?
	7. Should barcode data in RewardReceiptItemList be stored as text or another format?

	I found these data quality issues by running queries to compare the data across tables, identifying inconsistencies in text fields, checking for null values and duplicates before importing the data, analyzing column completeness and reviewing the formats of the data provided.

	I need below clarifications regarding the data to handle the data quality issues above:

	1. What is the expected format for date fields?
	2. Should missing brand codes be added, or do they indicate errors in data entry?
	3. What is the business rule for handling NULL values in Boolean and Categorical columns?
	4. Would you like any validation rules to be implemented to prevent future duplicates in Users table?
	5. Over 80% of the data in ~20 columns in RewardReceiptItemList is NULL. Since these are mostly empty, would like to understand the purpose of these columns where are they used?
	6. Around 82 records have 'text' values similar to B076FJ92M4 in the barcode column in RewardReceiptItemList table whereas rest of them are numeric. What is the reason for this difference?

	Other information needed to optimize the data:

	1. Business logic on how categories, brand codes, and missing values should be handled.
	2. Expected relationships between tables.
	3. Information about which columns with empty (NULL) values are actually required for reporting and which ones can be dropped.
	4. Documentation on how data should be validated. For example, Date formats, Barcode format, Brand Codes, Category Standardization, NULL handling. 

	Also, I anticipate below performance and scaling concerns in production:

	1. Missing and inconsistent data across tables might affect the accuracy of data analysis.
	>  To address this, we can implement data validation rules, make sure related data matches correctly across tables, and clean the data before processing. 
 
	2. As data grows, large datasets could lead to slower query performance.
	>  To address this, we can optimize queries, ensure proper indexing and other database optimization techniques to improve scalability.

	I look forward to discussing these observations with you and scheduling some time to go over them in more detail. 

	Best Regards,
	Ankita
