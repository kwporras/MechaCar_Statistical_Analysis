## Linear Regression to Predict MPG - Written Summary
#### Linear Regression analysis
![alt_text](https://github.com/kwporras/MechaCar_Statistical_Analysis/blob/8bcaff44f5d9385adc7b3bd4d128ddef17f1a345/Resources/Linear_Regression_to_Predict_MPG.PNG)
- Vehicle Length and Vehicle Ground Clearance both provide a non-random amount of variance compared to mpg. 
- The slope of the mode in not considered to be zero since the because it's p-value is 5.35e-11.
- This linear model predicts mpg of MechaCar prototypes effectively which is show by the r-squared value of 0.7149.


## Summary Statistics on Suspension Coils - Written Summary
#### Total Summary
![alt_text](https://github.com/kwporras/MechaCar_Statistical_Analysis/blob/8bcaff44f5d9385adc7b3bd4d128ddef17f1a345/Resources/Total_Summary.PNG)
#### Summary - Individual Lots 
![alt_text](https://github.com/kwporras/MechaCar_Statistical_Analysis/blob/8bcaff44f5d9385adc7b3bd4d128ddef17f1a345/Resources/Lot_Summary.PNG)
- The dataset has a normal distribution when compaired mean(1498.78) and median(1500) making the statistical analysis usable.
- Psi variance in the total summary is 62.29356 psi, which does not exceeding the suspension coil pounds per square inch of 100.
- The variance of lot 1 and 2 are withing the 100 specification however, lot 3 does not fall within the design specifictations for the lots.


## T-Tests on Suspension Coils - Written Summary
#### Total Summary
![alt_text](https://github.com/kwporras/MechaCar_Statistical_Analysis/blob/8bcaff44f5d9385adc7b3bd4d128ddef17f1a345/Resources/all_lots.PNG)
- Total Summary: p-value = .06028; Cannot reject the null hypothesis
#### Summary - Individual Lots 
![alt_text](https://github.com/kwporras/MechaCar_Statistical_Analysis/blob/8bcaff44f5d9385adc7b3bd4d128ddef17f1a345/Resources/individual_lots.PNG)
- Lot 1: p-value = 1.0; Cannot reject the null hypothesis
- Lot 2: p-value = .6072;  Cannot reject the null hypothesis
- Lot 3: p-value = .04168;  Reject the null hypothesis


## Study Design: MechaCar v Competition - Written Summary

#### Metrics test:
Cost - Dependent\
Fuel efficiency - Independent\
Horse Power - Independent\
Maintenance Cost - Independent\
Safety Rating - Independent 

#### Hypothesis testing:
Null Hypothesis - MechaCar is competively priced base on the above features.\
Alternative Hypothis - MechaCar is not competively priced on the above features.

#### Statistical test:
We will use Multiple linear regression considering that all the data is continuous. This will show how much variance in the dependent
variable is accounted for in a linear combination of independent variables. 
