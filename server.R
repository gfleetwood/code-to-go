server <- function(input, output, session) {
  
  #runjs("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")
  f <- FirebaseEmailPassword$new()
  
  register <- modalDialog(
    title = "Register",
    textInput("email_create", "Your email"),
    passwordInput("password_create", "Your password"),
    footer = actionButton("create", "Register")
  )
  
  sign_in <- modalDialog(
    title = "Sign in",
    textInput("email_signin", "Your email"),
    passwordInput("password_signin", "Your password"),
    actionButton("signin", "Sign in")
  )
  
  observeEvent(input$signin_modal, {
    showModal(sign_in)
  })
  
  observeEvent(input$register_modal, {
    showModal(register)
  })
  
  # create the user
  observeEvent(input$create, {
    f$create(input$email_create, input$password_create)
  })
  
  # check if creation successful
  observeEvent(f$get_created(), {
    created <- f$get_created()
    
    if(created$success){
      removeModal()
      showNotification("Account created!", type = "message")
    } else {
      showNotification("Error!", type = "error")
    }
    
    print(created)
  })
  
  observeEvent(input$signin, {
    
    removeModal()
    f$sign_in(input$email_signin, input$password_signin)
    cat(f$get_signed_in())
    
  })
  
  observeEvent(input$signout, {
    removeModal()
    f$sign_out()
  })
  
  output$user_info <- renderPrint({
    f$req_sign_in()
    f$get_signed_in()$response$uid
  })
  
  df <- eventReactive(input$submit_code, {
    code = input$ace
    result = code_exec(code)
  })
  
  output$code_output = renderText({
    df()
  })
  
}