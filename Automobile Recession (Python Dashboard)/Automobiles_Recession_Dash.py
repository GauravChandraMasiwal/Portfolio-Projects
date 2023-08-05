#PYTHON DASHBOARD FOR THE AUTOMOBILE RECESSION PROJECT
#CREATED BY GAURAV CHANDRA

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px 
import dash
import plotly.graph_objects as go
from dash import html, dcc
from dash.dependencies import Input,Output,State

app = dash.Dash(__name__)
URL = "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DV0101EN-SkillsNetwork/Data%20Files/historical_automobile_sales.csv"
df = pd.read_csv(URL)
year_list = [i for i in range(1980,2024,1)]

app.layout=html.Div(children=[html.H1('Automobile Sales Statistics Dashboard',style={'textAlign':'center','color':'#503d36','font-size':24}),
                              dcc.Dropdown(id= 'dropdown-statistics',options=[
                                  {'label':'Yearly Statistics','value':'Yearly Statistics'},
                                  {'label':'Recession Period Statistics','value':'Recession Period Statistics'}],placeholder='Select a report type',
                                style={'width':'80%','padding':'3px','font-size':'20px','textAlign':'center'}),
                              dcc.Dropdown(id='select-year',options=[{'label':year,'value':year}for year in year_list],
                                           placeholder='Select a year',
                                style={'width':'80%','padding':'3px','font-size':'20px','textAlign':'center'}),
                            html.Div([
                                html.Div(id='output-container',className='chart-grid')
                            ])
                              ])
                              
@app.callback(
    Output(component_id='select-year', component_property='disabled'),
    Input(component_id='dropdown-statistics',component_property='value'))
def update_input_container(value):
    if value =='Yearly Statistics': 
        return False
    else: 
        return True                        

@app.callback(
    Output(component_id='output-container', component_property='children'),
    [Input(component_id='select-year', component_property='value'), Input(component_id='dropdown-statistics', component_property='value')])
def update_output_container(input_year,value ):
    if value == 'Recession Period Statistics':
        # Filter the data for recession periods
        recession_data = df[df['Recession'] == 1]
         # Plot 1 : Automobile sales fluctuate over Recession Period (year wise)
         # grouping data for plotting
       
        yearly_rec=recession_data.groupby('Year')['Automobile_Sales'].mean().reset_index()
        # Plotting the line graph
        R_chart1 = dcc.Graph(
            figure=px.line(yearly_rec, 
                x='Year',
                y='Automobile_Sales',
                title="Average Automobile Sales for Recession Years"))
       
        ## Plot 2:Average number of vehicles sold by vehicle type using bar chart
        vehicle_rec = recession_data.groupby('Vehicle_Type',as_index=False)['Automobile_Sales'].mean()
        R_chart2 = dcc.Graph(
            figure = px.bar(vehicle_rec,x='Vehicle_Type',y='Automobile_Sales',text_auto='.2s',color='Vehicle_Type'
                            ,title='Average number of vehicles sold by vehicle type'))
        
        ## Plot 3 : Pie chart for total expenditure share by vehicle type during recessions
            # grouping data for plotting
        exp_rec= recession_data.groupby('Vehicle_Type')['Advertising_Expenditure'].sum().reset_index()
        R_chart3 = dcc.Graph(
                    figure=px.pie(exp_rec,
                    values='Advertising_Expenditure',
                 names='Vehicle_Type',
                 title="Total Expenditure share by vehicle type during recession periods"
                ))
        
        ## Plot 4:Effect of unemployment rate on vehicle type and sales using bar chart
        unemp_rec = recession_data.groupby(['unemployment_rate','Vehicle_Type'])['Automobile_Sales'].mean().reset_index()
        R_chart4 = dcc.Graph(
                    figure=px.bar(unemp_rec,x='unemployment_rate',y='Automobile_Sales'
                                  ,color='Vehicle_Type',text_auto='.2s',
                                  title='Effect of unemployment rate on vehicle type and its sales'
                                  ))
    
    elif value == 'Yearly Statistics':
        avg_sales = df.groupby('Year')['Automobile_Sales'].mean().reset_index()
        year_data = df[df['Year']==input_year]
        
        #plot1 : Yearly Average Automobile sales using line chart for the whole period.
        R_chart1 = dcc.Graph(
            figure = px.line(avg_sales,x='Year',y='Automobile_Sales',
                             title='Average Automobile Sales by Year for the whole period'))
        
        #plot2 : Total Monthly Automobile sales using line chart.
        tot_month = year_data.groupby('Month')['Automobile_Sales'].sum().reset_index()
        R_chart2=dcc.Graph(
            figure = px.line(tot_month,x='Month',y='Automobile_Sales',title="Total Monthly Automobile Sales per Month")
        )
        
        #plot3 : Average Monthly Automobile sales of each vehicle type using bar chart.
        avg_vehicle = year_data.groupby('Vehicle_Type')['Automobile_Sales'].mean().reset_index()
        R_chart3=dcc.Graph(
            figure = px.bar(avg_vehicle,x='Vehicle_Type',y='Automobile_Sales',text_auto='.2s',color='Vehicle_Type',title="Average Automobile Sales per Vehicle Type")
        )
        
        #plot4 : Total Advertisement Expenditure for each vehicle using pie chart
        total_exp = year_data.groupby('Vehicle_Type')['Advertising_Expenditure'].sum().reset_index()
        R_chart4=dcc.Graph(
            figure = px.pie(total_exp,names='Vehicle_Type',values='Advertising_Expenditure',title="Total Advertising Expenditure per Vehicle Type")
        )

    return [
            html.Div(className='chart-grid', children=[html.Div(children=R_chart1),html.Div(children=R_chart2)],style={'display': 'flex'}),
            html.Div(className='chart-grid', children=[html.Div(children=R_chart3),html.Div(children=R_chart4)],style={'display': 'flex'})
            ]
                              
                            


if __name__ == '__main__':
    app.run_server()