library(shiny)
library(markdown)
library(shinyWidgets)
library(reticulate)
library(markdown)
library(shinydashboard) 
library(shinydashboardPlus)
library(tidyverse)
library(shinyjs)
library(dashboardthemes)
library(firebase)
library(shinyAce)

use_virtualenv(Sys.getenv("/home/gordon/workspace/feed/venv"))
source_python("server.py")

offset = 3
modes = getAceModes()

editor = aceEditor(
  outputId = "ace",
  # to access content of `selectionId` in server.R use `ace_selection`
  # i.e., the outputId is prepended to the selectionId for use
  # with Shiny modules
  selectionId = "selection",
  value = "",
  mode = "python",
  placeholder = ""
)
