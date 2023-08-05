#FLIPKART PRODUCTS WEB SCRAPPING PROGRAM
#CREATED BY GAURAV CHANDRA

#Importing all the required libraries

import pandas as pd
from bs4 import BeautifulSoup
import numpy as np
import requests
import html5lib
from datetime import date
import os


#Function to get the name of the product
def get_title(soup):
    try :
        title = soup.find("span",attrs = {'class':'B_NuCI'}).text.strip()
        
    except AttributeError:
        title = ''
        
    return title

#Function to get the sale price of the product
def get_price_sale(soup):
    try :
        Price= soup.find("div",attrs = {'class':'_30jeq3 _16Jk6d'}).text.strip()
        price_sale = int(Price[1:].replace(',',''))
        
    except AttributeError:
        price_sale = 0
        
    return price_sale

#Function to get the original price of the product
def get_price_original(soup):
    try :
        Price = soup.find("div",attrs = {'class':'_3I9_wc _2p6lqe'}).text.strip()
        price_original = int(Price[1:].replace(',',''))
        
    except AttributeError:
        price_original = 0
        
    return price_original

#Function to get the ratings of the product
def get_rating(soup):
    try :
        rating = soup.find("div",attrs = {'class':'_3LWZlK'}).text.strip()
        
    except AttributeError:
        rating = ''
        
    return rating

#Function to get the ratings and reviews of the product
def get_rating_reviews(soup):
    try :
        r_r = soup.find("span",attrs = {'class':'_2_R_DZ'}).text.strip()
        
        split_list = r_r.split(' ',3)       #This will has the ratings and reviews splitted in between the spaces, as done in the exploratory analysis
        
        num_ratings = int(split_list[0].replace(',',''))        #num_ratings will hold the number of ratings as int datatype
        
        split_list_2 = split_list[1].split("&\xa0",2)
        
        num_reviews = int(split_list_2[1].replace(',',''))      #num_reviews will hold the number of reviews as int datatype
        
    except AttributeError:
        num_ratings,num_reviews = 0,0
        
    return [num_ratings,num_reviews]
    



#This is our main function which takes the empty dictionary of products , url of product & file name of output csv file as input parameter and 
#writes down the scrape data into a csv file of the given name in the specified location.

def smartphone_scrapper(dictionary,url,file_name):
    flip_url = "https://flipkart.com"
    
    Headers = ({'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', 'Accept-Language': 'en-US, en;q=0.5'})
    
    webpage = requests.get(url,headers = Headers)
    
    soup = BeautifulSoup(webpage.text,"html.parser")
    #Here,next_url basically stores the url of the next page ,
    next_url = soup.find_all('a',attrs = {'class':'_1LKTO3'})[-1]       #both next and previous link had the same class and attribute,  so next_url is only storing the last of them,which is next icon link
    next_url_text = next_url.get_text()
    
    #If next_url_text is equal to Next then i have created a recursive loop in which the function will be called again n again till the last page of product is reached
    if next_url != None and next_url_text == 'Next':
        next_url = next_url.get('href')  #This would get the link for the next page
        
        product_links = soup.find_all("a",attrs = {'class':'_1fQZEK'})  #This would store the links of all the products displayed in a single page
    
        links = []          #This would store the complete link of all the products
        
        for link in product_links :
            links.append(flip_url + link.get('href'))
         
        #This loop will store the title and other informations of each product in a single page scraped from the website in the input dictionary
        for link in links:
            new_webpage = requests.get(link,headers = Headers)  #We would create a new webpage of each of the products in the page
            soup_new = BeautifulSoup(new_webpage.text,'html.parser')
        
            dictionary['Product_Name'].append(get_title(soup_new))
            dictionary['Original_Price'].append(get_price_original(soup_new))
            dictionary['Sale_Price'].append(get_price_sale(soup_new))
            dictionary['Ratings_out_of_5'].append(get_rating(soup_new))
            dictionary['Number_of_Ratings'].append(get_rating_reviews(soup_new)[0])
            dictionary['Number_of_Reviews'].append(get_rating_reviews(soup_new)[1])
            dictionary['Date'].append(date.today())
        
        new_dictionary = dictionary.copy()
        
        print(len(new_dictionary['Product_Name']), " products extracted successfully")
        
        url = flip_url + next_url  #url will now have the url of the next page
        
        smartphone_scrapper(new_dictionary,url,file_name) #Now the whole process would start again but with the next page
    
    #When all the pages have been scraped successfully and now we are just left with the last page,
    # this section would run which would just scrape the last page and create a dataframe to store the output in a csv file 
    else : 
        product_links = soup.find_all("a",attrs = {'class':'_1fQZEK'})
    
        links = []
        new_dictionary = dictionary.copy()
        for link in product_links :
            links.append(flip_url + link.get('href'))
        
        for link in links:
            new_webpage = requests.get(link,headers = Headers)
            soup_new = BeautifulSoup(new_webpage.text,'html.parser')
        
            new_dictionary['Product_Name'].append(get_title(soup_new))
            new_dictionary['Original_Price'].append(get_price_original(soup_new))
            new_dictionary['Sale_Price'].append(get_price_sale(soup_new))
            new_dictionary['Ratings_out_of_5'].append(get_rating(soup_new))
            new_dictionary['Number_of_Ratings'].append(get_rating_reviews(soup_new)[0])
            new_dictionary['Number_of_Reviews'].append(get_rating_reviews(soup_new)[1])
            new_dictionary['Date'].append(date.today())
        
        print(len(new_dictionary['Product_Name']), " products extracted successfully")
        global flipkart_df
        flipkart_df = pd.DataFrame.from_dict(new_dictionary)
        
    
        if not os.path.isfile(r'D:\gaurav_data_analyst\Flipkart Product Web Scapping (Python)'+file_name):   #If file doesn't exist then we'll create one with headers but no index
            flipkart_df.to_csv(r'D:\gaurav_data_analyst\Flipkart Product Web Scapping (Python)'+file_name,index=False)
        else:                                                                               #If file already exists then we'll append the data with no headers and indexes
            flipkart_df.to_csv(r'D:\gaurav_data_analyst\Flipkart Product Web Scapping (Python)'+file_name,mode='a',header=False,index=False)
        print('csv file for data is created!')
        
def output_csv_producer(product):
    dictionary_product = {'Product_Name':[],'Original_Price':[],'Sale_Price':[],'Ratings_out_of_5':[],'Number_of_Ratings':[],'Number_of_Reviews':[],'Date':[]}

    file_name = '\{}_data.csv'.format(product)
    url_product = 'https://www.flipkart.com/search?q={}&otracker=search&otracker1=search&marketplace=FLIPKART&as-show=on&as=off'.format(product)
    print(url_product)
    print(file_name)
    print("Scrapping of {} data has been started".format(product))
    
    smartphone_scrapper(dictionary_product,url_product,file_name)
    return None

if __name__ == '__main__':

    product = 'iphone'
    output_csv_producer(product)
    
    #Similarly we can scrape the data of any product in flipkart.
    product_2 = 'oneplus'
    #output_csv_producer(product_2)