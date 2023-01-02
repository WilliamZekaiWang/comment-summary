import os
import pandas as pd
import praw
from praw.models import MoreComments
import time

def getUserData(name, outfile='Output.csv'):
    """
    Input user's name and outputs a csv file with the specific comment id, the subreddit it's from, the text,
    number of upvotes, and if the text have or have not been edited
    @param name: their reddit username as a string
    @param outfile: optionally dictate the file you want to write to csv to as a string
    @return: void
    """
    # getting the instance
    reddit = praw.Reddit(client_id=os.getenv('REDDIT_CLIENTID'),
                         client_secret=os.getenv('REDDIT_APIKEY'),
                         user_agent=f"Comment Trends (by /u/{os.getenv('REDDIT_USER')})"
                         )

    # go through every comment and add to a dataframe
    df = pd.DataFrame(columns=['comment id', 'subreddit', 'text', 'up-votes', 'edited'])
    for comment in reddit.redditor(name).comments.new(limit=None):  # iterate through each comment one by one
        if isinstance(comment, MoreComments):
            time.sleep(0.01)  # sleep to make sure we keep within the 60 requests per second limit for api call
            pass
        else:
            df.loc[len(df)] = [comment.id, comment.subreddit, comment.body.encode('cp1252').decode('utf-8'), comment.score, True if not comment.edited else comment.edited]
            time.sleep(0.01)

    with open(outfile, 'w') as csv:
        df.to_csv(path_or_buf=csv, index=False)
    return df