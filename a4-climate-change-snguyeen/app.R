#Scarlett Nguyen
library("shiny")
source("app_ui.R")
source("app_server.R")
library("rsconnect")

#rsconnect::setAccountInfo(name='snguyeen', token='092BDA19DE263B6BEC95469DD483EACE', 
 #                         secret='RKiizBTGLEPWyxfCGSxe72vpZzy9ajldc8FyWekd')

shinyApp(ui = ui, server = server)
