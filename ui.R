library(shiny)

shinyUI(fluidPage(
    
    tabsetPanel(
        tabPanel("Family Tree",
                 collapsibleTreeOutput("tree" ,width = "100%", height = "400px")
        ), 
        tabPanel("Filtering Tree", 
                 selectInput(inputId = "treeid", 
                             label = "Choose the Ancestor", 
                             choices = unique(df_fam$child), 
                             selected = first(unique(df_fam$child))), 
                 
                 collapsibleTreeOutput("tree_filter",width = "100%", height = "400px")
                 
        ), 
        
        tabPanel("Who our Ancestor",
                 fluidRow(
                     column(width = 3, 
                            selectInput(inputId = "name1", 
                                        label = "Select a Name", 
                                        choices = unique(df_fam$child), 
                                        selected = first(unique(df_fam$child)))
                     ),
                     column(width = 3,
                            selectInput(inputId = "name2", 
                                        label = "Select a Name", 
                                        choices = unique(df_fam$child), 
                                        selected = last(unique(df_fam$child)))
                     )
                 ),
                 collapsibleTreeOutput("tree_search",width = "100%", height = "400px")
        )
    )
))
