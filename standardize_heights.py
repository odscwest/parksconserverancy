# Standardize naming for height column
import pandas as pd

# read in the cleaned version of the data and replace '-' with nan
clean_data = pd.read_csv('cleaned_landsend_veg_2007_2012.csv', na_values='-')

# create a dictionary of height values
height_fixes = {'Low': ['L', 'L '], 'Medium': 'M', 'High': 'H'}

# set the height variable equal to the height column
# replace individual letters such as 'L', 'M', and 'H' with their word equivalent
height = clean_data.height
[height.replace(to_replace=letter, value=word, inplace=True)
    for word, letter in height_fixes.iteritems()]

# overwrite the height column with the standardized hight names
clean_data.height = height

# generate a new csv files with the updated heights
clean_data.to_csv('clean_data_w_standardized_heights.csv')
