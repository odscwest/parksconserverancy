``` r
library(dplyr)
library(ggplot2)
library(tidyr)
plant_data <- tbl_df(read.csv("cleaned_landsend_veg_2007_2012.csv", na.strings = c("")))
head(plant_data)
```

    ## Source: local data frame [6 x 9]
    ## 
    ##   site_year_code transect point height              species native_status
    ##           (fctr)    (dbl) (dbl) (fctr)               (fctr)        (fctr)
    ## 1      NUWO-2012        5    90    Low                   NA            NA
    ## 2      NUWO-2012       13   150    Low                   NA            NA
    ## 3       NMS-2010        8    20    Low achillea millefolium        Native
    ## 4       NMS-2010       24     4    Low achillea millefolium        Native
    ## 5       NMS-2010       48    16    Low achillea millefolium        Native
    ## 6       NMS-2010       60    16    Low achillea millefolium        Native
    ## Variables not shown: life_history (fctr), plant_code (fctr), stature
    ##   (fctr)

``` r
plant_data <- separate(plant_data, site_year_code, into = c("site", "year"))


# covnert transect, point to factor
plant_data <- plant_data %>% 
    mutate(transect = as.factor(transect),
           point = as.factor(point),
           species = tolower(species))


# recode incomplete variables
plant_data$height[plant_data$height == "L"] <- "Low"
plant_data$height[plant_data$height == "L "] <- "Low"
plant_data$height[plant_data$height == "M"] <- "Medium"
plant_data$height[plant_data$height == "H"] <- "High"
plant_data <- droplevels(plant_data)

by_transect <- plant_data %>% group_by(transect) %>%
                summarise(count_species = n_distinct(species)) %>%
                arrange(desc(count_species))


head(by_transect, 20)
```

    ## Source: local data frame [20 x 2]
    ## 
    ##    transect count_species
    ##      (fctr)         (int)
    ## 1        16            53
    ## 2         1            44
    ## 3         6            41
    ## 4         5            39
    ## 5         8            39
    ## 6        20            37
    ## 7        36            37
    ## 8         4            35
    ## 9         9            34
    ## 10       13            31
    ## 11       28            31
    ## 12       56            31
    ## 13       12            30
    ## 14       32            30
    ## 15       60            30
    ## 16       11            28
    ## 17       48            27
    ## 18       18            26
    ## 19       40            25
    ## 20       64            25

``` r
# by site
by_site_year <- plant_data %>% group_by(year, site) %>%
            summarise(count_species = n_distinct(species)) %>%
            arrange(desc(count_species))

ggplot(aes(x = site, y = count_species, fill = year), data = by_site_year) +
    geom_bar(stat="identity") + labs(title = "Numbers of each species at each site by year") + facet_grid(year ~.) + ylab("count of species")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-2-1.png)<!-- -->

``` r
SUDU <- plant_data %>% filter(site == "SUDU") 
SUDU_by_year <- SUDU %>% group_by(year,
                                  life_history) %>% 
    summarise(num_species = n_distinct(species))
```

``` r
by_site_transect <- plant_data %>% group_by(site, transect) %>% 
                    summarise(count = n_distinct(species))

# SUDU site
by_site_transect_SUDU <- plant_data %>% group_by(year,site, transect,native_status) %>% 
                    summarise(count = n_distinct(species)) %>% filter(site == "SUDU") %>% filter(year %in% c("2010", "2011", "2012"))

ggplot(aes(x = transect, y = count, fill = native_status), data = by_site_transect_SUDU) + geom_bar(stat="identity") +
    facet_grid(year ~ .) + labs(title = "Distribtuion of Species in the SUDU site") + ylab("Number of species")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-4-1.png)<!-- -->

``` r
# NMS
by_site_transect_NMS <- plant_data %>% group_by(year,site, transect,native_status) %>% 
                    summarise(count = n_distinct(species)) %>% filter(site == "NMS")%>% filter(year %in% c("2010", "2011", "2012"))

ggplot(aes(x = transect, y = count, fill = native_status), data = by_site_transect_NMS) + geom_bar(stat="identity") +
    facet_grid(year ~.) + labs(title = "Distribution of Species in the NMS site") + ylab("Number of species")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-4-2.png)<!-- -->

``` r
# NUWO

by_site_transect_NUWO <- plant_data %>% group_by(year,site, transect,native_status) %>% 
                    summarise(count = n_distinct(species)) %>% filter(site == "NUWO")
ggplot(aes(x = transect, y = count, fill = native_status), data = by_site_transect_NUWO) + geom_bar(stat="identity") +
    facet_grid(year ~.) + labs(title = "Distribution of Species in the NUWO site") + ylab("Number of species")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-4-3.png)<!-- -->

``` r
# EAPO

by_site_transect_NUWO <- plant_data %>% group_by(year,site, transect,native_status) %>% 
                    summarise(count = n_distinct(species)) %>% filter(site == "EAPO")
ggplot(aes(x = transect, y = count, fill = native_status), data = by_site_transect_NUWO) + geom_bar(stat="identity") +
    facet_grid(year ~.) + labs(title = "Distribution of Species in the EAPO site") + ylab("Number of species")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-4-4.png)<!-- -->

``` r
by_species <- plant_data %>% group_by(plant_code, species) %>% summarise(count = n())


by_site_height <- plant_data %>% group_by(year, site, height) %>% 
    summarise(count_height = n()) %>% filter(year %in% c("2010", "2011", "2012"))

ggplot(aes(site, y = count_height, fill = height), data = by_site_height) + 
    geom_bar(stat = "identity", position = "dodge") + facet_grid(year ~ .) + labs(title = "Distribution of Plant Heights Among Sites")
```

![](conservancy_files/figure-markdown_github/unnamed-chunk-5-1.png)<!-- -->
