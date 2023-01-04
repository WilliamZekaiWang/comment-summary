library(ggplot2)


# most commented on subreddit as bar graph
top_subreddits <- function(df, howmany=5){
  #writes out a jpeg of their most used subreddits from ggplot
  #param: df read from python with a vector called subreddit
  
  # sort df then get the most posts per counts and reddits
  sorted_subreddit <- sort(table(df$subreddit), decreasing=TRUE)
  reddits <- names(sorted_subreddit)[1:howmany]
  counts <- as.numeric(sorted_subreddit)[1:howmany]
  tabled <- data.frame(reddits, counts) 
  tabled$reddits <- factor(tabled$reddits, levels=tabled$reddits) # avoid sorting
  
  # ggplot bar graph
  bar <- ggplot(data = tabled,
                aes(x=reddits, y=counts, fill=reddits))+
    geom_bar(stat="identity")+
    xlab("Subreddits")+
    ylab("Number of Comments")+
    ggtitle("User's Most Engaged Subreddits")+
    theme(axis.text.x=element_blank(),
          text = element_text(size = 5),
          legend.key.size = unit(0.25, 'cm'))+
    geom_text(aes(label=counts), vjust=-0.5, size=1.5)+ 
    guides(fill=guide_legend(title="Subreddits"))
  
  # write out file
  ggsave("Number_of_posts.jpeg",
         plot = bar,
         width = 800,
         height = 800,
         unit = ("px")
  )
}


# average score per comment in subreddit
total_score_freqsubreddit <- function(df, howmany=5){
  
  # get top subreddits
  sorted_subreddit <- sort(table(df$subreddit), decreasing=TRUE)
  subreddits <- names(sorted_subreddit)[1:howmany]
  
  # iterate through list and get the sum of those
  sums <- c()
  for(item in subreddits){
    sums <- append(sums, sum(df$up.votes[df$subreddit==item]))
  }                           
  
  # plot data
  new_df <- data.frame(subreddits, sums)
  plot <- ggplot(data = new_df,
                 aes(x = subreddits, y = sums, fill=subreddits))+
    geom_bar(stat="identity")+
    xlab("Subreddits")+
    ylab("Total Karma Gained")+
    ggtitle("Karma Gained From Most Frequent Subreddits")+
    theme(axis.text.x=element_blank(),
          text = element_text(size = 5),
          legend.key.size = unit(0.25, 'cm'))+
    geom_text(aes(label=sums), vjust=-0.5, size=1.5)
  
  # write out to graph
  ggsave("subreddits_karma_summary.jpeg",
         plot = plot,
         width = 800,
         height = 800,
         unit = ("px")
  )
}


main <- function(){
  df = read.csv(file = 'Output.csv', header=TRUE)
  top_subreddits(df)
  total_score_freqsubreddit(df)
} 


main()