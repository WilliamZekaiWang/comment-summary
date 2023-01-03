import os
import pandas as pd
import praw
from praw.models import MoreComments
import time

def getUserData(name, outfile='Output.csv', write=False):
    """
    Input user's name and outputs a csv file with the specific comment id, the subreddit it's from, the text,
    number of upvotes, and if the text have or have not been edited
    @param name: their reddit username as a string
    @param outfile: optionally dictate the file you want to write to csv to as a string
    @param write: boolean to check if user wants to write the file to csv
    @return: dataframe with columns ['comment id', 'subreddit', 'text', 'up-votes', 'edited']
    """
    # getting the instance
    reddit = praw.Reddit(client_id=os.getenv('REDDIT_CLIENTID'),
                         client_secret=os.getenv('REDDIT_APIKEY'),
                         user_agent=f"Comment Trends (by /u/{os.getenv('REDDIT_USER')})"
                         )

    # go through every comment and add to a dataframe
    df = pd.DataFrame(columns=['comment id', 'subreddit', 'text', 'up-votes', 'edited'])
    processed=0
    try:
        for comment in reddit.redditor(name).comments.new(limit=None):  # iterate through each comment one by one
            if isinstance(comment, MoreComments):
                time.sleep(0.015)  # sleep to make sure we keep within the 60 requests per second limit for api call
                pass
            else:
                processed += 1
                df.loc[len(df)] = [comment.id, comment.subreddit, comment.body, comment.score, True if comment.edited != False else comment.edited]
                print(f"{processed}, comments collected", end="\r")
                time.sleep(0.015)
    except:
        print("User doesn't exist")
        exit()

    print(f"Collected {processed} comments total")
    if write:
        with open(outfile, 'w') as csv:
            df.to_csv(path_or_buf=csv, index=False)

    return df