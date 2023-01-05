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
    reddit = praw.Reddit(client_id=os.getenv('cid'),
                         client_secret=os.getenv('secret'),
                         user_agent=f"Comment Trends (by /u/Physical-Author5118)"
                         )

    # go through every comment and add to a dataframe
    df = pd.DataFrame(columns=['comment id', 'subreddit', 'text', 'up-votes', 'edited', 'date posted'])
    processed=0
    print("")
    try:
        for comment in reddit.redditor(name).comments.new(limit=None):  # iterate through each comment one by one
            if isinstance(comment, MoreComments):
                time.sleep(0.020)  # sleep to make sure we keep within the 60 requests per second limit for api call
                pass
            else:
                time.sleep(0.02)
                processed += 1
                df.loc[len(df)] = [comment.id, comment.subreddit, comment.body, comment.score, True if comment.edited != False else comment.edited]
                print(f"{processed}, comments collected", end="\r")  # show live count of collected comments
                time.sleep(0.020)
    except:
        print("User doesn't exist or your CID and SECRET is wrong")
        exit()

    print(f"\nCollected {processed} comments total\n")
    if write:
        with open(outfile, 'w') as csv:
            df.to_csv(path_or_buf=csv, index=False)

    return df