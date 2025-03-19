# Flight Price Analysis & Insights

![Flight Data Analysis](https://raw.githubusercontent.com/Barsax22/Flight-Price-Analysis/main/Flight%20Data%20Analysis%20&%20Insights.png)


## Description
This project focuses on analyzing flight prices and flight data to extract key insights. The data was scraped from Kayak using **Python (Selenium)** and cleaned using **SQL**. The cleaned data was then visualized in **Tableau** to explore trends in flight prices, stop distribution, and the most popular airlines.

The project includes the following key stages:
1. **Web Scraping**: Flight data was scraped from the Kayak website using Python with **Selenium** and stored in a CSV file.
2. **Data Cleaning**: The raw data was cleaned and preprocessed using SQL to remove duplicates, handle missing values, and organize the data for analysis.
3. **Data Visualization**: The cleaned data was imported into Tableau for visualization, focusing on the top 10 airlines, average daily flight prices, and the distribution of flight stops.

## Files Included
- **flight_data_analysis.sql**: SQL script used to clean and preprocess the flight data. This script handles tasks such as removing duplicates, dealing with missing values, and organizing the data for analysis.
- **Flights Overview.twb**: Tableau workbook containing visualizations of the flight data, providing insights into the scraped data.
- **CSV File (Flight Data)**: The raw flight data collected through web scraping and saved in CSV format. This file contains information such as flight prices, departure times, arrival times, and destinations. The data was collected using **Python (Selenium)** within a **Jupyter Notebook**.

## Setup Instructions
1. **Web Scraping**:
   - The flight data was scraped from the Kayak website using Python with the **Selenium** library within a **Jupyter Notebook**. You can access the scraping code and rerun the process on the [GitHub repository](https://github.com/Barsax22/Flight-Prediction/tree/main).
   
2. **SQL Data Cleaning**:
   - After scraping the data, run the `flight_data_analysis.sql` script on your SQL database to clean and preprocess the data.
   - This script will remove duplicates, handle missing values, and prepare the data for analysis.

3. **Tableau Visualization**:
   - Open the `Flights Overview.twb` Tableau workbook to explore the visualizations of the flight data.
   - This file provides insights into the flight prices, times, and other trends based on the cleaned data.

## Key Insights
- **Top 10 Airlines**: Insights into the most popular airlines based on the number of flights.
- **Flight Prices**: Visualizations of average flight prices for various airlines, with trends over time.
- **Flight Stop Distribution**: Breakdown of the types of flights (direct vs. flights with stops) for each airline.
- **Price Trends**: Analysis of how flight prices fluctuate over time, including periods of low and high prices.

## Technologies Used
- **Python**: Web scraping with **Selenium** in a **Jupyter Notebook**.
- **SQL**: Data cleaning and preprocessing.
- **Tableau**: Data visualization and insights extraction.

## License
The data used in this project was collected from Kayak via web scraping. As the dataset is publicly available on the web, it is intended for educational and personal use only. Please refer to Kayak's Terms of Service for any restrictions on scraping or using their data.

## Contributions
Feel free to fork this repository, make improvements, or contribute additional analysis. Contributions are welcome!
