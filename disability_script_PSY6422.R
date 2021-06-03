library(tidyverse)

library(here) 

#set working directory

here(setwd("~/PSY6422_Final_Project"))

#load data file

df <-  read.csv(here(setwd("~/PSY6422_Final_Project"),"data","disability_degree.csv"))

head(df, 3)

#tidying up the data

#selecting target data for the visualization through - 

df <- df %>% 
  select(Year,Disabled.with.Degree.or.equivalent,Non.disabled.with.Degree.or.equivalent)

#Renaming/simplifying column names

colnames(df)<- c("year","d.degree","nd.degree")

#displaying the data

head(df)

#creating a new dataframe by grouping the data to create a column based on disability status 

disability_grouped <- data.frame(x = with(df, c(year)),
                                 y = with(df, c(d.degree, nd.degree)),
                                 group = rep(c("Disabled", "Non-Disabled"), each=7))

# displaying the new dataframe

head(disability_grouped)

#Creating a scatter plot to show the difference between groups over time

ggplot(data = disability_grouped,
       mapping = aes(x = x,
                     y = y,
                     col = group)) +
  geom_point(shape=18, alpha = 0.8, size = 4) +
  scale_y_continuous(limits=c(10, 40), breaks= seq(10, 40, 5)) +
  scale_color_manual(values=c("#FAC218", "#905FD0")) +
  scale_fill_discrete(name = "Disability Status") +
  theme(axis.text.x = element_text(angle = 42.5, vjust = 1, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +
  labs(color = "Disability status",
       x = "Year", 
       y = "Percentage of sample with degree (%)",
       title = "Degree attainment by disability status",
       caption = "Source: Office of national statistics")

ggsave("figs/disability_degree2021-05-24.png")
