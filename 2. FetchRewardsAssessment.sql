-- Second: Write queries that directly answer predetermined questions from a business stakeholder

-- Question 1:
-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

-- Considered 'FINISHED' as 'ACCEPTED' as it felt relevant as compared to other categories in rewardsReceiptStatus column
-- Calculated average of totalSpent grouped by rewardsReceiptStatus column to find the average amount spent for each status

SELECT rewardsReceiptStatus, ROUND(AVG(totalSpent),2) AS averageSpend 
FROM Receipts
WHERE rewardsReceiptStatus in ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus
ORDER BY AVG(totalSpent) DESC;

-- Result: Average Spend is greater for 'Accepted' ('Finished') rewardReceiptStatus.


-- Question 2:
-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

-- Considered 'FINISHED' as 'ACCEPTED' as it felt relevant as compared to other categories in rewardsReceiptStatus column
-- Calculated sum of purchasedItemCount grouped by rewardsReceiptStatus column to find out no of purchased items for each status

SELECT rewardsReceiptStatus, SUM(purchasedItemCount) as totalItems 
FROM Receipts
WHERE rewardsReceiptStatus in ('FINISHED', 'REJECTED')
GROUP BY rewardsReceiptStatus
ORDER BY sum(purchasedItemCount) DESC;

-- Result: Total number of items purchased is greater for 'Accepted' ('Finished') rewardReceiptStatus.


-- Question 3:
-- Which brand has the most spend among users who were created within the past 6 months? 

-- Joined Receipts with RewardReceiptItemList tables using id column as the key
-- Joined Users and Receipt tables using 'id' & 'userId' respectively as the keys
-- Used DATEADD function to filter the users created within the past 6 months from the MAX (most recent) createdDate in the users table
-- Used sum of totalSpent column and grouped by brandCode to calculate totl amount spent for each brand
-- brandCode column has multiple NULL values, hence only considered the rows in 'RewardReceiptItemList' where brandCode is not NULL

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

-- Result: BEN AND JERRY'S brand has the most spend among users who were created within the past 6 months


-- Question 4:
-- Which brand has the most transactions among users who were created within the past 6 months?

-- Joined Receipts with RewardReceiptItemList tables using id column as the key
-- Joined Users and Receipt tables using 'id' & 'userId' respectively as the keys
-- Used DATEADD function to filter the users created within the past 6 months from the MAX (most recent) createdDate in the users table
-- Used count of 'id' from Receipts table  and grouped by brandCode to calculate number of transactions for each brand
-- brandCode column has multiple NULL values, hence only considered the rows in 'RewardReceiptItemList' where brandCode is not NULL

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

--Result: HY-VEE brand has the most transactions among users who were created within the past 6 months








