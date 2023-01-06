# comment-trends
This is a python script using Praw to access their a Reddit User's most recent (up to 1000) comments on Reddit via a user name

Subsequently, a R script (csvreader.R) is used to analyze the outputted CSV file and 4 graphs are made to realize trends

The graphs made are as follows of their top 5 most frequent subreddits:
- Bar plot of how many comments in the subreddits
- Bar plot of how much karma/score they recieved in the subreddits
- Box plot of the karma/socre they recieved in the subreddits
- Mean plot with error bars (Standard deviation) of the karma/score they recieved in the subreddits

# Installing/Running the Program
You first need to set environmental variables for the client id (as cid) and secret (as secret) which will be accessed by the script. These can be generated over at the Reddit website

After setting the environmental variables, clone the repository and change the directory to comment-trends. Then run the main script
```
git clone https://github.com/WilliamZekaiWang/comment-trends/
cd comment-trends
python3 main.py
```
After the script runs, you can generate graphs by calling the R script
```
Rscript csvreader.R
```
The graphs will be jpegs in the same file and you can access them however you want.

You can also read every comment in the Output.csv file that will be generated

# example output
Getting User information

![image](https://user-images.githubusercontent.com/101022180/210922738-d6fb52ac-1052-4641-8847-0f9e8ffa6c3f.png)

Graphs are generated after running the R script. You can see them in the same directory

![image](https://user-images.githubusercontent.com/101022180/210923779-82c57cf7-b0c6-4fd9-b88e-490f67e4bd64.png)

The graphs are as follows:

### Meansplot 

![image](https://user-images.githubusercontent.com/101022180/210923864-6a5f12b4-dc74-4616-85e2-2769cc2d4f47.png)

### Bargraphs

![image](https://user-images.githubusercontent.com/101022180/210923982-8dc27d38-e08e-4f2d-abfa-ad5fe70e307b.png)
![image](https://user-images.githubusercontent.com/101022180/210924008-e91b1516-ac5b-491a-a906-5747b1c1ee4f.png)

### Boxplot

![image](https://user-images.githubusercontent.com/101022180/210923938-71209438-5a4a-410f-a161-8d7dc8041b5f.png)
