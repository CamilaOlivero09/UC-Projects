# Loading the required libraries
library(readxl)
library(tidyr)
library(lubridate)
library(dplyr)


# Reading the excel file from the project directory
filepath <- "Quarterly_Community_Statistics_-_March_2024.xlsx"
sheet_names <- excel_sheets(filepath)


# Initializing for the List of Data frame
all_data <- list()


for (sheet_name in sheet_names){
  # Reading the data in individual sheets
  data <- as.data.frame(read_excel(filepath, sheet = sheet_name))

  # Assigning the data in the list
  all_data[[sheet_name]] <- data
}



# Cleaning the dataset
cleaning_df <- function(df) {
  for (i in 1:length(df)) {
    # Add column names as the first row
    df[[i]] <- rbind(as.character(names(df[[i]])), df[[i]])

    # Remove column names
    colnames(df[[i]]) <- NULL

    # Transpose dataframe
    df[[i]] <- as.data.frame(t(df[[i]]))

    # Set "Date" in the first row
    df[[i]][1, 1] <- "Date"

    # Set column names as the first row
    colnames(df[[i]]) <- df[[i]][1, ]

    # Remove the first row
    df[[i]] <- df[[i]][-1, ]

    # Convert Dates into Date format
    df[[i]]$Date <- as.Date(as.numeric(df[[i]]$Date), origin = "1899-12-30")

    # Replace NA values with 0
    df[[i]][is.na(df[[i]])] <- 0
  }
  return(df)
}


# Pivoting the dataset
pivot_data <- function(df,name_to,end_col){
  for(i in 1:length(df)){
    col_end <- as.numeric(end_col[i])
    df[[i]] <- pivot_longer(df[[i]],
                            cols = 2: col_end,
                            names_to = name_to[i],
                            values_to = "Observations"
    )
  }
  return(df)
}


# Creating csv files of the dataset
make_csv <- function(df, filenames){

  for (i in 1:length(filenames)) {
    write.csv(df[[i]], filenames[i], row.names = FALSE)
  }
  return(df)
}



## Populating the No. Of Sentences and Orders sheet to the required format
NoOfSentences <- NULL
NoOfSentences <- all_data[["number of sentences and orders"]]

# Calculate the sum of null values in each row
null_row_indices <- which(rowSums(is.na(NoOfSentences)) == ncol(NoOfSentences))

# Remove rows where all values are null
NoOfSentences <- NoOfSentences[-null_row_indices, ]


# Loop through each column in the first row
for (i in 1:ncol(NoOfSentences)) {
  # Check if the value in the first row and current column is numeric
  if (is.numeric(NoOfSentences[1, i])) {
    # Convert the numeric value to a date format
    parsed_date <- as.Date(as.numeric(NoOfSentences[1, i]), origin = "1899-12-30")
    # Convert the date to yyyy-mm-dd format
    parsed_date_formatted <- format(parsed_date, "%Y-%m-%d")
    # Assign the parsed date back to the data frame
    NoOfSentences[1, i] <- parsed_date_formatted
  }
}


NoOfSentences <- NoOfSentences[-c(2:4), ]

# Assign the first row as column names
colnames(NoOfSentences) <- NoOfSentences[1, ]

# Remove the first row from the dataset
NoOfSentences <- NoOfSentences[-1, ]

NoOfSentences <- NoOfSentences[NoOfSentences[,1] != 'Other', ]

colnames(NoOfSentences)[1:2] <- c("City", "Type")


value_to_update <- NoOfSentences[NoOfSentences$City == "Wellington Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Wellington", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Waikato Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Waikato", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Taranaki / Whanganui / Manawatu Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Wairarapa/ Manawatu", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Wairarapa/ Manawatu", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Whanganui/ Taranaki", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Otago / Southland Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Otago", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Nelson / Marlborough / West Coast Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Nelson/ West Coast", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Manukau Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Manukau", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "East Coast Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "East Coast", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Canterbury Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Canterbury", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Bay of Plenty Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Bay of Plenty", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Auckland Region", "2024-03-31"]
NoOfSentences[NoOfSentences$City == "Auckland", "2024-03-31"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Otago and South/ Mid Canterbury", "2022-09-30"]
NoOfSentences[NoOfSentences$City == "Otago", "2022-09-30"] <- value_to_update

value_to_update <- NoOfSentences[NoOfSentences$City == "Otago and South/ Mid Canterbury", 
                                 c("2022-09-30","2022-12-31","2023-03-31","2023-06-30","2023-09-30","2023-12-31")]
NoOfSentences[NoOfSentences$City == "Otago", c("2022-09-30","2022-12-31","2023-03-31","2023-06-30","2023-09-30","2023-12-31")] <- value_to_update

NoOfSentences <- NoOfSentences[!(NoOfSentences[, 1] %in% c('Other', 'Wellington Region', 'Waikato Region', 'Taranaki / Whanganui / Manawatu Region',
                                                           'Otago / Southland Region', 'Northland Region', 
                                                           'Nelson / Marlborough / West Coast Region', 'Manukau Region',
                                                           'East Coast Region', 'Canterbury Region', 'Bay of Plenty Region',
                                                           'Auckland Region', 'Waitemata', 'Taupo/ Rotorua', 'Taitokerau',
                                                           'Otago and South/ Mid Canterbury', 'Southland/ Central Otago',
                                                           'Southland and Central/ South Otago')), ]




NoOfSentences[is.na(NoOfSentences)] <- ""

# Reshape the dataset from wide to long format
long_data <- reshape(NoOfSentences,
                     direction = "long",
                     varying = list(names(NoOfSentences)[3:ncol(NoOfSentences)]),
                     v.names = "Observations",
                     timevar = "Date",
                     times = colnames(NoOfSentences)[3:ncol(NoOfSentences)])

# Rename the columns
colnames(long_data)[1] <- "City"
colnames(long_data)[2] <- "Type"

# Remove the "id" column if it exists
if ("id" %in% colnames(long_data)) {
  long_data <- subset(long_data, select = -id)
}


# Reorder the columns as per your desired format
long_data <- long_data[, c("Date", "City", "Type", "Observations")]








# Dealing with the rest of the sheets 
list_othersheets <- list()
list_othersheets[[1]] <- all_data[["Age"]]
list_othersheets[[2]] <- all_data[["Ethnicity"]]
list_othersheets[[3]] <- all_data[["Gender"]]
list_othersheets[[4]] <- all_data[["Offence type"]]
list_othersheets[[5]] <- all_data[["Type"]]



list_othersheets <- cleaning_df(list_othersheets)  

#Fetching only columns having related values
list_othersheets[[4]] <- list_othersheets[[4]][,1:24]



column_names <- c("Age", "Ethnicity", "Gender", "Offence type", "Type")
col_end <- list()
for(i in 1:length(list_othersheets)){
  col_end[i] <- ncol(list_othersheets[[i]])
}


list_othersheets <- pivot_data(list_othersheets, column_names, col_end)


for(i in 1:length(list_othersheets)){
  list_othersheets[[i]]$Observations <- as.numeric(list_othersheets[[i]]$Observations) * 100
}



# for(i in 1:length(list_othersheets)){
#   all_data[[i+1]] <- list_othersheets[[i]]
#   all_data[[i+1]]$Observations <- as.numeric(all_data[[i+1]]$Observations) * 100
# }


list_othersheets[[6]] <- long_data

filenames <- c(
  "Age",
  "Ethnicity",
  "Gender",
  "Offencetype",
  "Type",
  "NoOfSentences"
)



output_dir <- "Cleaned"

# Create the directory if it doesn't exist
if (!dir.exists(output_dir)) {
  dir.create(output_dir)
}

# Write each DataFrame to a separate CSV file
for (i in 1:length(list_othersheets)) {
  df <- list_othersheets[[i]]
  filename <- file.path(output_dir, paste0(filenames[i], ".csv"))
  write.csv(df, filename, row.names = FALSE)
}
