#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(sf)
library(leaflet)
library(leaflet.extras)
library(htmltools)
library(tidyverse)
library(RColorBrewer)
# load("EU_0_NUTS_4.Rdata")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    inf_data <- reactive({
     as.numeric(input$period)+1
                })
    
    gdp_data <- reactive({
      as.numeric(input$gdp_yr)
    })
    
    
    
   ####  choro_inf  
    output$choro_inf <- renderLeaflet({

      #new_labels <- paste0("V_", input$period,)
      #target <- as.name(new_labels)
      
      labels <- sprintf(
        "<strong>%s</strong><br/>Inflation %% %g",
        EU_0_NUTS$Country, round(EU_0_NUTS[[inf_data()]],2)) %>% lapply(htmltools::HTML)
      # EU_0_NUTS$Country, round(EU_0_NUTS[[inf_data()]],2), input$period) %>% lapply(htmltools::HTML) # remove 3rd display variable
      
      mycolours <- brewer.pal(8, "Blues")
      bins <- c(-2.0,-1.0,0,1.0,2.0,3.0,4.0,5.0, Inf)
      pal <- colorBin(input$pal_col, domain = EU_0_NUTS[[inf_data()]], bins = bins)
      
      m <- leaflet(EU_0_NUTS) %>%
        addTiles() %>%
        setView(lat = 50, lng = 15, zoom = 4) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(fillColor =  ~pal(EU_0_NUTS[[inf_data()]]),                  ##### use colour palette 
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
        addLegend(pal = pal, values = ~inf_data(), opacity = 0.7, title = NULL,
                  position = "bottomright")  
      m

    })
    ####---------
    
    
    
    output$choro_gdp <- renderLeaflet({
      
      #new_labels <- paste0("V_", input$period,)
      #target <- as.name(new_labels)
      
      labels <- sprintf(
        "<strong>%s</strong><br/>GDP %g EU average = 100",
        PPS_GDP_SHP$Country, round(PPS_GDP_SHP[[gdp_data()]],2)) %>% lapply(htmltools::HTML)
      # EU_0_NUTS$Country, round(EU_0_NUTS[[inf_data()]],2), input$period) %>% lapply(htmltools::HTML) # remove 3rd display variable
      
      mycolours <- brewer.pal(8, "Blues")
      bins <- c(30,60,90,100,110,120,130,140,160,Inf)
      pal <- colorBin(input$pal_col_gdp, domain = PPS_GDP_SHP[[gdp_data()]], bins = bins)
      
      m <- leaflet(PPS_GDP_SHP) %>%
        addTiles() %>%
        setView(lat = 50, lng = 15, zoom = 4) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(fillColor =  ~pal(PPS_GDP_SHP[[gdp_data()]]),                  ##### use colour palette 
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
        addLegend(pal = pal, values = ~gdp_data(), opacity = 0.7, title = NULL,
                  position = "bottomright")  
      m
      
    })
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
})
