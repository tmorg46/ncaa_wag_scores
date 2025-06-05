# ncaa_wag_scores
File descriptions:

raw_scores -- csv files of each team-season since 2015. Each file is a single season for a single team.

rtn_scrape.py -- the code to scrape the scores. I rerun it after every new season has finished and add the data to raw_scores.

clean_scores.do -- the code that aggregates all the raw scrapes into one single coherent file. Cleans some RTN errors, distinguishes gymnasts on different teams with the same names and adjusts for the same gymnast changing her name over time, allowing name to be a unique gymnast identifier.

cleaned_scores.csv -- the coherent file created by clean_scores.do!
