#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage("Economic Data",

   ##############   Layout(sidebarPanel, mainPanel) !!!!!!!!!!!!!!
tabPanel("Inflation",
   #tabPanel(h1("Inflation Data 2020-19 (Quarterly)", align = "center")),
    fluidRow(column(12,
             h1("Eurostat Inflation Data 2020-2019"),
             p("This is the quarterly CPI (01-12 - All Items) percentage change on previous year"),
             p("Select quarterly period and colour palette and hover over country for exact inflation rate")),
             hr()
            ),
        sidebarPanel(width = 3,
            selectInput("period","Choose Quarter",
                        choices = c("Q2_2020" = 6,"Q1_2020" = 8, 
                                    "Q4_2019" = 10,"Q3_2019" = 12,
                                    "Q2_2019" = 14,"Q1_2019" = 16)),
            selectInput("pal_col", "Choose Colour Scheme",
                        choices = c("Purples", "Blues", "YlOrRd", "RdYlBu", "YlGnBu", "Spectral", "BuPu", "PuBu", "OrRd"))),
        mainPanel(leafletOutput("choro_inf", height = 600)),
        
         ),#TabPan1
             
   
 tabPanel("GDP in PPS",
          fluidRow(column(12,
                   h1("OECD GDP in per capita PPS 2019 - 2008"),
                   p("GDP reflects the total value of all goods and 
                     services produced less the value of goods and services used for intermediate consumption 
                     in their production. Expressing GDP in PPS (purchasing power standards) eliminates differences 
                     in price levels between countries.  "),
                   p("Select  period and colour palette and hover over country for exact growth rate")),
                   hr()
                             ),
        sidebarPanel(width = 3,
            selectInput("gdp_yr","Choose Year",
                                       choices = c("GDP_2019" = 15,"GDP_2018" = 14,
                                                   "GDP_2017" = 13,"GDP_2016" = 12,
                                                   "GDP_2015" = 11,"GDP_2014" = 10,
                                                   "GDP_2013" = 9,"GDP_2012" = 8,
                                                   "GDP_2011" = 7,"GDP_2010" = 6,
                                                   "GDP_2009" = 5,"GDP_2008" = 4)),
                selectInput("pal_col_gdp", "Choose Colour Scheme",
                                       choices = c("Purples", "Blues", "YlOrRd", "RdYlBu", 
                                                   "YlGnBu", "Spectral", "BuPu", "PuBu", "OrRd"), selected = "RdYlBu")),
        
        
                mainPanel(leafletOutput("choro_gdp", height = 600))
                 
              )  #Tab Pan2
         
   )    #Title
   )    #Nav
   






    # 
    # 
    # tabPanel("Tab 3"),
    # tabPanel("Tab 4")

