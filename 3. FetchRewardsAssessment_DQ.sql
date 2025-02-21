-- Third: Evaluate Data Quality Issues in the Data Provided

-- 1. JSON Files: 
--    Date format in json files is in epoch time format (Unix Time stamp)

-- 2. Found brandcodes in RewardReceiptItems table which are not present in brands table and vice versa. 
--    Considering Brands as the dimension table, all of the brandcodes in RewardReceiptItems table should be present in Brands table.
--	  Significant amount of data will be missing when we query between Brands & RewardReceiptItems tables using joins.

Select distinct brandcode from RewardReceiptItemList order by brandcode;
Select distinct brandcode from Brands order by brandcode;

Select distinct b.brandcode, ri.brandcode 
from RewardReceiptItemList ri inner join Brands b
on ri.brandCode = b.brandcode;

Select distinct b.brandcode, ri.brandcode 
from RewardReceiptItemList ri left join Brands b
on ri.brandCode = b.brandcode;

Select distinct b.brandcode, ri.brandcode 
from RewardReceiptItemList ri right join Brands b
on ri.brandCode = b.brandcode;

-- 3. Duplicate records in the Users table were removed before importing data from csv into SQL Server.

-- 4. Data Consistency issues for categorical (text) columns.

--	  For example: 
--    a. name and brandCode columns in Brands table have somewhat similar data (differs in case). Also, brandcode contains more Null values as compared to name column.
--       createdDate & dateScanned and finishedDate & modifyDate in Receipts table have somewhat same data.

Select name, brandcode from Brands;
Select createDate, dateScanned from Receipts;
Select finishedDate, modifyDate from Receipts;

--	  b. In category & categoryCode columns we can merge categories if possible like Dairy - Dairy & Refrigerated, Beauty - Beauty & Personal Care. 
--	     We can make the data consistent in both columns by changing the case and can fill NULL values in categoryCode by referencing data in category column in Brands table.

Select distinct category, categoryCode from Brands;
Select distinct name, brandCode from Brands;

--    c. The ReceiptItemsList table contains approximately 20 columns, with over 80% of the data in these columns being NULL. Since these are mostly NULL, would like to understand the purpose of these columns where are they used?
--    d. Some boolean columns have NULL values.
--       > needsFetchReview,userFlaggedNewItem,competitiveProduct in RewardReceiptItems 
--       > topBrand from Brands

Select needsFetchReview,userFlaggedNewItem,competitiveProduct from RewardReceiptItemList;
Select topbrand from Brands;

--    e. Some Barcodes(82) in RewardReceiptItems table are in text format.