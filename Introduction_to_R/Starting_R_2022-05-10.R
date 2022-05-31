##############################
## Script to accompany the Rmd
## Amy Goldlist, Sptring 2022
##############################



## when I start a line with a #, it's a comment

### Try to understand how the code is working!


# The <- (or alt -)  assigns a variable
x <- 5
## now x is always 5


##  what is 8 times 5?
8*x


## now make x be 7
x <- 7

## hmm, 8x is different!
8*x




## A data problem:


### if this is your first time using this, open these files:
# Delete the # at the begining of the line!

## Go to the end of each line and press ctrl+ enter
# install.packages("dplyr")
# install.packages("openxlsx")
# install.packages("ggplot2")
# install.packages("palmerpenguins")

## opening up these libraries or packages lets us use them
library(dplyr)  #dplyr is really great for organizing dataframes
library(openxlsx)  #openxlsx lets us read and write to Excel files. 
library(ggplot2) ## this is for making visualizations
library(palmerpenguins) # this is actually just cute penguins!



### Open the file



getwd()

## Let's read in our Excel file.  The sheet option tells us which worksheet to use
gig <- read.xlsx("jaggia_ba_1e_ch02_Data_Files.xlsx",sheet ="Gig")




### And let's look at the file:


## how big is our data set?
dim(gig)  

## look at the first few rows
head(gig)  

## look at the whole thing in a different window
# View(gig)  

str(gig)

## what are the columns like?  str = structure
str(gig)



### Answering the questions


##### Find number of missing Values:
# Hourly Wage


## ctrl shift m makes the cool "pipe" %>%
##step1:  pull up the gig dataset
gig %>% 
  ##step 2:  filter only the blank hourly wage
  filter(is.na(HourlyWage))



# Industry


gig %>% 
  ## filter the blanks in Industry
  filter(is.na(Industry))



### and the blank jobs
gig %>% 
  filter(is.na(Job))


##### The Number of employees who:

# work in the automotive industry

## Now lets try to count stuff using summarize...

## first take our whole data.frame
gig %>% 
  ## group by industry
  group_by(Industry) %>%
  #then count the numbers n()
  summarize(People=n())



# Earn More than $30 per hour


gig %>% 
  ## filter by wage greater than $30
  filter(HourlyWage> 30) %>% 
  ##and count them
  count()



# Automotive Industry and earn more than $30 per hour


gig %>% 
  filter(HourlyWage> 30) %>% 
  ## group by industry
  group_by(Industry) %>%
  #then count the numbers n()
  summarize(n())



##### Find the Hourly wages:
# Lowest and Highest:
  

gig %>% 
  #then find maximum and minimum HourlyWage
  summarize(min(HourlyWage),max(HourlyWage))



# Lowest and Highest accountant in automotive / Tech : 
  

## Step 1: pull up gig dataset
gig %>% 
  ## Step 2: filter by only Accountants
  filter(Job == "Accountant") %>% 
  ## Step 3: group by industry
  group_by(Industry) %>% 
  #then find maximum and minimum wage
  summarize(min(HourlyWage),max(HourlyWage))




###  Pretty pictures

# Just some basic plots:
  

## try commenting and uncommenting:

plot(gig)


gig %>% ggplot(aes(y =HourlyWage))+
   geom_boxplot()
#
 gig %>% ggplot(aes(y =HourlyWage, colour = Industry))+
  geom_boxplot()+
   theme_bw()
# 
 gig %>% ggplot(aes(y =HourlyWage, colour = Job))+
   geom_boxplot()+
   theme_bw()
# 
# 
# 
 gig %>% ggplot(aes(x =HourlyWage))+
  geom_histogram()+
   theme_bw()
# 
gig %>% ggplot(aes(x =HourlyWage))+
  geom_histogram(aes(fill = Industry))+
  theme_bw()


## Getting Fancy!

# Let's look at a different dataset.  This one is all about penguins.  Intrigued?  (<https://allisonhorst.github.io/palmerpenguins/>)




## Look at the data



## Look at penguins

penguins

df<-penguins


### make a regression model

cupcake<- lm(body_mass_g~flipper_length_mm,data=penguins)

summary(cupcake)

chocolate<- lm(body_mass_g~.,data=penguins)

summary(chocolate)

penguins %>% ggplot()+
  geom_point(aes(x=flipper_length_mm, y =body_mass_g, colour =species ))

### References:

# Take some time and learn about R from the experts: <https://education.rstudio.com/learn/beginner/>
# This is an hour long webinar, but will give you a good overview of data wrangling in R: <https://rstudio.com/resources/webinars/a-gentle-introduction-to-tidy-statistics-in-r/>
# Follow some tutorials at <https://stat545.com/>
# Like this example?  Buy the textbook: <https://www.mheducation.com/highered/product/business-analytics-jaggia-kelly/M9781260785005.html>


