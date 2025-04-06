# Target Brazil E-commerce SQL Analysis (2016-2018)

## Project Overview

This project analyzes a dataset of 100,000 orders placed on Target's Brazil platform between 2016 and 2018. The goal was to extract valuable insights into order trends, customer distribution, economic impact, logistics, and payment methods using SQL, and to provide actionable recommendations based on the findings.

## Business Context

Target is a major US retailer. This analysis focuses on its e-commerce operations in Brazil, utilizing a dataset covering orders, customers, sellers, products, payments, shipping, and reviews to understand performance and identify areas for improvement.

## Problem Statement

Analyze the provided dataset to understand Target's Brazil e-commerce operations. Key areas include:
* Initial data exploration (structure, time range, customer geography).
* In-depth exploration of order trends (yearly/monthly seasonality, time of day).
* Evolution of orders across Brazilian states.
* Economic impact (order costs, freight values).
* Logistics analysis (delivery times vs. estimates).
* Payment analysis (preferred methods, installments).
* Derive actionable insights and recommendations.

## Dataset

The analysis uses 8 CSV files representing different aspects of the e-commerce operation:
* `customers.csv`
* `order_items.csv`
* `geolocation.csv`
* `order_payments.csv` 
* `order_reviews.csv`
* `orders.csv`
* `payments.csv`
* `products.csv`
* `sellers.csv`

## Dataset schema:

![image](https://github.com/user-attachments/assets/6087fa7e-6597-41a5-b2a8-353d68633482)

## Repository Structure

```text
Target-Brazil-SQL-ECommerce-Analysis/
├── analysis_report/
│   └── Target_Brazil_Analysis_Report.pdf
├── dataset/
│   ├── customers.csv
│   ├── geolocation.csv
│   ├── order_items.csv
│   ├── order_payments.csv
│   ├── order_reviews.csv
│   ├── orders.csv
│   ├── payments.csv
│   ├── products.csv
│   └── sellers.csv
├── sql_queries/
│   ├── 01_initial_exploration.sql
│   ├── 02_in_depth_exploration.sql
│   ├── 03_evolution_of_ecommerce.sql
│   ├── 04_impact_on_economy.sql
│   ├── 05_sales_freight_delivery_analysis.sql
│   └── 06_payment_analysis.sql
├── LICENSE
└── README.md
```

## Key Insights

* **Order Growth:** There was a significant increasing trend in the number of orders year-over-year from 2016 to 2018, with a massive jump in orders in 2017 compared to 2016, and continued growth into 2018.

* **Seasonality:** Clear monthly seasonality exists, with order peaks often correlating with holiday shopping seasons (like November) and promotional events. Orders were most frequently placed in the afternoon.

* **Geographic Distribution:** Customers are widely distributed across 27 states and over 4,000 cities, with a high concentration in São Paulo state, accounting for approximately 42% of unique customers, followed by Rio de Janeiro and Minas Gerais. Some states, such as Acre, Amapá, and Roraima, have very low customer density.

* **Economic Impact:** The total cost of orders grew substantially between January-August 2017 and January-August 2018. Freight costs vary significantly by state, with remote states like Roraima and Paraíba having the highest average freight values, while high-volume states like São Paulo have lower average freight but the highest total freight value.

* **Delivery Performance:** Average delivery times vary greatly across states. Some states show significantly faster actual delivery compared to estimated times, while others may experience delays. States with the fastest absolute average delivery times include São Paulo, Paraná, Minas Gerais, Distrito Federal, and Santa Catarina, whereas states like Roraima, Amapá, and Amazonas had the slowest absolute average delivery times. There appears to be a contradiction regarding the fastest and slowest states by absolute time that may need clarification.

* **Payment Methods:** Credit cards are the most popular payment method, with growing usage of UPI. Most customers prefer single payment installments, although multi-installment plans, especially 8 or 10 installments, are also used, potentially linked to promotions.
## Recommendations

1.  **Enhance Regional Marketing & Customer Engagement:**
    * Focus tailored marketing campaigns on high-volume states (SP, RJ, MG).
    * Develop targeted outreach or incentives for regions with low customer density (AC, AP, RR) to boost engagement.
2.  **Leverage Seasonal Trends:**
    * Optimize inventory and staffing for peak periods like holiday seasons (e.g., November).
    * Align promotions and discounts strategically with observed purchasing behavior during peak months.
3.  **Streamline Logistics & Delivery Operations:**
    * Analyze and address the significant variations in average delivery times across states. Investigate best practices in faster states (like SP, PR, MG per insight) and apply them to slower regions.
    * Address high average freight costs in states like RR, PB, RO by negotiating better rates or optimizing routes.
4.  **Optimize Payment Processes:**
    * Enhance the digital payment experience, focusing on the popular credit card method and growing UPI usage. Ensure security and user-friendliness.
    * Review installment options. While single payments are preferred, consider flexible options or promotions for multi-installment plans, especially for high-value items.
5.  **Use Data-Driven Insights for Continuous Improvement:**
    * Regularly monitor KPIs (order volumes, freight, delivery times) to make agile adjustments to strategies.
    * Integrate qualitative customer feedback (reviews) with quantitative data for a holistic view to refine products and services.

## Tools Used

* **Database/Querying:** Google BigQuery (SQL)
* **Reporting:** PDF (Microsoft Word)

## License
[MIT License](LICENSE) 
