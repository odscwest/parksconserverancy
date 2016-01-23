**SHORTLINK: http://bit.ly/1UiQySY**

[data access](#data-access) - 
[helpful synopsis data](#helpful-synopsis-data) -
[exercises](#exercises) -
[ideas](#ideas) - 
[goals](#goals) -
[output](#output) -
[reference](#reference) -
[column definitions](#definitions)

## DATA ACCESS
[Github project](https://github.com/odscwest/parksconserverancy)

Each person can:

A. clone and send final project back by email
B. create their own fork to work within the project


### Access to raw data
[original document](https://docs.google.com/spreadsheets/d/12_2U7Ctcw-s0kE0U8WxlUBnTFI9iRzQwLQUw0whoxxA/edit#gid=973864134)

### Recommendation
Get to know your data first.

### Helpful synopsis data
1. 	Relative cover by hit type (bare ground, litter, native plant cover, exotic plant cover)
2. 	Relative cover vegetation by guild. Guilds are a combination of nativity, life history (annual, perennial), and stature (forb, grass, rush/sedge, shrub, tree).
3. 	Relative cover of veg by stature (size class)
4. 	Relative cover of veg by life history (annual, perennial, biennial, etc.)
5. 	Relative cover of height category
6. 	Relative cover by all species, just native species, just exotic species

### Answer questions for:
* each year for each site
* each site over time; compare sites relative to years post-project
* all sites together relative to years post-project

### EXERCISES
If you want to learn how to take a raw data set, clean/prep for data analysis.

These are ideas that might be helpful to understand navigating through data and applying data science skills:
- importing numpy, pandas, matplot lib and reading data frame
	- finding/counting number of missing values in data set
	- create categorical variable analysis with matplotlib (ex: bar chart showing geographic location and number of species of each plant in various locations)
- quickly standardize the information and merge the data
- for the areas/plants missing data, use the existing data to extrapolate/fill the blanks -- e.g. stature, native status, plant code, life history

### IDEAS
These are ideas that might be helpful towards the conservancy’s objectives for hackathon:

- create a YOY graph for various geographic locations and the change in plant species counted
- create a model that shows how far off conservancy is away from the “ideal scrub mix” proposed (See below)
- create a revenue model that shows what the projected cost is for achieving ideal mix is for 2016 and how much $ is currently spent

## GOAL(S)

### The Conservancy

Use both qualitative and quantitative information to provide the conservancy with recommendations/tools for lowering costs and/or increasing efficiency.

Interesting findings or other ideas welcome!!

#### Factors to consider
*(note: these are just ideas - by no means all encompassing)*:

##### Habitat analysis

	- YOY analysis of plant patterns: dying, growth / rate
	- make projections using standard species survival rates
	- patterns by species, nativity, life history… etc
	- which plants have the highest turnover yoy
	- area with more YOY height change / growth rate

##### Averages

	- effect of stature on need for pruning
	- intervention planning
	- restoration process

##### Increasing efficiency

	- data collection or modeling
	- new observation modeling
	- analysis of highest cost areas
	- use map/geo for volunteer distribution/recommendation
	- model projections for the upcoming years
	- reference databases to look up how long the different species should last and make habit “upper bound” projections

##### Misc
    - interesting patterns either by area or by plant
    - check biodiversity (Shannon entropy and other scores). Does it change with time?
    - estimate stature composition

### You
 - The opportunity to analyze a real data set and submit a set of recommendations, tools or models that will be directly applied -- i.e., real work experience!

#### Convincing your boss 101:
- you need metrics to support your conclusions
- projected outcomes (short/long-term) are great


## OUTPUT

The conservancy would love your **recommendations on how to be efficient and create a better habitat in the years to come!**

This can be in the form of a
- data driven thesis
- an interesting finding by applying other data sets
- a tool.

After you’ve familiarized yourself with the data, feel free to think outside the box! Should they be thinking about this another way? Is there an useful tool that can be applied?

#### Examples
- series recommendations for the conservancies
	- how to collect the data in a more efficient way
- projections of cost savings (this is how you convince your boss!)
- key metrics that they should be tracking to reduce costs and understand their vegetation
	- ^^^ a model to do so?
- a way to use google images to dynamically assess certain areas -- complement the volunteer work
- interesting finds!!
- a tool for the conservancy to dynamically tell where to send volunteers


## REFERENCE

### Databases

http://plants.usda.gov/java/
http://www.calflora.org/
http://www.californiacoastline.org/

### Map use

[map #1](https://drive.google.com/open?id=0B4lZGkFPeocUNXZSYmY4V3U1dDg)
[map #2](https://drive.google.com/open?id=0B4lZGkFPeocUNXZSYmY4V3U1dDg)
[map #3](https://drive.google.com/open?id=0B4lZGkFPeocUQWtOM0lPZzA0dmM)

- evidence for drawing conclusions -- “more exposed”
- or analysis by stature / extrapolate to be able to estimate stature composition -- dunes, not so many trees so you would expect to see trees…
- if anyone has access to the google earth premium -- you can access time lapse photos

### Cost

- The plants are grown within the parks by one of five national park nurseries.
- The plants are bought for a price per plant that is estimated the year before but isn’t finalized until the plants are released for planting.
- I’m pretty sure the rate goes up every year by at least 25 cents. This year (2015) plants cost $4.75 per pot.

### DEFINITIONS

*Note: some of these terms are only present in the raw data*

##### Site-Year Code
Four letter shortening of the full site name using the first two letters of the first word and first two letters of the second word. If the site has more than two words in the name, initials  are used (e.g. Sutro Dunes = SUDO, Navy Memorial Slope = NMS). The year the observations were made is attached to the site name (e.g. all observations taken in 2012 will have xxxx-2012 as a name).

##### Transect Number
The discrete line along which observations are made. In this study this could be any number between zero and infinity, but should be sequential and at regular intervals.

##### Point Number
Discrete locations along the transect at predetermined intervals where observations are made. In this case a dowel rod is dropped perpendicular to the tape and parallel to a standing person to the ground. In this study this could be any number between zero and infinity, though the numbers should be sequential and at regular intervals.

##### Height
Distance from the ground where plants cross the point on the transect. In this study, height classes were used:
- Low = 0 to 0.5 meters
- Medium = 0.51 to 2.0 meters
- High = 2.1 to 15 meters
- S (for super high) = 15+ meters

##### Scientific Name
The Latin genus and species assigned to the plant based on the Jepson Manual of California (1993 version, it has since been updated with new names in 2012).  The Jepson can be accessed online at ucjeps.berkeley.edu or on CalFlora at www.calflora.org

##### Plant Code
Four letter shortening of the plant name based on the first two letters of the genus and first two letters of the species. If duplicates exist at a site, USDA plants (plants.usda.gov) will be consulted on the number to be added to the end (e.g. TRLA16 is Triteleia laxa, TRLA3 is Trichostemma lanatum).

##### Native Status
Whether the plant is considered native or exotic as defined by the Jepson Manual of California (1993).


##### Life History
Describes whether the plant is an annual or perennial plant. If “shrub” is listed, this should be replaced with “perennial.” If “biennial” is listed, it should be replaced with “annual.”

##### Stature
In other studies this grouping has been called “guild.” In this study the choices are forb*, grass, rush/sedge, shrub, or tree. *A forb is a soft-bodied plant that does not make a woody stem.

##### Common name
The colloquial name for a plant, separate from its Latin name.

##### Dune
This was added by surveyors as another subdivider to the Sutro Dunes. This category can be disregarded.

##### Data Recorder
The person recording the data. Recorded so questions about the point could be addressed to the person who wrote down the data.

##### Reader
The person who “read” the plants on the line (i.e. what plants were touching the dowel at the point). Recorded so questions about the point could be addressed to the person who observed the plants.
