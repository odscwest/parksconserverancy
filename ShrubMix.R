#install.packages(dplyr)
library(dplyr)
# setwd("/Users/yiwenyu/Downloads")
library(ggplot2)

sample=read.csv("landsend_veg_2007_2012.csv") #no.strings option!!!
ideal_mix=read.csv("Ideal mix.csv") #no.strings option!!!

str(sample)
summary(sample)
unique(sample$Height)

sample = sample %>%
  mutate(Transect=as.factor(Transect),Point=as.factor(Point)) 

sample$Height[sample$Height=="L"]="Low"
sample$Height[sample$Height=="H"]="High"
sample$Height[sample$Height=="M"]="Medium"

sample$sitecode =lapply(strsplit(as.character(sample$Site.YearCode),"-"),"[", 1)

sample=mutate(sample,year=unlist(year,recursive = TRUE, use.names = TRUE))
sample=mutate(sample,sitecode=unlist(sitecode,recursive = TRUE, use.names = TRUE))
                                              
                         
sample$year =lapply(strsplit(as.character(sample$Site.YearCode),"-"),"[", 2)

#by site
by_site_year = sample%>% group_by(year,sitecode) %>%
  summarise(count_species=n_distinct(Species)) #%>%
  #ascending by year
          str(sample)      

ggplot(data=by_site_year,aes(x=sitecode,y=count_species,fill=year) )
+geom_bar(stat="identity",position="dodge")

#by stature
by_stature_year = sample%>% group_by(year,Stature) %>%
  summarise(count_species=n_distinct(Species)) #%>%
#ascending by year
str(sample)      

ggplot(data=by_stature_year,aes(x=Stature,y=count_species,fill=year) )+geom_bar(stat="identity",position="dodge")

#facet_grid

#summary()#hashtable

sub=sample %>% filter(sample$sitecode=="SUDU")    

#Current Scrub mix
Shrub_sample <- sample[ which(sample$Stature=='Shrub' ), ]
Shrub2010=Shrub_sample[which(Shrub_sample$year=='2010'),]
Shrub2011=Shrub_sample[which(Shrub_sample$year=='2011'),]
Shrub2012=Shrub_sample[which(Shrub_sample$year=='2012'),]

ShrubMix_2010 = Shrub2010%>% group_by(Species) %>%
  summarise(count_species=n()) #%>%
ShrubMix_2011 = Shrub2011%>% group_by(Species) %>%
  summarise(count_species=n()) #%>%
ShrubMix_2012 = Shrub2012%>% group_by(Species) %>%
  summarise(count_species=n()) #%>%

ShrubMix_2010_by_site = Shrub2010%>% group_by(sitecode) %>%
  summarise(count_site=n()) #%>%
ShrubMix_2011_by_site = Shrub2011%>% group_by(sitecode) %>%
  summarise(count_site=n()) #%>%
ShrubMix_2012_by_site = Shrub2012%>% group_by(sitecode) %>%
  summarise(count_site=n()) #%>%

somePDFPath = "Shrub Mix.pdf"
pdf(file=somePDFPath)  

#Ideal Mix
slices <- ideal_mix$Pct
slices=as.numeric(sub("%", "",slices))
lbls <- ideal_mix$Ideal.Mix
lbls <- paste(lbls, ideal_mix$Pct) # add percents to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Ideal Shrub Mix")

slices <- ShrubMix_2010$count_species
lbls <- ShrubMix_2010$Species
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Shrub mix 2010",radius = 1, cex = 0.3)

slices <- ShrubMix_2011$count_species
lbls <- ShrubMix_2011$Species
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Shrub mix 2011")

slices <- ShrubMix_2012$count_species
lbls <- ShrubMix_2012$Species
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Shrub mix 2012")

slices <- ShrubMix_2010_by_site$count_site
lbls <- ShrubMix_2010_by_site$sitecode
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Shrub mix 2010-Where do they come from?")

slices <- ShrubMix_2011_by_site$count_site
lbls <- ShrubMix_2011_by_site$sitecode
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Shrub mix 2011-Where do they come from?")
slices <- ShrubMix_2012_by_site$count_site
lbls <- ShrubMix_2012_by_site$sitecode
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Shrub mix 2012-Where do they come from?")

dev.off() 
