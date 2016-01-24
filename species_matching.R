library(dplyr)
library(tidyr)
library(ggplot2)
library(reshape2)
library(e1071)
library(stringdist)

plant_data = tbl_df(read.csv("cleaned_landsend_veg_2007_2012.csv", 
                             stringsAsFactors = FALSE,
                             na.strings = c("")))
# str(plant_data)
# summary(plant_data)
# unique(plant_data$species)
# table(plant_data)
# 
# unique(plant_data$transect)

plant_data <- plant_data %>%
        mutate(transect = as.factor(transect),
               point = as.factor(point),
               height = as.factor(height),
               species = tolower(species))

#summary(plant_data)

#ggplot(aes(x = Site), fill = Native)

plant_data$height[plant_data$height == 'L'] <- "Low"
plant_data$height[plant_data$height == 'M'] <- "Medium"

plant_data <- separate(data = plant_data, col = site_year_code, into = c("site", "year"))




spec_list <- unique(plant_data$species)
spec_list <- sort(spec_list)
spec_pair <- tbl_df(expand.grid(spec_list, spec_list, stringsAsFactors = FALSE))

spec_pair <- mutate(spec_pair, one = Var1, two = Var2) %>%
        select(one,two)



spec_pair <- mutate(spec_pair, distance = stringdist(one,two)) %>%
        filter(one != two) %>%
        arrange(distance)



by_site_year <- plant_data %>% group_by(year,site) %>%
        summarise(count_species = n_distinct(species)) %>%
        arrange(desc(count_species))

# ggplot(aes(x = Site, y = count_species, fill = Year), data = by_site_year) + 
#         geom_bar(stat = "identity", position = "dodge")


pt_ht <- plant_data %>% select(point,height) %>%
        mutate(height = as.factor(height))
summary(pt_ht)

group_by(pt_ht, height)


by_site_height <- plant_data %>% group_by(year, site, height) %>%
        summarise(count_height = n()) %>%
        filter(year %in% c('2010', '2011', '2012'))
ggplot(aes(site, y= count_height, fill = height),data = by_site_height) +
        geom_bar(stat ='identity',position = "dodge")+ facet_grid(year ~ .)

