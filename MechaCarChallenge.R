
# Deliverable 1: Linear Regression to Predict MPG

# Instructions
# The MechaCar_mpg.csv dataset contains mpg test results for 50 prototype MechaCars.
# The MechaCar prototypes were produced using multiple design specifications to identify ideal vehicle performance.
# Multiple metrics, such as vehicle length, vehicle weight, spoiler angle, drivetrain, and ground clearance, were collected for each vehicle.
# Using your knowledge of R, you'll design a linear model that predicts the mpg of MechaCar prototypes using several variables from the MechaCar_mpg.csv file.
# Then, you'll write a short interpretation of the multiple linear regression results in the README.md.

# Technical Analysis
#  1. Download the MechaCar_mpg.csv file, and place it in the active directory for your R session.
#  2. Create a new RScript in your R source pane, name it MechaCarChallenge.RScript, and save it to your active directory.
#  Note: Create a new RScript by going to the File menu. Select "New File," followed by "RScript," or you can click the icon in the top-left corner of the RStudio window. Note that the icon looks like a white square with a plus sign in the top left corner.
#  3. Use the library() function to load the dplyr package.
#import dependencies
library(dplyr)
library(tidyverse)
#  4.  Import and read in the MechaCar_mpg.csv file as a dataframe.
MechaCar_mpg <- read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)
#  5. Perform linear regression using the lm() function. In the lm() function, pass in all six variables (i.e., columns), and add the dataframe you created in Step 4 as the data parameter.
?lm
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=MechaCar_mpg)
#  6. Using the summary() function, determine the p-value and the r-squared value for the linear regression model.
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data=MechaCar_mpg))
#  7. Save your MechaCarChallenge.RScript file to your GitHub repository.



# Deliverable 2: Create Visualizations for the Trip
# Instructions
# The MechaCar Suspension_Coil.csv dataset contains the results from multiple production lots.
# In this dataset, the weight capacities of multiple suspension coils were tested to determine if the manufacturing process is consistent across production lots.
# Using your knowledge of R, you'll create a summary statistics table to show:

# Technical Analysis
# 1. Download the Suspension_Coil.csv file, and place it in the active directory for your R session.
# 2. In your MechaCarChallenge.RScript, import and read in the Suspension_Coil.csv file as a table.
Suspension_Coil <- read.csv(file='Suspension_Coil.csv',check.names=F,stringsAsFactors = F)
# 3. Write an RScript that creates a total_summary dataframe using the summarize() function to get the mean, median, variance, and standard deviation of the suspension coil's PSI column.
total_summary <- Suspension_Coil %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI),SD=sd(PSI))
# 4. Write an RScript that creates a lot_summary dataframe using the group_by() and the summarize() functions to group each manufacturing lot by the mean, median, variance, and standard deviation of the suspension coil's PSI column.
lot_summary <- Suspension_Coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI),Median=median(PSI),Variance=var(PSI),SD=sd(PSI), .groups = 'keep')
# 5. Save your MechaCarChallenge.RScript file to your GitHub repository.



# Deliverable 3: T-Tests on Suspension Coils 

# Instructions
# Using your knowledge of R, perform t-tests to determine if all manufacturing lots and each
# lot individually are statistically different from the population mean of 1,500 pounds per square inch.

# Technical Analysis
#   1. In your MechaCarChallenge.RScript, write an RScript using the t.test() function to determine if the PSI 
#      across all manufacturing lots is statistically different from the population mean of 1,500 pounds per square inch.
t.test(Suspension_Coil$PSI,mu=1500) 
#   2. Next, write three more RScripts in your MechaCarChallenge.RScript using the t.test() function and its subset() 
#      argument to determine if the PSI for each manufacturing lot is statistically different from the population mean of 1,500 pounds per square inch.

#Create sample dataset - Lot 1
lot1 <- subset(Suspension_Coil, Manufacturing_Lot=="Lot1")
t.test(lot1$PSI,mu=1500) 
#Create sample dataset - Lot 2
lot2 <- subset(Suspension_Coil, Manufacturing_Lot=="Lot2")
t.test(lot2$PSI,mu=1500) 
#Create sample dataset - Lot 3
lot3 <- subset(Suspension_Coil, Manufacturing_Lot=="Lot3")
t.test(lot3$PSI,mu=1500) 
#   3. Save your MechaCarChallenge.RScript file to your GitHub repository.



# Deliverable 4: Design a Study Comparing the MechaCar to the Competition 

# Instructions
# Using your knowledge of R, design a statistical study to compare performance of the MechaCar vehicles against performance of vehicles from other manufacturers.
# Follow the instructions below to complete Deliverable 4.

#   1. In your README, create a subheading ## Study Design: MechaCar vs Competition.

#   2. Write a short description of a statistical study that can quantify how the MechaCar performs against the competition. In your study design, think critically about what metrics would be of interest to a consumer: for a few examples, cost, city or highway fuel efficiency, horse power, maintenance cost, or safety rating.

#   3. In your description, address the following questions:
#      What metric or metrics are you going to test?
#      What is the null hypothesis or alternative hypothesis?
#      What statistical test would you use to test the hypothesis? And why?
#      What data is needed to run the statistical test?






