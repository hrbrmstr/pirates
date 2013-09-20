library(plyr)
library(ggplot2)
library(gridExtra)
library(ggthemes)

# the full data set
pirates.df <- read.csv("pirates.csv", stringsAsFactors=FALSE)

# I extracted the year column (I made a year column) and vessel type column
# then did a ton of text maniuplation to get the final set of factors. It's
# a pretty messy column and ended up lumping more than I liked into "Other"
# 
# You can make the year field with:
#
# pirates.df$year <- strftime(pirates.df$DateOfOcc, "%Y")
#
# but be warned there's a bad year in there that you'll have to deal with.
#
# I then ran:
#
# p3.df <- count(p2.df,c("Year","Vessel.Type"))
# 
# to generate that data frame, but since both CSVs are extracted, you don't
# really need to go through the machinations yourself.
#

# read year|vessel.type
p2.df <- read.csv("p2.csv", stringsAsFactors=FALSE)
# aggregated by year & vessel.type
p3.df <- read.csv("p3.csv", stringsAsFactors=FALSE)

# simple bar graph of totals
p <- ggplot(pirates.df, aes(x=year))
p <- p + geom_bar(binwidth=1, color="white", fill="black")
p <- p + labs(x="Year", y="# Attacks", title="Pirate Attacks By Year")
p <- p + theme_few() 
p <- p + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p

# dot plot by year and vessel type
p2 <- ggplot(p3.df, aes(x=Year, y=Vessel.Type, size=freq))
p2 <- p2 + geom_point(aes(color=Vessel.Type))
p2 <- p2 + scale_size_area()
p2 <- p2 + labs(x="Year", y="# Attacks", title="Pirate Attacks By Year & Vessel Type")
p2 <- p2 + theme_few()
p2 <- p2 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
p2 <- p2 + theme(legend.position=0)
p2

# all in one
grid.arrange(p,p2)
