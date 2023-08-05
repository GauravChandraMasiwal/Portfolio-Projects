#CRYPTO DATA PULL USING API
#CREATED BY GAURAV CHANDRA

# Importing Required Libraries :
 
import pandas as pd
import os

from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json

from time import time
from time import sleep

pd.set_option('display.max_columns',None)

'''
This Function is for pulling the data out of our website using the API,Also here we'll be writing the data into a csv file,
which will further be used for data cleaning and visualization purposes 

'''
def crypto_api():
    global df
    url = 'https://pro-api.coinmarketcap.com./v1/cryptocurrency/listings/latest'
    parameters = {
      'start':'1',
      'limit':'20',   #Here the limit is set to 20,as we have a lot of cryptocurrencies ,but ranking-wise we have limit the data to the top 20 currencies.
      'convert':'USD'    #The limit is set so that we won't run into some issues while visualising the data.
    }
    headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': 'b5d468c5-d3f8-4840-86e0-79fb5e6527c0',
    }

    session = Session()
    session.headers.update(headers)

    try:
      response = session.get(url, params=parameters)
      data = json.loads(response.text)
      #print(data)
    except (ConnectionError, Timeout, TooManyRedirects) as e:
      print(e)
    
    df=pd.json_normalize(data['data'])
    df['time_stamp']=pd.to_datetime('now',utc=True)  #We have added a new column to the data for displying the date-time of the instant when the data is pulled.

    df.drop(columns=['slug','tags','max_supply','infinite_supply','platform','self_reported_circulating_supply',
    'self_reported_market_cap','tvl_ratio','quote.USD.tvl','platform.id','platform.name' ,'platform.symbol' ,
    'platform.slug','platform.token_address'],inplace=True)

    #This is for writing the data into a csv file
    if not os.path.isfile(r'D:\gaurav_data_analyst\python\Crypto data pull\API.csv'):
        df.to_csv(r'D:\gaurav_data_analyst\python\Crypto data pull\API.csv',header='column_names')
    else:
        df.to_csv(r'D:\gaurav_data_analyst\python\Crypto data pull\API.csv',mode='a',header=False)
        
    
        
#This is for automating the process 
for i in range(333):  #We have given a limit for the data pulling by the API website which is 333 for a day.
    crypto_api()
    print("CRYPTO API EXECUTED SUCCESSFULLY")
    sleep(60) #every 10mins
exit()

