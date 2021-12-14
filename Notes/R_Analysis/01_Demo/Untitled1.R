
#--Programming and ETL in R--#

#PRACTICE LOADING DATA

#import dependencies
library(jsonlite)
library(tidyverse)
#How to read csv files - demo.csv
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)
#How to read JSON files - demo.json
demo_table2 <- fromJSON(txt='demo.json') 
#Read csv file - demo2.csv
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)
#Read csv file -Vechile_data.xlsx


#PRACTICE SELECTING DATA

#Created Values c mean concatenate
x <- c(3, 3, 2, 2, 5, 5, 8, 8, 9)
#test value
x[3]
#result: [1] 2
# value displayed as: num [1:9] 3 3 2 2 5 5 8 8 9
#Created list
numlist <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
#value displayed as: num [1:10] 0 1 2 3 4 5 6 7 8 9
#Filter by price and drive train - Subset version
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) 
#Filter by price and drive train - Bracket version
filter_table3 <- demo_table2[("clean" %in% demo_table2$title_status) & (demo_table2$price > 10000) & (demo_table2$drive == "4wd"),] 
#How to sample a two-dimensional data structure
?sample() 
num_rows <- 1:nrow(demo_table) # capture the number of rows
sample_rows <- sample(num_rows, 3)
demo_table[sample_rows,]
demo_table[sample(1:nrow(demo_table), 3),]
#Add columns to original data frame using dplyr pipe
?mutate() 
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE)
#create summary table
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep')
#create summary table with multiple columns
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep')


#PRACTICE RESHAPING DATA

#Shape to long table
?gather()
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)
#Alt version using dplyr pipe
long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)
#Shape to wide table
?spread()
#Use dpyler pipe
wide_table <- long_table %>% spread(key="Metric",value="Score")
#check if tables are exactly the same
all.equal(demo_table3,wide_table)
#Result: there was mismatched data - to compare correctly sort the data first
#Comma in the braket indicates selecting all rows
#Sort using colnames(), order(), and bracket notation - for some reason this sort version does not work correctly
table <- demo_table3[,order(colnames(wide_table))]
#Sort using colnames() and bracket notation only - worked correctly
table <- demo_table3[,(colnames(wide_table))]
#check if tables are exactly the same
all.equal(table,wide_table)


#--Visualizing Data Using ggplot2--#

?ggplot()
#Review mpg dataset
head(mpg)
#Categorical bar chart representing distribution of vehicle classes
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=class))
#plot a bar plot
plt + geom_bar() 
#Expects one variable and generates frequency data
?geom_bar()

#Compare and contrast categorical - compare the number of vehicles from each manufacturer in the dataset
#create summary table
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep')
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count))
#plot a bar plot
plt + geom_col() 
#Expects two ariables where we provide the size of each category's bar.
?geom_col()

#formatting functions

#BAR CHART
#plot bar plot with labels
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset")
#plot a boxplot with labels and rotate the x-axis label 45 degrees
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + 
theme(axis.text.x=element_text(angle=45,hjust=1))

#LINE GRAPH
#Compare the differences in average highway fuel economy of Toyota vehicles as a function of the different cylinder sizes
#create summary table
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') 
#import dataset into ggplot2
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) 
plt + geom_line()
#add line plot with labels
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(15:30))

#SCATTER PLOT
#Compare size of each car engine versus their city fuel efficiency
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty))
#add scatter plot with labels
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)")
#import dataset into ggplot2
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) 
#add scatter plot with labels - One aesthetic
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class")
#import dataset into ggplot2 - multipe aesthetic
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv))
#add scatter plot with multiple aesthetics
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive")

#BOXPLOT
#import dataset into ggplot2 - expects a numberic vecotr assigned to the y-value
plt <- ggplot(mpg,aes(y=hwy))
#add boxplot
plt + geom_boxplot()
#import dataset into ggplot2 - create a set of boxplots that cocmpares highway fuel efficiency for each car manufacturer
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy))
#add boxplot and rotate x-axis labels 45 degrees
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1))

#HEATMAP PLOT
#Average highway fuel efficiency across the type of vehicle class from 1999 to 2008
#create summary table
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep')
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
#create heatmap with labels
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)")
#Difference in average highway fuel efficiency across each vehicle model from 1999 to 2008
#create summary table
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep')
#import dataset into ggplot2
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy))
#rotate x-axis labels 90 degrees
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + # add heatmap with labels >
theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5))

#LAYERING PLOTS
#Boxplot + scatter plot
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + #add boxplot
theme(axis.text.x=element_text(angle=45,hjust=1)) + #rotate x-axis labels 45 degrees
geom_point() #overlay scatter plot on top

# Scatter plot
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot
#Scatter plot + summarize(standard deviation)
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + #add scatter plot with labels
geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

#Faceting example
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)

#optimal for comparing the city versus highway fuel efficiency for each manufacturer,
# but it is more difficult to compare all of the city fuel efficiency across manufacturers
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees
?facet_wrap()
#testing facet argument with vars function
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + #create multiple boxplots, one for each MPG type
theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels



#TEST FOR NORAMLITY
#qualitative test for normality
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot
#quantitative test for normality
?shapiro.test()
shapiro.test(mtcars$wt)

#SAMPLE VERSUS POPULATION DATASET
?sample_n()
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

#Create sample dataset
sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

?t.test()
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008
t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

?aov()
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
summary(aov(hp ~ cyl,data=mtcars_filt))

?cor()
head(mtcars)
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient

used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)

plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

?lm()
lm(qsec ~ hp,mtcars) #create linear model
summary(lm(qsec~hp,mtcars)) #summarize linear model

model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp +
model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model

lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics


#CATEGORY COMPLEXITIES
?chisq.test()
table(mpg$class,mpg$year) #generate contingency table
tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions



#PRACTICE A/B TESTING






