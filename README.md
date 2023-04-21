---
title: "Getting and Cleaning Data - Coursera Project"
output: html_notebook
editor_options: 
  chunk_output_type: inline
---

Peer-graded Assignment: Getting and Cleaning Data Course Project

------------------------------------------------------------------------

This repository is for the Coursera "Getting and Cleaning Data" Course Project Assignment

Inside this repository are 4 files

------------------------------------------------------------------------

`README.md`

`CodeBook.md` - Includes further detail on the step by step instructions, as well as descriptions of the variables, data and transformations made

`run_analysis.R` - an R script that prepares, combines, cleans and produces an individual tidy dataset

The data was supplied and described from "<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>"

The dataset was downloaded from "<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>"

`Tidy_Data.txt` - The exported cleaned individual dataset produced after running the `run_analysis.R` script

------------------------------------------------------------------------

The `run_analysis.R` script follows the 10 steps outlined below:

**Step 1** - Load in the necessary packages.

**Step 2** - Save the name of the file we are going to download and use.

**Step 3** - Checking the file and using the url to download & unzip the data files we need to use.

**Step 4** - Load in and specify the `Activity` labels + `Features` files so we can transform them into variable names later for our tidy dataset, and also subset the means & std's of the `Training` & `Test` "`X_`" files in the next step.

**Step 5** - Loading & Sub-setting `Training` & `Test` files (using **Step 4**) and combing them into two datasets with the same formats; `Training` & `Test`.

**Step 6** - Merge `Training` + `Test` into one dataframe

**Step 7** - Renaming the variables to be clearer and more readable

**Step 8** - Converting `Subject` & `Activity` to be factors

**Step 9** - Melting and Re-casting the dataset by the average of each variable for each `Activity` + `Subject`

**Step 10** - Saves the cleaned dataset as a txt file = "`Tidy_Data.txt`"
