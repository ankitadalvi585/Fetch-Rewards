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

    I hope you're doing well. I have conducted an initial review of the Fetch Rewards data files (receipts, brands, users) and identified several data quality issues that could impact analysis and reporting. 
    
    Below is a summary of the key findings along with some questions to ensure data accuracy.

    Key Data Quality Issues Identified:

    1. Missing Brand Codes: Many receipt item lists had Brand codes that were not present in the Brands table. This might affect the aggregation(joins) when performing analysis by brand.Should we expect these to be added, or is there a separate process to handle this?

    2. Sparse Columns in Reward Receipt Items List: Over 80% of the data in ~20 columns is NULL. Since these are mostly NULL, would like to understand the purpose of these columns where are they used?

    3. NULL Values in Boolean Columns – Boolean fields such as 'needsFetchReview', 'userFlaggedNewItem', and 'competitiveProduct' in 'RewardReceiptItemList' contain NULL values. Can we treat NULLs as False or is there a different approach you would recommend for handling these NULL values?

    4. Duplicate Records in Users Table: I observed duplicate records for the same user in users table. Those were removed before importing the data into the database. Could you please clarify why this is happening? Also, would you like validation rules implemented to prevent future duplicates?

    In addition to these points, I have discovered some data standardization and redundancy issues which we can talk about and clarify. 
    Lastly, considering the production environment, do you anticipate any performance or scaling concerns? If so, we can explore indexing, partitioning, or other optimization strategies.

    I look forward to discussing these observations with you and scheduling some time to go over them in more detail. 

    Best Regards,
    Ankita
