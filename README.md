# UC-Projects - Data Engineering (DATA472)
## AIM
This repository contains scripts and files for collecting, cleaning, organizing, and providing data from a specified website related to Community Sentences and Orders. The data collection process is done using Python, data cleaning and organization are performed using R, and the processed data is provided to the client via a Python Flask API in JSON format.

## File Structure
- PrisonStatistics.py - Contains Python scripts for scraping data from the specified website and downloading it as CSV files.
- Cleaning.R - Contains R scripts for cleaning and organizing the downloaded data. Cleaned data is saved as CSV files in the 'Cleaned' folder.
- flaskAPI.py - Contains Python Flask API scripts for providing the cleaned data and metadata in JSON format to the client.
- metaData.json - Contains metadata files with details of the tables, dimensions, and observations of the cleaned data.
- Quarterly_Community_Statistics.xlsx - File downloaded from the specific website.
- Cleaned folder - Contains the cleaned and organized data saved as CSV files.

  ## Workflow
  - Data Collection: Python scripts scrape data from the specified website and download it as CSV files.
  - Data Cleaning: R scripts clean and organize the downloaded data. Cleaned data is saved as CSV files in the Cleaned folder.
  - Metadata Creation: Metadata files provide details of the tables, dimensions, and observations of the cleaned data.
  - API Deployment: Python Flask API scripts in the API folder provide the cleaned data and metadata in JSON format to the client.
  - EC2 Instance Deployment: All scripts and necessary files are deployed on an EC2 instance in AWS. The required packages are installed, and cron jobs are set up to automate the process every three months.
 
  ## Dependencies
  - Python (3.x)
  - R
  - Flask
  - Other required Python and R packages
 
    ## API Links
    - http://3.106.55.200:5000/col35/prisonstatistics
    - http://3.106.55.200:5000/col35/metadataapi
