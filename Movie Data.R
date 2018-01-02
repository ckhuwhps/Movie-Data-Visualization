library(ggplot2)

#change this to the directory to your csv movie data file
setwd('')

movies <- read.csv("Movie-Data.csv")

#exam what we are working with
head(movies)
summary(movies)
str(movies)

#filter down data to analyze a more specific subset which makes visualizations more understandable
filterGenre <- movies$Genre %in% c('action', 'adventure', 'animation', 'comedy', 'drama') 
filterStudio <- movies$Studio %in% c("Buena Vista Studios", "Fox", "Universal", "Paramount Pictures","Sony", "WB")

filt_mov = movies[filterGenre & filterStudio, ]

#base data and aesthetics
main <- ggplot(data = filt_mov, aes(x = Genre, y = Gross...US))

#add geometry layers like scatterplot and boxplots
box <- main + geom_jitter(aes(size = Budget...mill., colour = Studio)) +
       geom_boxplot(size = 1.2, alpha = .25, outlier.colour = NA)  

# misc. labeling and themes
box <- box + ylab("Gross % US") +
      ggtitle("Domestic Gross % by Genre") 

box <- box + theme(plot.title = element_text(hjust = 0.5, size = 25), 
           axis.title.x = element_text(size = 15, colour = "BLUE"),
           axis.title.y = element_text(size = 15, colour = "BLUE"),
           legend.title = element_text(size = 10))

# change legend title into a more appropriate title  
box$labels$size = "Budget Mil."

box


#interesting histogram visualizatition about movie releases during days of the week
filterGenre <- movies$Genre %in% c('action', 'adventure', 'animation', 'comedy', 'drama', 'fantasy')
filt2_mov = movies[filterGenre,]

main2 <- ggplot(data = filt2_mov, aes(x = Day.of.Week))

hist_DayofWeek <- main2 + geom_histogram(stat = "count", aes(fill = Genre))

hist_DayofWeek <- hist_DayofWeek + xlab("Days of Week") +
                  ggtitle("Movie Release Count by Weekdays") +
                  theme(plot.title = element_text(hjust = .5, size = 15))
hist_DayofWeek

