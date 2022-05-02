#Scarlett Nguyen
library("shiny")
library("plotly")
source("app_server.R")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    h1("C02 Emissions Finding Summary"),
    p("Emissions of carbon dioxide are one of the primary drivers of climate
   change – and present one of the world’s most pressing challenges. Through aggregating data 
   to get the average C02 per capital in each country/region listed in the dataset, 
    we've learned that", highest_avg_c02_per_capita_country, " and", 
    lowest_avg_c02_per_capita_country, " are the countries with highest and lowest
    annual prodyction-based emissions of carbon dioxide (measured in tonnes per person) 
    respectively. ", highest_avg_c02_year, " is the year that has the highest average
    C02 per capita since 2000. ", highest_cum_c02_location, " is the region with highest 
    cumulative C02 emission which can be attributed to rapid growth and industrialization.
    Meanwhile, ", highest_co2_per_GDP_location, "is the region with highest annual 
    production-based emissions of carbon dioxide (CO2), measured in kilograms per 
    dollar of GDP overall.")
  )
)

plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "y_axis_input",
    label = "Y-axis",
    choices = list("CO2 Emission per Capita from Coal", 
                   "CO2 Emission per Capita from Cement",
                   "CO2 Emission per Capita from Oil"),
    selected = "CO2 Emission per Capital from Oil"),
)

plot_main <- mainPanel(
  plotlyOutput(outputId = "CO2emissionsplot")
)

plot_tab <- tabPanel(
  "Interactive Visualisation",
  h2("CO2 Emissions per Capita"),
  sidebarLayout(
    plot_sidebar,
    plot_main
  ),
  radioButtons(
    inputId = "radioinput", 
    label = "Color Options", 
    choices = list("Red" , "Blue", "Green")),
  p("Coal, oil, and cement are some of the main sources of carbon dioxide emissions. 
    This graph demonstrates the  difference in CO2 emissions per capita from each 
    of the aforementioned sources. From the graphs, we see a drastic increase in 
    the amount of CO2 emissions from these sources from 1800. Out of the three sources, 
    coal seems like the biggest contributor to the carbon dioxide emissions in the world.")
)

ui <- navbarPage(
  "CO2 Emissions", 
  intro_tab, 
  plot_tab,
)




