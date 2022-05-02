#Scarlett Nguyen
library("dplyr")
library("ggplot2")
library("shiny")
library("plotly")

c02_dts <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

#View(c02_dts)

server <- function(input, output) {
  
  output$CO2emissionsplot <- renderPlotly({
    new_dts <- c02_dts %>%
    select(year, coal_co2_per_capita, cement_co2_per_capita, oil_co2_per_capita)
    colnames(new_dts) <- c("Year", "CO2 Emission per Capita from Coal", 
                           "CO2 Emission per Capita from Oil",
                           "CO2 Emission per Capita from Cement")
    plot1 <- ggplot(data = new_dts) + 
    geom_point(mapping = aes(x = Year, y = !!as.name(input$y_axis_input)), col = input$radioinput)
    
    plotly_plot <- ggplotly(plot1)
    
    return(plotly_plot)
  })
}

#First variable: What is the average C02 per capita in each country?
avg_c02_per_capita_by_country <- c02_dts %>%
  group_by(country) %>%
  summarize(avg_c02_per_capita = mean(co2_per_capita, na.rm = TRUE))

#Second variable: Which country has the highest average C02 per capita?
highest_avg_c02_per_capita_country <- avg_c02_per_capita_by_country %>%
  filter(avg_c02_per_capita == max(avg_c02_per_capita, na.rm = TRUE)) %>%
  pull(country)
         
#Which country has the lowest average C02 per capita?
lowest_avg_c02_per_capita_country <- avg_c02_per_capita_by_country %>%
  filter(avg_c02_per_capita == min(avg_c02_per_capita, na.rm = TRUE)) %>%
  pull(country)

#Third variable: Which year has the highest AVERAGE C02 per capita after 2000? 
highest_avg_c02_year <- c02_dts %>% 
  filter(year >= 2000) %>%
  group_by(year) %>%
  summarize(avg_c02_by_year = mean(co2_per_capita, na.rm = TRUE)) %>%
  filter(avg_c02_by_year == max(avg_c02_by_year)) %>%
  pull(year)
  
#Fourth variable: Which location has the highest cumulative C02 emission?
highest_cum_c02_location <- c02_dts %>%
  filter(country != "World") %>%
  group_by(country) %>%
  summarize(highest_cum_c02_location = max(cumulative_co2, na.rm = TRUE)) %>%
  filter(highest_cum_c02_location == max(highest_cum_c02_location)) %>%
  pull(country)

#Which location has the lowest cumulative C02 emission?
lowest_cum_c02_location <- c02_dts %>%
  filter(country != "World") %>%
  group_by(country) %>%
  summarize(lowest_cum_c02_location = min(cumulative_co2, na.rm = TRUE)) %>%
  filter(lowest_cum_c02_location == min(lowest_cum_c02_location)) %>%
  pull(country) 

#Fifth variable: Which location  has the highest C02 per GDP? 
highest_co2_per_GDP_location <- c02_dts %>%
  filter(country != "World") %>%
  group_by(country) %>%
  summarize(highest_co2_per_GDP_location = max(co2_per_gdp, na.rm = TRUE)) %>%
  filter(highest_co2_per_GDP_location == max(highest_co2_per_GDP_location)) %>%
  pull(country)

#Which location  has the lowest C02 per GDP? 
lowest_co2_per_GDP_location <- c02_dts %>%
  filter(country != "World") %>%
  group_by(country) %>%
  summarize(lowest_co2_per_GDP_location = min(co2_per_gdp, na.rm = TRUE)) %>%
  filter(lowest_co2_per_GDP_location == min(lowest_co2_per_GDP_location)) %>%
  pull(country)

