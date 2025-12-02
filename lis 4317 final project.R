# Setup and data cleaning
library(readr)
library(dplyr)
library(ggplot2)
library(tsibble)
library(feasts)
library(shiny)
library(forcats)

# read and lightly clean
fatalities <- read_csv("FatalityData.csv")

fatalities_clean <- fatalities |>
  mutate(
    state = factor(state),
    year  = as.integer(year)
  ) |>
  arrange(state, year)

#Time series: line chart + STL decomposition
# convert to tsibble: panel time series by state
fatalities_ts <- fatalities_clean |>
  as_tsibble(
    key   = state,
    index = year
  )

# aggregate mean mrall by year across states
fatalities_us_ts <- fatalities_ts |>
  index_by(year) |>
  summarise(
    mrall_mean = mean(mrall, na.rm = TRUE)
  )

# line chart of 1982–1988 trend
ggplot(fatalities_us_ts, aes(x = year, y = mrall_mean)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "steelblue") +
  labs(
    title = "Average motor-vehicle fatality rate over time",
    x = "Year",
    y = "Mean fatality rate (mrall)"
  ) +
  theme_minimal()

# STL decomposition of the national mean series
fit_stl <- fatalities_us_ts |>
  model(
    STL(mrall_mean ~ trend() + season(window = "periodic"))
  )  # feasts STL wrapper[web:115][web:124]

components(fit_stl) |>
  autoplot() +
  labs(title = "STL decomposition of mean fatality rate") +
  theme_minimal()

# Interactive Shiny app (scatter + histogram)
library(shiny)
library(readr)
library(dplyr)
library(ggplot2)

fatalities <- read_csv("FatalityData.csv") |>
  mutate(
    state = factor(state),
    year  = as.integer(year)
  )

ui <- fluidPage(
  titlePanel("Traffic Fatalities Explorer"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "year",
        "Year:",
        min = min(fatalities$year),
        max = max(fatalities$year),
        value = min(fatalities$year),
        step  = 1,
        sep   = ""
      ),
      selectInput(
        "xvar",
        "X variable:",
        choices = c("Beer tax" = "beertax",
                    "Minimum legal drinking age" = "mlda",
                    "Vehicle miles" = "vmiles",
                    "Unemployment rate" = "unrate",
                    "Per-capita income" = "perinc"),
        selected = "beertax"
      ),
      checkboxGroupInput(
        "sanctions",
        "Include states with:",
        choices = c("Jail sanctions" = "jaild",
                    "Community service sanctions" = "comserd"),
        selected = c("jaild", "comserd")
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Scatter plot", plotOutput("scatterPlot")),
        tabPanel("Histogram of mrall", plotOutput("histPlot"))
      )
    )
  )
)

server <- function(input, output, session) {
  
  year_data <- reactive({
    d <- filter(fatalities, year == input$year)
    
    # optional filtering by sanctions
    if (!is.null(input$sanctions)) {
      if ("jaild" %in% input$sanctions) {
        d <- filter(d, jaild == "yes")
      }
      if ("comserd" %in% input$sanctions) {
        d <- filter(d, comserd == "yes")
      }
    }
    d
  })
  
  output$scatterPlot <- renderPlot({
    ggplot(year_data(),
           aes_string(x = input$xvar, y = "mrall")) +
      geom_point(alpha = 0.7, color = "darkred") +
      labs(
        title = paste("Fatality rate vs", input$xvar, "in", input$year),
        x = input$xvar,
        y = "Fatality rate (mrall)"
      ) +
      theme_minimal()
  })
  
  output$histPlot <- renderPlot({
    ggplot(year_data(), aes(x = mrall)) +
      geom_histogram(
        bins = 15,
        color = "white",
        fill  = "steelblue"
      ) +
      labs(
        title = paste("Distribution of mrall across states in", input$year),
        x = "Fatality rate (mrall)",
        y = "Number of states"
      ) +
      theme_minimal()
  })
}

shinyApp(ui, server)

