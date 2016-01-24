library(ggplot2)
library(dplyr)
library(datacomb)

setwd("C:/Users/George Yang/parkmeetup/parksconserverancy-master")

df <- read.csv('landsend_veg_2007_2012.csv', stringsAsFactors = FALSE, na.strings = c('-',''))
df <- read.csv('cleaned_landsend_veg_2007_2012.csv', stringsAsFactors = FALSE, na.strings = c('-',''))
names(df) <- tolower(names(df))

#df <- df[!is.na(df$native_status),]
str(df)
summary(df)
unique(df$species)

df <- df %>% 
  mutate(transect = as.factor(transect),
         point = as.factor(point), 
         species_lower = tolower(species))

df$height[df$height == 'L'] <- 'Low'
df$height[df$height == 'L '] <- 'Low'

df$height[df$height == 'M'] <- 'Medium'
df$height[df$height == 'H'] <- 'High'
df$height[df$height == 'SH'] <- 'Super_High'



unique(df$species_lower)
unique(df$height)
df$species_lower[df$species_lower == 'anagalis arvensis'] <- 'anagallis arvensis'
df$species_lower[df$species_lower == 'gnaphalium luteo-album'] <- 'gnaphalium luteoalbum'
df$species_lower[df$species_lower == 'ceanothus thrysiflorus'] <- 'ceanothus thyrsiflorus'
df$species_lower[df$species_lower == 'anthriscus caucalis'] <- 'anthriscus cacaulis'
df$species_lower[df$species_lower == 'marah fabaceous'] <- 'marah fabaceus'




summary(df)
str(df)
##split the string
#df$site.code <- lapply(strsplit(as.character(df$site.yearcode),
#                                    "-"), "[", 1)

#df$year <- lapply(strsplit(as.character(df$site.yearcode),
#                            '-'), '[', 2)

#df <- df %>% mutate(site.code = as.character(unlist(site.code)),
#                    year = as.character(unlist(year)))

##could also use tidyr
library(tidyr)
df <- separate(data  = df, col = site_year_code, into = c("site", "year"))
#df <- separate(data  = df, col = site.yearcode, into = c("site", "year"))

table(df$year)
summary(df)
by_site <- df %>% group_by(year, site) %>% summarise(count_species = n_distinct(species))

ggplot(aes(x = site, y = count_species, fill = year), data = by_site) +
  geom_bar(stat='identity', position = 'dodge')
colnames(df)
table(df$year)


by_species <- df %>% group_by(year, plant_code) %>% summarise(n=n())
by_annual <- df %>% group_by(year, life_history) %>% summarise(n=n())
ggplot(aes(x=n, color = plant_code), data = by_species)+geom_histogram()

by_species <- df %>% group_by(year, plant_code) %>% summarise(n=n())
by_species$year <- as.integer(by_species$year)
by_species_select <- filter(by_species, plant_code == 'ABLA' | plant_code == 'LOSP')
ggplot(aes(x = year, y = n, color = plant_code), data = by_species_select) +
  geom_line()
unique(by_species$plant_code)


str(by_species)
ggplot(aes(x = year, y = n), data = by_species[by_species$species_lower == 'hordeum sp.',])+geom_line()
colnames(df)
by_native <- df %>% group_by(year, height) %>% summarise(n = n())
ggplot(aes(x=year, y = n, fill = height), data = by_native)+geom_bar(stat = 'identity')

summary(df)
