# KMS-Inventory-Analysis
This repository contains files relevant to the analysis of the KMS inventory dataset as part of my capstone project while training at Incubator Hub

## Company Overview
Kultra Mega Stores (KMS), headquartered in Lagos, specialises in office supplies and furniture. Its customer base includes individual consumers, small businesses (retail), and large corporate clients (wholesale) across Lagos, Nigeria.

## Aim
My task as a Business Intelligence Analyst was to support the Abuja division of KMS by analysing the [Excel data file](https://github.com/judeonuh/KMS-Inventory-Analysis/blob/main/KMS%20Sql%20Case%20Study.csv) (containing order data from 2009 to 2012) provided by the Business Manager, using SQL.

## 📁 Table of Contents
- [Company Overview](#company-overview)
- [Aim](#aim)
- [Introduction](#introduction)  
- [Data Overview](#data-overview)  
- [Methodology](#methodology)
- [Data Cleaning](#data-cleaning)
- [Analysis, Insights & Recommendations](#analysis-,-insights-&-recommendations)  
  - [1. Highest Sales Product Category](#1-highest-sales-product-category)  
  - [2. Top & Bottom Regions by Sales](#2-top--bottom-regions-by-sales)  
  - [3. Appliances Sales in Ontario](#3-appliances-sales-in-ontario)  
  - [4. Revenue Growth Recommendations for Bottom 10 Customers](#4-revenue-growth-recommendations-for-bottom-10-customers)  
  - [5. Shipping Cost by Method](#5-shipping-cost-by-method)  
  - [6. Most Valuable Customers & Typical Purchases](#6-most-valuable-customers--typical-purchases)  
  - [7. Top Small Business Customer](#7-top-small-business-customer)  
  - [8. Top Corporate Customer by Orders](#8-top-corporate-customer-by-orders)  
  - [9. Most Profitable Consumer Customer](#9-most-profitable-consumer-customer)  
  - [10. Returned Items by Customer & Segment](#10-returned-items-by-customer--segment)  
  - [11. Appropriateness of Shipping Costs Based on Order Priority](#11-appropriateness-of-shipping-costs-based-on-order-priority)  
- [Overall Recommendations](#overall-recommendations)  
- [Conclusion](#conclusion)  

---

## Introduction
This analysis explores KMS's historical order data from 2009 to 2012 to identify key business insights and operational improvement opportunities for the Abuja division. The focus areas include sales performance, customer profitability, shipping efficiency, and region-specific performance.

---

## Data Overview
- **Source:** KMS Order Dataset (2009-2012)  
- **Data Points:** Order Priority,	Order Quantity,	Sales,	Discount,	Ship Mode,	Profit,	Shipping Cost,	Region,	Customer Segment,	Product Category, Returns, etc.  

---

## Methodology
- Data imported into and queried in SQL Server Management Studio (SSMS) using **SSMS-compliant SQL queries**.  
> [!WARNING]
> When importing the dataset into your created SSMS database:
> *  Change the datatypes of Row_ID and Order_ID column to Integer.
> *  Allow nulls for columns: Unit_Price, Profit, and Product_Base_Margin.
- Aggregations performed for sales, profits, shipping costs, and order counts.  
- Customer segmentation based on sales performance and return behavior.  
- Shipping method analysis performed in relation to order priority levels.  

---

## Data Cleaning  
The Dataset was checked for duplicates, none found. Null values were replaced with 0

---

## Analysis, Insights & Recommendations

### 1. Highest Sales Product Category
Technology products significantly contribute to overall revenue with total sales of $5,984,248.18.  
**Recommendation:**  
- Increase inventory levels for high-demand technology products.  
- Explore exclusive technology product deals or partnerships.  

---

### 2. Top & Bottom Regions by Sales
**Top 3 Regions by Total Sales:**  
- West: $3,597,549.27  
- Ontario: $3,063,212.48  
- Prarie: $2,837,304.61  

**Bottom 3 Regions by Total Sales:**  
- Nunavut: $116,376.48  
- Northwest Territories: $800,847.33  
- Yukon: $975,867.38  

**Insight:** Sales seem to be concentrated in West and Ontario; northern territories significantly underperform.  
**Recommendation:**  
- Targeted marketing campaigns in underperforming regions like Nunavut.  
- Assess product relevance and accessibility in those regions.  

---

### 3. Appliances Sales in Ontario
With a total sales $3,063,212.48, there appears to be a Strong demand for appliances in Ontario.  
**Recommendation:**  
- Maintain appliance stock levels and offer bundle promotions in Ontario.  
- Explore similar strategies in regions with comparable demographics.  

---

### 4. Revenue Growth Recommendations for Bottom 10 Customers
**Recommendation:**  
- Personalized offers and incentives.  
- Conduct satisfaction surveys to identify issues.  
- Introduce loyalty programs or product bundles.  

---

### 5. Shipping Cost by Method
A total of $51,971.94 was spent on shipping via delivery trucks. Though economical, delivery trucks are slow; and high reliance on them may affect service levels.  
**Recommendation:**  
- Optimize shipping method selection based on order priority.  
- Educate staff on appropriate shipping choices.  

---

### 6. Most Valuable Customers & Typical Purchases
| Customer           | Total Sales | Typical Purchase |  
|--------------------|-------------|------------------|  
| Emily Phan         | 117,124.44  | Technology       |  
| Deborah Brumfield  | 97,433.13   | Technology       |    

The Table above shows that KMS' top customers show strong preference for technology products.  
**Recommendation:**  
- Provide VIP incentives (discounts, loyalty cards, etc.) for these customers.  
- Offer early access to new technology products.  

---

### 7. Top Small Business Customer
Dennis Kane is the top small business customer with a total sales of $75,967.59, making him a High-value small business customer.  
**Recommendation:**  
- Establish long-term business relationship with Dennis Kane.  
- Explore upselling opportunities.  

---

### 8. Top Corporate Customer by Orders
**Customer:**   
Between 2009 and 2012, Adam Hart placed the highest number of orders (27 Orders) as a Corporate Customer.  
**Recommendation:**  
- Offer corporate discounts or service level agreements.  
- Explore business expansion with Adam Hart.  

---

### 9. Most Profitable Consumer Customer
Emily Phan is KMS' most profitable consumer customer with a total profit contribution of $34,005.44  
**Recommendation:**  
- Reward Emily with loyalty incentives.  
- Seek product feedback to enhance offerings.  

---
### 10. Returned Items by Customer & Segment

```SQL
SELECT 
	DISTINCT k.Customer_Name,
	k.Customer_Segment,
	COUNT(o.Order_ID) AS Total_Returned
FROM KMS_tb AS k
Inner Join Orders_tb AS o
	ON k.Order_ID = o.Order_ID
WHERE o.Status = 'Returned'
GROUP BY k.Customer_Name, k.Customer_Segment
ORDER BY Total_Returned DESC;
```

Query Result: 

| Customer         | Segment     | Total Returns |  
|------------------|-------------|----------------|  
| Darren Budd      | Consumer    | 10             |  
| Erin Creighton   | Corporate   | 10             |  
| Olvera Toch      | Home Office | 8              |  

**Insight:** There appears to be high return rates across most segments. This points to potential quality or service issues.  
**Recommendation:**  
- Investigate reasons for returns.  
- Implement quality control measures.  
- Provide customer service follow-ups.  

---

### 11. Appropriateness of Shipping Costs Based on Order Priority
**Findings:**  
- High & Critical orders often shipped via slow, economical methods (Delivery Truck).  
- Low-priority orders sometimes shipped via expensive Express Air.  

**Insight:** Shipping method selection is inconsistent with order urgency, risking customer dissatisfaction.  
**Recommendation:**  
- Enforce shipping method policy based on order priority:  
  - **Express Air:** Only for High & Critical orders.  
  - **Delivery Truck:** Only for Low & Not Specified orders.  
  - **Regular Air:** For Medium-priority or justified urgent backups.  
- Automate shipping selection within ordering system.  
- Conduct staff training and monitor compliance.  

---

## 📈 Overall Recommendations
- Expand focus on technology products.  
- Address underperformance in specific regions.  
- Strengthen relationships with top customers.  
- Improve shipping efficiency based on order priority.  
- Investigate product returns and enhance quality control.  

---

## ✅ Conclusion
This analysis highlights key areas where KMS can improve operational efficiency, revenue generation, and customer satisfaction. By implementing the outlined recommendations, KMS Abuja can strengthen market presence and optimize business processes.
"""
