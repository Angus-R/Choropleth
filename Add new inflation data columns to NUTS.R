library(readxl)
library(sf)
library(leaflet)
library(leaflet.extras)
library(htmltools)
library(tidyverse)
library(RColorBrewer)
setwd("H:/Finance/R/Project R/choropleth")

load("EU_0_NUTS.Rdata")
load("Inf533687_7.Rdata")
EU_0_NUTS <- EU_0_NUTS[-c(14:18)]
EU_0_NUTS <- EU_0_NUTS[-c(2:9)]#### Slim down shp file




#### Extend EU_O_NUTS with extra data columns
Q2_2020 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                           TIME == "2020-Q2",
                           Measure == "Percentage change on the same period of the previous year")
Q2_2020 <- Q2_2020[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q2_2020)[2] <- "Q2_2020"
names(Q2_2020)[3] <- "V_Q2_2020"
EU_0_NUTS <- EU_0_NUTS %>% left_join(Q2_2020)


Q1_2020 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                  TIME == "2020-Q1",
                  Measure == "Percentage change on the same period of the previous year")
Q1_2020 <- Q1_2020[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q1_2020)[2] <- "Q1_2020"
names(Q1_2020)[3] <- "V_Q1_2020"

EU_0_NUTS <- EU_0_NUTS %>% left_join(Q1_2020)
######################################################
Q4_2019 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                           TIME == "2019-Q4",
                           Measure == "Percentage change on the same period of the previous year")
Q4_2019 <- Q4_2019[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q4_2019)[2] <- "Q4_2019"
names(Q4_2019)[3] <- "V_Q4_2019"

EU_0_NUTS <- EU_0_NUTS %>% left_join(Q4_2019)
#####################################################
Q3_2019 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                           TIME == "2019-Q3",
                           Measure == "Percentage change on the same period of the previous year")
Q3_2019 <- Q3_2019[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q3_2019)[2] <- "Q3_2019"
names(Q3_2019)[3] <- "V_Q3_2019"
EU_0_NUTS <- EU_0_NUTS %>% left_join(Q3_2019)

#####################################################
Q2_2019 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                           TIME == "2019-Q2",
                           Measure == "Percentage change on the same period of the previous year")
Q2_2019 <- Q2_2019[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q2_2019)[2] <- "Q2_2019"
names(Q2_2019)[3] <- "V_Q2_2019"
EU_0_NUTS <- EU_0_NUTS %>% left_join(Q2_2019)
#####################################################
Q1_2019 <- df_1 %>% filter(Subject == "CPI: 01-12 - All items", 
                           TIME == "2019-Q1",
                           Measure == "Percentage change on the same period of the previous year")
Q1_2019 <- Q1_2019[-c(2,3,4,6)]   ##### Slim down inflation

### names(Q1_2020)[1] <- "Cn"
names(Q1_2019)[2] <- "Q1_2019"
names(Q1_2019)[3] <- "V_Q1_2019"
EU_0_NUTS <- EU_0_NUTS %>% left_join(Q1_2019)




# Make permanent
Inflation_4_quarters_NUTS <- EU_0_NUTS
save(EU_0_NUTS, file = "Inflation_4_quarters_NUTS.Rdata")
save(EU_0_NUTS, file = "EU_0_NUTS_4.Rdata")
#############################################
# Plot

labels <- sprintf(
  "<strong>%s</strong><br/>Inflation %% %g<br>%s ",
  EU_0_NUTS$Country, round(EU_0_NUTS$V_Q2_2020 ,2), EU_0_NUTS$Q2_2020) %>% lapply(htmltools::HTML)

mycolours <- brewer.pal(8, "Blues")
bins <- c(-2.0,-1.0,0,1.0,2.0,3.0,4.0,5.0, Inf)
pal <- colorBin("Purples", domain = EU_0_NUTS$V_Q2_2020, bins = bins)

m <- leaflet(EU_0_NUTS) %>%
  addTiles() %>%
  setView(lat = 50, lng = 15, zoom = 5) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addPolygons(fillColor =  ~pal(V_Q2_2020),                  ##### use colour palette 
              weight = 2, opacity = 1, 
              color = "white", dashArray = 3, fillOpacity = 0.7, 
              highlight = highlightOptions(               ##### Frame in black
                weight = 5, color = "#666",
                dashArray = "",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto")) %>%
  addLegend(pal = pal, values = ~V_Q2_2020, opacity = 0.7, title = NULL,
            position = "bottomright")  



m
