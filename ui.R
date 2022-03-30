mi1 = menuItem("Home", tabName = "home")
mi2 = menuItem("App", tabName = "app")
sidebar_menu = sidebarMenu(style = "position: fixed; overflow: visible;", mi1, mi2)

ti1 = tabItem(
  tabName = "home",
  fluidRow(column(12, align = "center", h3("Home"))), 
  fluidRow(
    column(12, 
           p("HackerRank meets Codementor for at most two hours of coding work"), 
           offset = offset)
    ),
  fluidRow(
    column(4, p("Editor"), editor), 
    column(4, p("Standard Out"), verbatimTextOutput("code_output")),
    column(4, p("Tests Review"))
    ),
  fluidRow(column(12, actionButton("submit_code", "Submit"))),
  
)

ti2 = tabItem(
  tabName = "app",
  fluidRow(column(12, align = "center", h3("Feed"))),
  fluidRow(
    column(12, align = "center", 
           reqSignout(actionButton("register_modal", "Register")), 
           reqSignout(actionButton("signin_modal", "Log In")),
           reqSignin(actionButton("signout", "Log Out"))
           )
  ),
  fluidRow(column(12, verbatimTextOutput("user_info"), offset = offset))
)

tab_items = tabItems(ti1, ti2)

header = dashboardHeader(title = "codetogo")
sidebar = dashboardSidebar(sidebarMenuOutput("sidebar"), sidebar_menu)
body = dashboardBody(useShinyjs(), useFirebase(), tab_items)

ui = dashboardPage(header, sidebar, body)
