import requests
from bs4 import BeautifulSoup
import os
import pandas as pd

def get_first_link():
    #try:
        # URL of the webpage
        url = "https://www.corrections.govt.nz/resources/statistics/community_sentences_and_orders"
        
        # Sending a GET request to the webpage and parsing the HTML content
        response = requests.get(url, allow_redirects=True)
        soup = BeautifulSoup(response.content, "html.parser")
        
        # Finding the div with the specified id
        target_div = soup.find("div", id="new_div_825292_21256")
        
        # Finding the first href inside the specified div
        first_href = target_div.find("a", href=True)
        first_link = target_div.find("a")["href"]

        response = requests.get(first_link)
        soup = BeautifulSoup(response.content, "html.parser")
        div = soup.find("div", id = lambda x: x and 'component' in x)
        

        # Downloading the file
        download_link = div.find("a")["href"]
        response = requests.get(download_link)
        print(download_link)

        # Extracting filename from the download URL
        filename = os.path.basename(download_link)
        print(filename)

        # Specify the directory to save the files
        directory = "Files"
        cwd_directory = os.getcwd()
        directory = os.path.join(cwd_directory,directory)
        print(directory) 

        # Constructing the file path
        filepath = os.path.join(directory, filename)
        print(filepath) 


        try:
            with open(filepath, 'wb') as f:
                f.write(response.content)
                print("File downloaded successfully.")
        
        except FileNotFoundError:
            print("File not found. Please check the filepath:", filepath)

        #except requests.exceptions.RequestException as e:
        except Exception as e:
            print("Error:", e)
        

# Calling the function to execute the defined steps
get_first_link()