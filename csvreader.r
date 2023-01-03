library(ggplot2)
rm(list = ls())

df = read.csv(file = 'Output.csv', header=TRUE)
sorted_subreddit <- sort(table(df$subreddit), decreasing=TRUE)


# most commented on subreddit as bar graph
top_subreddits <- function(sorted_subreddit){
  """
  writes out a jpeg of their most used subreddits from ggplot
  @param: sorted_subreddit, a sorted table of frequency
  """
  reddits <- names(sorted_subreddit)[1:5] # display top 5 
  counts <- as.numeric(sorted_subreddit)[1:5]
  tabled <- data.frame(reddits, counts) 
  tabled$reddits <- factor(tabled$reddits, levels=tabled$reddits) # avoid sorting
  
  # ggplot bar graph
  bar <- ggplot(data = tabled,
                aes(x=reddits,
                    y=counts))+
    geom_bar(stat="identity")+
    xlab("Subreddits")+
    ylab("Number of Comments")+
    ggtitle("User's Most Engaged Subreddits")+
    theme(text = element_text(size = 5))
  
  # write out file
  ggsave("subreddits_summary.jpeg",
         plot = bar,
         width = 800,
         height = 800,
         unit = ("px")
         )
}
