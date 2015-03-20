---
title: "README"
author: "Ryan Summe"
date: "Friday, March 20, 2015"
output: html_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

This is the final project submission for Getting & Cleaning Data in the Data Science specialization on Coursera. This repo includes run_analysis.R, CodeBook.md, and the folder "UCI HAR Dataset". It is a dataset collected from a Galaxy S smartphone with its gyometer and accelerometer. 

run_analysis.R compiles data from test and trial subjects and generates a summary table of 180 observations of 88 variables. The summary table includes the mean value for each mean and standard deviation measurement made, per subject per activity. There are 30 subjects that did 6 activities each.

Prior to running run_analysis.R, please make sure you have reshape2 and its dependencies downloaded. If you do not have it loaded in your environment, the script will do so. Running the script without having it downloaded will likely produce errors.

Source the run_analysis.R script with your working directory set to the location of the script. Within a couple minutes, you will have a results.txt file in your working directory. Several print statements will appear to show progress of the script.