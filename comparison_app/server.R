library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv('../cleaned_landsend_veg_2007_2012.csv', stringsAsFactors = FALSE, na.strings = c('-',''))
names(df) <- tolower(names(df))
##add rows
df <- df %>% 
  mutate(transect = as.factor(transect),
         point = as.factor(point), 
         species_lower = tolower(species))
##clean data
df$height[df$height == 'L'] <- 'Low'
df$height[df$height == 'L '] <- 'Low'
df$height[df$height == 'M'] <- 'Medium'
df$height[df$height == 'H'] <- 'High'
df$height[df$height == 'SH'] <- 'Super_High'

df <- separate(data  = df, col = site_year_code, into = c("site", "year"))

shinyServer(function(input, output) {
  plotcat <- reactive({
    
    by_native <- df %>% group_by(year, native_status) %>% summarise(n = n())
    
    
  })
  
  plotheight <- reactive({
    
    by_native <- df %>% group_by(year, height) %>% summarise(n = n())
    
    
  })
  
  plotlife <- reactive({
    
    by_native <- df %>% group_by(year, life_history) %>% summarise(n = n())
    
    
  })
  
  
  ###output
  output$plant_code_plot <- renderPlot ({
    by_species <- df %>% group_by(year, plant_code) %>% summarise(n=n())
    by_species$year <- as.integer(by_species$year)
    by_species_select <- filter(by_species, plant_code == input$plant_code |
                                plant_code == input$plant_code2)
    
    
    print(ggplot(aes(x = year, y = n, color = plant_code), data = by_species_select) +
            geom_line(size =2))
  })
 
  ###output
  output$species_plot <- renderPlot ({
    by_species <- df %>% group_by(year, species_lower) %>% summarise(n=n())
    by_species$year <- as.integer(by_species$year)
    by_species_select <- filter(by_species, species_lower == input$species |
                                  species_lower == input$species2)
    
    
    print(ggplot(aes(x = year, y = n, color = species_lower), data = by_species_select) +
            geom_line(size = 2))
  })
  
   
  output$cat_plot <- renderPlot ({
    print(ggplot(aes(x= year, y = n, fill = native_status), 
                 data = plotcat())
          +geom_bar(stat = 'identity'))
  })
  
  output$height_plot <- renderPlot ({
    print(ggplot(aes(x= year, y = n, fill = height), 
                 data = plotheight())
          +geom_bar(stat = 'identity'))
  })
  
  output$life_plot <- renderPlot ({
    print(ggplot(aes(x= year, y = n, fill = life_history), 
                 data = plotlife())
          +geom_bar(stat = 'identity'))
  })
  
  
})
