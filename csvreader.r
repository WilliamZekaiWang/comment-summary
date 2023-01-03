library(ggplot2)

df = read.csv(file = 'Output.csv', header=TRUE)

plot(table(df$subreddit))
