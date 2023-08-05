# GauravChandra's Portfolio-Projects

# [Project 1: Covid 19 Deaths and Vaccinations Excel+SQL+Tableau Project](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Covid19%20(sql%2Btableau))
This is my major tableau project, where I have built two dashboards with interactive visualizations on the covid 19 data set

You can download the required dataset from the following website-> [https://ourworldindata.org/covid-deaths](https://ourworldindata.org/covid-deaths)

## Procedure 
### Step 1. Using Excel for basic Data Cleaning steps
* In this initial step, I've dropped some unnecessary fields from the .csv file .
* Then I've Divided the original dataset into two .csv files :
1. CovidDeaths.csv
2. CovidVaccinations.csv

You can find these datasets here- [Input Dataset](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Covid19%20(sql%2Btableau)/Dataset%20excel%20files).

(here along with csv of deaths and vaccinations data ,I've also added the excel xlsx files for them too, So that one can easily import the data from them on Microsoft SQL server)

### [Step 2: Data Cleaning by MySQL- Covid19 query.sql](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Covid19%20(sql%2Btableau)/Covid19%20query.sql)

* In this step I've performed some basic operations and functions so that data can be easily explored and visualized by Tableau.
* I've also used CTEs , Views and stored procedures in this step .
* Then, I have extracted 7 sub .csv files which has the output data table executed using the sql query
  [Output Excel files](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Covid19%20(sql%2Btableau)/Output%20excel%20files)
* I have also added a sql report too, Which includes all the queries that I've run on sql with the output too.
  [covid 19 sql report](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Covid19%20(sql%2Btableau)/covid_sql_report.pdf)
  
### [Step 3: Covid19 Deaths and Vaccination Dashboard](https://public.tableau.com/app/profile/gaurav.chandra8195/viz/Covid19DeathsandVaccinationDashboard/DashboardDeath#1)

* By using these 7 csv files extracted by SQL, I've visualized them using 2 dashboards for Covid Deaths and Vaccinations.
* Glimpse to that dashboard->
![Dashboard Death](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/7540b39b-8cb2-4eb8-85ad-5669e36285dc)
![Dashboard Vaccination](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/b60e9947-1bd7-47c8-b495-223670684b58)
I've also added these two dashboards in a single pdf too [Covid Tableau Dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Covid19%20(sql%2Btableau)/Covid%2019%20Tableau%20Dashboard.pdf)
Do Check this out

# [Other Tableau Dashboards]
Here, I am adding the Tableau Public links for my other Tableau Projects.One can click to get to my Tableau Public Profile

[Netflix Tableau Dashboard](https://public.tableau.com/app/profile/gaurav.chandra8195/viz/netflixdashboard_16899262255820/Netflix)
[dataset of netflix](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/netflix_titles.csv)
![Netflix](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/9cd70950-b8ab-4cf3-88e4-d17438f42e34)

[Sales Tableau Dashboard](https://public.tableau.com/app/profile/gaurav.chandra8195/viz/salesdashboard_16900314112260/salesdashboard)
![sales dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/534a3e8d-7fd6-4872-ac62-861500e5ce89)
[dataset of sales](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Sales%20Data.xls)
# [Project 2: HR Analytics SQL+PowerBi Project](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/HR%20analytics%20(sql%2Bpowerbi))
This is my major PowerBI project ,Here I have built a report of Employees Attrition of a company,

Here as a problem, I have the data of all the employees of the company, using this data I have analysed the attrition rate of employees ,and then in this report I have tried to
draw some insights about the attrition and also tried to find out the possible cause of attrition of employee and what we can do to fix it.

* Data was taken from the [kaggle dataset](https://www.kaggle.com/datasets/rishikeshkonapure/hr-analytics-prediction).
* The dataset: [Uncleaned Data set](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/HR%20analytics%20(sql%2Bpowerbi)/data%20set)
* The project is mainly based on Sql(Microsoft SQL server) and PowerBI.
  
## Procedure 
### [Step 1. Using SQL for basic data cleaning and operations -HR Analytics.sql](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/HR%20analytics%20(sql%2Bpowerbi)/HR_analytics.sql)
* In this initial step, I've added a new column for attrition value,removed the unwanted column and duplicated from the input csv file .
* Then I've created views of tables of Attrition vs other factors, in order to draw insights and to use those in my dashboard for visualizations,some of those views are:
1. Attrition vs Age
2. Attrition vs Gender
3. Attrition vs Job role , Salary ,Education field , number of years at company etc.

* I have also added a sql report too, Which includes all the queries that I've run on sql with the output too.
  [HR analytics sql report](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/HR%20analytics%20(sql%2Bpowerbi)/HR%20ANALYTICS%20PROJECT%20SQL%20REPORT.pdf)
  
### [Step 2: HR Analytics PowerBI Dashboard and Report](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/HR%20analytics%20(sql%2Bpowerbi)/HR_Analytics_Dashboard%2BReport.pdf)

* By importing these views in PowerBI created in Microsoft SQL server,I have then prepared a 4 page report that includes 2 dashboards and then 2 pages for predicting the cause of attrition and solution to it
* In this advance PowerBI report ,I have added navigation buttons and a presentation mode button which shows the charts one by one .
* Glimpse to that dashboard->Do Check this out
![HR_Analytics_Dashboard+Report_page-0001](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/5ce3dd13-3459-478b-9e92-ad640846b52f)
![HR_Analytics_Dashboard+Report_page-0003](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/5e7214d3-c9a5-4b75-8cca-d9b23b7b4b1d)
![HR_Analytics_Dashboard+Report_page-0002](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/121764d5-c35d-479a-b4ba-da379fadf1f7)
![HR_Analytics_Dashboard+Report_page-0004](https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/b3e30484-d899-4372-88e7-fd1b39415151)

I've also added this report in a single pdf too [HR Analytics Report](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/HR%20analytics%20(sql%2Bpowerbi)/HR_Analytics_Dashboard%2BReport.pdf)

# [Project 3: Car Price Prediction Regression Model using Scikitlearn library in Python](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Car_Price_Model%20(Python))

This is my major Python project on Data Cleaning, Visualizing and Data Modelling ,Here I have prepared a regression model based on the data of various cars to predict the price of some new cars that can be added to the dataset

This project can help out in solving various kinds of real life problems, Here we have a dataset of various car's features and its prices.
And if a user wants to sell out his car ,then this model can help the user to put a price on a car that is well justified for the features the car has

* The dataset: [Uncleaned Data set](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Car_Price_Model%20(Python)/car_data_uncleaned.csv)
* The project is mainly based on Pandas ,Matplotlib ,Seaborn and Scikit-Learn Libray of Python.
  
## Procedure 
### [Step 1. Using Pandas to clean the dataset - Data Cleaning.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Car_Price_Model%20(Python)/Data_Cleaning.ipynb)

* In this initial step, I have cleaned the dataset using Pandas library of Python.
* The jupyter lab above includes all the steps with explanation and comments of data cleaning.
* Finally I have created a new cleaned csv using the pandas. [Car_data_cleaned](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Car_Price_Model%20(Python)/car_data_cleaned.csv)

### [Step 2: Exploratory Data Analysis -EDA.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Car_Price_Model%20(Python)/Exploratory_Data_Analysis.ipynb)

* Here in this step ,I have analysed and visualized the cleaned dataset using pandas, Matplotlib and Seaborn libraries.
* Using this step ,I have analysed the set of important features of cars which can be used to develop a price prediction model.
* I have used Correlation ,Heatmaps ,Regression plots and Box plots to analyse the dependence of price on various features.

### [Step 3: Model Development -Model.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Car_Price_Model%20(Python)/Model_Development.ipynb)
* Here in this final step ,I have prepared linear ,multiple and polynomial regression models.
* I have prepared a Training and Testing subset from our dataset and then using the MeanSquareError Test and R square test, I chose the best model out of all.
* Used Distribution plots,Residual plots ,Ridge Regresion and pipeline to finalize the model
* Final conclusion : For our dataset, the best model is a second order polynomial multi regeression fit model using the following 7 features of cars:-
 1. Horsepower
 2. Curb-weight
 3. Engine-size
 4. Highway-L/100km
 5. length
 6. width
 7. city-L/100km

# [Project 4: Flipkart Products Web Scrapping using BeautifulSoup library in Python](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Flipkart%20Product%20Web%20Scapping%20(Python))
This is my major BeautifulSoup Project,Here I have prepared a Python program that can extract the details of any kind of prducts available in Flipkart ,A famous Indian E-commerce shopping website
the details of the projects are as follows :

 [The jupyter lab for this project](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Flipkart%20Product%20Web%20Scapping%20(Python)/Flipkart_smartphone_webscrapping.ipynb)
* Here In this lab I have shown the various kinds of steps that the python file for webscrapping would include.
  
 [The python program for webscrapping](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Flipkart%20Product%20Web%20Scapping%20(Python)/Flipkart_smartphone_webscrapping.py)
* In this particular program, I have scraped the data for Iphones ,one can do the same for any product by just adding the name of product on the last line of python .py file .
* Using this webscrapping program ,I have scraped the data of all of the Iphones of various types ,colors, storage etc.
* [The output iphone csv file](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Flipkart%20Product%20Web%20Scapping%20(Python)/iphone_data.csv)
* It includes
  1. Name of Product
  2. Sale price of Product
  3. Original price of Product
  4. Ratings out of 5 of product
  5. Number of ratings and reviews of the product
  6.The date on which the data has been extracted

# [Project 5: Car Recession Python Web Dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Automobile%20Recession%20(Python%20Dashboard))

This is a project that I have done during my IBM Data Visualization with python course.
In this project ,I analysed a dataset of Car prices during Recession years from 1980 to 2020.
* The dataset: [Uncleaned Data set](https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DV0101EN-SkillsNetwork/Data%20Files/historical_automobile_sales.csv)
* The project is mainly based on Pandas ,Matplotlib ,Seaborn and Folium in Python.
  
## Procedure 
### [Step 1. Python Data Visualization-visualization.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Automobile%20Recession%20(Python%20Dashboard)/Automobile%20Recession%20analysis.ipynb)

* In this initial step, I have performed various tasks that are given to visualize the dataset like line,scatter,bar,pie charts and maps.
* The jupyter lab above includes all the steps with explanation and comments of data cleaning.
  
### [Step 2: Python Web Dashboard using Dash and Plotly](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Automobile%20Recession%20(Python%20Dashboard)/Automobiles_Recession_Dash.py)

* Here in this step ,I have developed an interactive web based dashboard using Dash and Plotly
* Here i am adding the screenshots of the web dashboard.
  <img width="708" alt="Screenshot 2023-07-28 161856" src="https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/5fd67d7e-7998-4669-b0fc-a5eb66868bef">

# [Project 6: Australian Wildfire Python Web Dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Australian%20Wildfire%20dashboard%20(Python))

This is an another project that I have done during my IBM Data Visualization with python course.
In this project ,I analysed a dataset of Wildfire of Australia .
* The dataset: [Uncleaned Data set](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Australian%20Wildfire%20dashboard%20(Python)/Historical_Wildfires.csv)
* The project is mainly based on Pandas ,Matplotlib ,Seaborn and Folium in Python.
  
## Procedure 
### [Step 1. Python Data Visualization-visualization.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Australian%20Wildfire%20dashboard%20(Python)/wildfire-australia.ipynb)

* In this initial step, I have performed various tasks that are given to visualize the dataset.
* The jupyter lab above includes all the steps with explanation and comments of data cleaning.
  
### [Step 2: Python Web Dashboard using Dash and Plotly](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Australian%20Wildfire%20dashboard%20(Python)/Australia_Wildfire_Dash.py)

* Here in this step ,I have developed an interactive web based dashboard using Dash and Plotly
* Here i am adding the screenshot of the web dashboard.
 <img width="866" alt="image" src="https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/5ba3fa08-35a9-4efb-963c-cf8047d30d20">


# [Project 7: Data cleaning using SQL- Nashville Housing Data](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Housing%20cleaning%20(sql))

* Dataset: [Nashville Housing Data for Data Cleaning.xlsx](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Housing%20cleaning%20(sql)/Nashville%20Housing%20Data%20for%20Data%20Cleaning.xlsx)
* I've cleaned this dataset by using Microsoft SQL Server.
* Splitted the addresse column into address & city columns
* Atlast, deleted unused columns in the given dataset.
  Here is the final sql report of this project which includes the sql query with its output screenshots merged together [Housing Data sql report](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Housing%20cleaning%20(sql)/NASHVILLE%20HOUSING%20DATA.pdf)

# [Project 8: Data Analysing using SQL- Music Store Dataset](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/music_store_database%20(sql))
This project is a sql based project, Here I have used Postgree SQL.
* Dataset: [Music Store Data](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/music_store_database%20(sql)/music%20store%20data)
* In this project I have put my SQL knowledge into use to answer some of the questions related to the dataset.
  [The SQL queries along with output](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/music_store_database%20(sql)/MUSIC%20STORE%20SQL%20PROJECT%20REPORT.pdf)

# [Project 9: Crypto DataPull using API in Python](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Crypto%20data%20pull)
In this project , I have developed a program to pull crypto data using API and then produce some basic visualizations using matplotlib and seaborn.

[Crypto Data Pull .py Program](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Crypto%20data%20pull/crypto%20api.py)
* At the end of the python program , I created a csv file using pandas.
  [API.csv](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Crypto%20data%20pull/API.csv)
* Also I have created a jupyter lab file to create some basic visualizations using python.
  [Crypto_data_viz.ipynb](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Crypto%20data%20pull/Crypto_data_viz.ipynb)

# [Project 10: Excel Dashboard Project](https://github.com/GauravChandraMasiwal/Portfolio-Projects/tree/master/Excel%20dashboard%20projects)
I have developed two excel based dashboard too
1. [Vrinda Store Dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Excel%20dashboard%20projects/Vrinda%20Store%20Data%20Analysis.xlsx)
   <img width="884" alt="image" src="https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/eca28982-934d-437e-ba61-d788e8a7bc3f">
   
2. [Biking Sales Basic Dashboard](https://github.com/GauravChandraMasiwal/Portfolio-Projects/blob/master/Excel%20dashboard%20projects/Biking%20Sales%20Dataset%20Dashboard%20(Excel).xlsx)
   <img width="597" alt="image" src="https://github.com/GauravChandraMasiwal/Portfolio-Projects/assets/127219072/ae89d26a-914d-4995-9c27-5d54f6749373">




