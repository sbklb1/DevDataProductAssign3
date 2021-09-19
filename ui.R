#
# This is the user-interface definition of a Shiny web application.
#
# This application enables users to investigate the impact of object size 
# (given as Major Axis) on the visual magnitue for astronomical objects
# in the Messier Catalog.
#  
# Users can select different groups of object types (galaxy, cluster, etc) as
# part of the plot display.
#
# Each point in the plot is the Messier Catalog ID
#
# Finally, the data is brushable in the plot and displays a linear fit 
# for the selected data
#
#  Messier Objects display info
#
library(shiny)
library(dplyr)
library(ggplot2)
library(tidyr)

# Define UI for application that draws looks at Messier data
shinyUI(fluidPage(
    # Application title
    titlePanel("Messier Object Brightness Application"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
         sidebarPanel(
            titlePanel("Object Selection and Model"),
            h4("Application shows how Messier Object magnitude relates to size."),
            
            # Select which Data Groups(s) to plot
            #   Long version would include these
            #   N = Nebula
            #   SNR = SuperNova Remnant
            #   PN = Planetary Nebula
            #   RN = reflection Nebula
            #   Gx = Galaxy
            #   GC = Glob Cluster
            #   OC = Open Cluster
            #   CL = star cloud
            #
            #  This is reduced version and makes SNR, PN, RN all N
            #   also make CL and others x
            
            checkboxGroupInput(inputId = "ObjType",
                               label = "Select Object Type(s):",
                               choices = c("Galaxies" = "Gx",
                                            "Globular Clusters" = "GC",
                                            "Open Clusters" = "OC",
                                            "Nebulaes (Planetary, Reflection, etc)" = "N", 
                                            "Others (cloud, star, etc)" = "x"),
                               selected = c("N", "Gx")),
            
            h3("Linear Model"),
            h4("Brush data to get linear fit"),
            h4("VMag = " ,
            textOutput("slopeOut"), "* MajorAxis + ", textOutput("intOut")),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Messier Grouped Object Magnitude vs Size"),
            plotOutput("plot1", brush = brushOpts(id="brush1"))
        )
    ), 
    
    h3("This application enables users to investigate the impact of 
        object size (given as Major Axis) on the visual magnitude for 
        astronomical objects in the Messier Catalog."),

    h3("Users can select different groups of object types (galaxy, 
        cluster, etc), and the plot display will automatically update."),
    
    h3("At least one object grouping is required or an error will display."),

    h3("Try the Globular Cluster group.  It is mostly linear with size.  As a 
       Globular cluster gets larger (say M22 or M13), will be brighter than
       a smaller cluster (say M79)."),
    
    h3("Each point in the plot is labeled with the Messier Catalog ID"),

    h3("Finally, the data is brushable in the plot and provides 
        a linear fit for the selected data.  If the group is changed,
        points will need to be rebrushed to update the fit."),
    
    h4("Data is a subset of the Stellerium Nebulae Catalog:  
        https://github.com/Stellarium/stellarium/blob/master/nebulae/default/catalog.txt"),
    
    h4("This application resides:  https://sbklb1.shinyapps.io/MessierAssign/")
    ))
