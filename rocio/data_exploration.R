
library(dplyr)
library(ggplot2)
library(tidyr)

plant_data <- read.csv("landsend_veg_2007_2012.csv", na.strings = c("-", ""))

plant_data2 <- read.csv("cleaned_landsend_veg_2007_2012.csv", na.strings = c(""))

head(plant_data, 10)
str(plant_data)
# how many species?
summary(plant_data)
unique(plant_data$species)
table(plant_data$species)

# covnert rtransect to factor
plant_data <- plant_data %>% 
              mutate(Transect = as.factor(Transect),
                    Point = as.factor(Point),
                    Species = tolower(Species))
str(plant_data)
plant_data <- mutate(plant_data, Transect = as.factor(Transect) )

summary(plant_data)

# recode Height variables ??
plant_data$Height[plant_data$Height == "L"] <- "Low"
plant_data$Height[plant_data$Height == "M"] <- "Medium"
summary(plant_data)

# need to split the Site.YearCode variable by site and year

#plant_data$site.code <- lapply(strsplit(as.character(plant_data$Site.YearCode),
 #                                       "-"), "[", 1)
#plant_data$year <- lapply(strsplit(as.character(plant_data$Site.YearCode),
#                                   "-"), "[", 2)

plant_data <- plant_data %>% mutate(site.code = as.charater(unlist(site.code)),
                                    year = as.character(unlist(year)),
                                    Species = tolower(Species))
plant_data <- separate(data = plant_data, col = Site.YearCode, into=c("Site", "Year"))

summary(plant_data)
# how many species per transect

by_transect <- plant_data %>% group_by(Transect) %>%
                summarise(count_species = n_distinct(Species)) %>%
                arrange(desc(count_species))
head(by_transect, 20)

ggplot(aes(x = Transect, y = count_species), 
       data = by_transect) + geom_bar(stat = "identity")
qplot(x=Transect, y=count_species,
                       data=by_transect, geom="bar", stat="identity")

ggplot(aes(x = Site, y = Species), fill = Native.Status, data = plant_data) + 
    geom_bar(stat = )


# by site
by_site_year <- plant_data %>% group_by(Year, Site) %>%
            summarise(count_species = n_distinct(Species)) %>%
            arrange(desc(count_species))
ggplot(aes(x = Site, y = count_species), data = by_site_year) +
    geom_bar(stat="identity")

ggplot(aes(x = Site, y = count_species, fill = Year), data = by_site_year) +
    geom_bar(stat="identity", position = "dodge")


SUDO <- plant_data %>% filter(Site == "SUDO") 

SUDO_by_year <- SUDO %>% group_by(Year, Life.History) %>% summarise(num_species = n_distinct(Species))


# native vs non

by_lh_year <- plant_data %>% group_by(Year, Life.History) %>%
                    summarise(count = n())




head(plant_data2)
str(plant_data2)

plant_data <- separate(plant_data2, site_year_code, into = c("site", "year"))

# covnert transect, point to factor
plant_data <- plant_data %>% 
    mutate(Transect = as.factor(transect),
           Point = as.factor(point),
           Species = tolower(species))


by_site_transcet <- plant_data %>% group_by(site, transect) %>% 
                    summarise(count = n_distinct(species))
by_species <- plant_data %>% group_by(plant_code, species) %>% summarise(count = n())

unique(plant_data$height)

plant_data$height[plant_data$height == "L"] <- "Low"
plant_data$height[plant_data$height == "L "] <- "Low"
plant_data$height[plant_data$height == "M"] <- "Medium"
plant_data$height[plant_data$height == "H"] <- "High"
plant_data <- droplevels(plant_data)
str(plant_data)
summary(plant_data)
grhist(plant_data$height)

ggplot(aes(height, fill = site), data = plant_data) + geom_bar(position = "dodge")

by_site_height <- plant_data %>% group_by(year, site, height) %>% 
    summarise(count_height = n()) %>% filter(year %in% c("2010", "2011", "2012"))

ggplot(aes(site, y = count_height, fill = height), data = by_site_height) + 
    geom_bar(stat = "identity", position = "dodge") + facet_grid(year ~ .)



# by site
by_site_year <- plant_data %>% group_by(year, site) %>%
    summarise(count_species = n_distinct(species)) %>%
    arrange(desc(count_species))
ggplot(aes(x = site, y = count_species), data = by_site_year) +
    geom_bar(stat="identity")

ggplot(aes(x = site, y = count_species, fill = year), data = by_site_year) +
    geom_bar(stat="identity", position = "dodge")
