library(ggplot2)
library(dplyr)


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
  # generates bar plot that has the total karma gained by user from each subreddit
  # param df: read csv of df
  
  # get top subreddits
  sorted_subreddit <- sort(table(df$subreddit), decreasing=TRUE)
  subreddits <- names(sorted_subreddit)[1:howmany]
  
  # iterate through list and get the sum of those
  sums <- c()
  for(item in subreddits){
    sums <- append(sums, sum(df$up.votes[df$subreddit==item]))
  }                           
  
  new_df <- data.frame(subreddits, sums)
  new_df$subreddits <- factor(new_df$subreddits, levels=new_df$subreddits)

    # plot data
  plot <- ggplot(data = new_df,
                 aes(x = subreddits, y = sums, fill=subreddits))+
    geom_bar(stat="identity")+
    xlab("Subreddits")+
    ylab("Total Karma Gained")+
    ggtitle("Karma Gained From Most Frequent Subreddits")+
    theme(axis.text.x=element_blank(),
          text = element_text(size = 5),
          legend.key.size = unit(0.25, 'cm'))+
    geom_text(aes(label=sums), vjust=-0.5, size=1.5)+
    guides(fill=guide_legend(title="Subreddits"))
  
  # write out to graph
  ggsave("subreddits_karma_summary.jpeg",
         plot = plot,
         width = 800,
         height = 800,
         unit = ("px")
  )
}


karma_gained_boxplot_outlier <- function(df, howmany=5){
  
  # get top subreddits
  sorted_subreddit <- sort(table(df$subreddit), decreasing=TRUE)
  subreddits <- names(sorted_subreddit)[1:howmany]
  
  # make a new df that has values and subreddit
  colagulated_df <- data.frame()
  for (item in subreddits) {
    new_df <- data.frame(c(df$up.votes[df$subreddit==item]), c(rep(item)))
    colagulated_df <- rbind(colagulated_df, new_df)
  }
  colagulated_df <- setNames(colagulated_df, c("value", "subreddit")) # index
  
  # plot including outliers and write to file
  outliers <- ggplot(data = colagulated_df,
                   aes(x = subreddit, y = value, color=subreddit))+
              geom_boxplot()+
              xlab("Subreddits")+
              ylab("Karma")+
              ggtitle("Subreddit 5 Number Summary")+
              theme(axis.text.x=element_blank(),
                    text = element_text(size = 5),
                    legend.key.size = unit(0.25, 'cm'))+
              guides(fill=guide_legend(title="Subreddits"))+
              geom_line(size=0.25)
  
  ggsave("boxplot_summary_outliers.jpeg",
         plot = outliers,
         width = 800,
         height = 800,
         unit = ("px")
  )
}




main <- function(){
  df = read.csv(file = 'Output.csv', header=TRUE)
  top_subreddits(df)
  total_score_freqsubreddit(df)
  karma_gained_boxplot_outlier(df)
} 


main()