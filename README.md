### Qs 1. First: Review Existing Unstructured Data and Diagram a New Structured Relational Data Model

> Attachments to refer: FetchRewardsAssessment.pynb, FetchRewardsAssessment.drawio

Run the FetchRewardsAssessment.pynb file to extract data from json files and convert it into respective dataframes/CSV's

Open the FetchRewardsAssessment.drawio file for the relational data model created as per my understanding of the data (Screenshot for the same attached below).

Structured Relational Data model for JSON files provided is as below:

![image](https://github.com/user-attachments/assets/68bd50ca-10f6-49df-bb6e-f9a726cd463b)


### Qs 2. Second: Write queries that directly answer predetermined questions from a business stakeholder

> Attachment to refer: FetchRewardsAssessment.sql

Created Receipts, RewardReceiptItemList, Brands, Users table in SQL Server Management Studio by importing the flat files (CSV's) and executed queries in the 'FetchRewardsAssessment.sql' to obtain answers to the questions asked. 

Questions: 

1. When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

    Result: Average Spend is greater for 'Accepted' ('Finished') rewardReceiptStatus.

    > Considered 'FINISHED' as 'Accepted' as there was no such status as 'Accepted' in the 'rewardsReceiptStatus' column.

    ![image](https://github.com/user-attachments/assets/bd6bebce-c7d9-4d3c-9bbd-51c56a90dbe0)

    ![image](https://github.com/user-attachments/assets/6e1069be-f631-4c8e-930b-bb4f3b426e5b)

2. When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
   
    Result: Total number of items purchased is greater for 'Accepted' ('Finished') rewardReceiptStatus.

    > Considered 'FINISHED' as 'Accepted' as there was no such status as 'Accepted' in the 'rewardsReceiptStatus' column.

    ![image](https://github.com/user-attachments/assets/5d68435f-288a-476b-8373-546ec8ed599e)

    ![image](https://github.com/user-attachments/assets/9fbe5ea8-2198-49af-a914-4c2f3a54a01d)

3. Which brand has the most spend among users who were created within the past 6 months?

    Result: BEN AND JERRY'S brand has the most spend among users who were created within the past 6 months

    ![image](https://github.com/user-attachments/assets/cc8fa524-5cb7-4f48-aa91-abf2d726296f)

    ![image](https://github.com/user-attachments/assets/6e3abdfd-860d-423f-b596-50966c78f54c)

4. Which brand has the most transactions among users who were created within the past 6 months?

    Result: HY-VEE brand has the most transactions among users who were created within the past 6 months

    ![image](https://github.com/user-attachments/assets/0114bc72-b31e-43c2-a152-475c847ee3cc)

    ![image](https://github.com/user-attachments/assets/541c74fb-a6bd-4d2a-9e36-1c4a229a3a91)


### Qs 3. Third: Evaluate Data Quality Issues in the Data Provided

> Attachment to refer: FetchRewardsAssessment_DQ.sql

Identified Data Quality issues and have mentioned them in the 'FetchRewardsAssessment_DQ.sql' file in the comments. Also, have mentioned SQL queries which were used to diagnose these issues.


### Qs 4. Fourth: Communicate with Stakeholders

> Attachment to refer: Email_Communication.txt

Constructed the email to be sent to stakeholder/ and have mentioned it in 'Email_Communication.txt' file.

![image](https://github.com/user-attachments/assets/3907c0bf-1801-4ccb-a13c-c4e44b612584)

