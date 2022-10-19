# Build-ETL-Pipeline-in-Azure-with-Azure-Synapse-Analytics
ETL (Extract, Transform and Load) E-Commerce Data using Azure Data Factory (ADF) and Azure Synapse Analytics

## Description
The aim of this project, is to  Extract the data from the Azure Data Lake Storage and load as well as transform data in the Parquet Format for better performance and analyze the data in Azure Databricks using PySpark and Spark SQL

## Getting Started

## Architecture Diagram
![](img/architecture.png)

## Dataset
- Yelp Dataset ( https://www.kaggle.com/datasets/yelp-dataset/yelp-dataset )
- The Yelp academic dataset JSON file is converted to Parquet format and further Parquet format is converted to the Delta format for further data analysis
  in Databricks.

## Services
- Azure Databricks
- Azure Data Lake Storage

## Language
- PySpark
- Spark SQL

## Data Formats
- JSON
- Parquet
- Delta
