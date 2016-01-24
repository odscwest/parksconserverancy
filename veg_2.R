##### importing vegatation data and getting sense of data
veg <- read.csv("/Users/pdavoud/Dropbox/Cloudera/parksconserverancy-master 3/cleaned_landsend_veg_2007_2012.csv", na.strings = "")
head(veg)
dim(veg)
lapply(veg, class)

##### splitting site.year.code variable into site variable and time variable
veg$site_year_code <- as.character(veg$site_year_code)
t <- strsplit(veg$site_year_code, "-")
veg$site <- sapply(1:3668, function (x) t[[x]][1])
veg$year <- sapply(1:3668, function (x) t[[x]][2])
head(veg)

##### Different way to split
# lapply(strsplit(as.character(veg$Site.YearCode, "-", "[", 1)))

##### transforming transect and point variables into factors
veg$transect <- as.factor(veg$transect)
veg$point <- as.factor(veg$point)

##### cleaning up height variable
veg$height[veg$height == "L"] <- "Low"
veg$height[veg$height == "M"] <- "Medium"
veg$height[veg$height == "H"] <- "High"
veg$height[veg$height == "L "] <- "Low"

##### exploring data a bit
# bar plot of species. there are duplicate species listed
barplot(table(veg$species), cex.names = .3, las = 2)
length(unique(veg$species)) 

##### looking at time as a factor and realizing species has multiple entries
table(veg$year)
table(veg$year, veg$Height)
dotplot(table(veg$Species, veg$year), beside = TRUE)
?barplot
library(lattice)
levels(veg$Species) #171
unique(veg$Species)
unique(as.character(veg$Species))
class(veg$Species)

##### playing around with dplyr and ggplot2
library(dplyr)
library(ggplot2)
head(veg)

#### dplyr code:
# another way to assigment class to variables
veg <- veg %>% 
      mutate(Transect = as.factor(transect),
             Point = as.factor(point))

# grouping data by year and site and getting # of species
by_site_year <- veg %>% group_by(year, site) %>% summarise(count_species = n_distinct(species)) %>%
                arrange(desc(count_species))

ggplot(aes(x = site, y = count_species, fill = year), data = by_site_year) +
      geom_bar(stat = "identity", position = "Dodge")

ggplot(aes(x = site, y = count_species), data = by_site_year) +
  geom_bar(stat = "identity")

# grouping by SUDO site
SUDO <- veg %>% filter(site == "SUDO")
SUDO
SUDO_by_year <- SUDO %>% group_by(year) %>% summarise(num_species = n_distinct(species))
table(SUDO$year, SUDO$Species)

# grouping by height
by_height_year <- veg %>% 
                  group_by(year, site, height) %>% 
                  summarise(count = n()) %>% 
                  filter(year %in% c("2010", "2011", "2012"))

# creating plot for height information
ggplot(aes(x = site, y = count, fill = height), data = by_height_year) +
  geom_bar(stat = "identity", position = "Dodge") + facet_grid(year ~ .)

# grouping by plant cover
plant_cover <- veg %>% 
               group_by(year, site, native_status) %>%    
               filter(!is.na(native_status)) %>%
               summarise(count = n()) %>%
               filter(year %in% c("2008","2009","2010","2011","2012")) %>%
               mutate(pct=100*count/sum(count))

# plot for plant cover        
ggplot(aes(x = site, y = pct, fill = native_status), data = plant_cover) +
  geom_bar(stat = "identity", position = "Dodge") + facet_grid(year ~ .)

#### things to look into in the future
#fuzzy matching
# merge by string matching, jwdistance

# tidyR
# veg <- separate(data = veg, col = Site.YearCode, into = c("Site", "Year"))



