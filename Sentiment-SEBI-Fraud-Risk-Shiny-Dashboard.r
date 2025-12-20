############################################################
# SHINY DASHBOARD: SENTIMENT & SEBI FRAUD RISK ANALYSIS
# Author: Parmesh Kumar
############################################################
library(tm)
library(stringr)
library(DT)
library(sentimentr)
library(shiny)

# ---------------- UI ----------------
ui <- fluidPage(
  
  titlePanel("Sentiment Analysis & SEBI Fraud Risk Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput(
        "file",
        "Upload Input Text File (.txt)",
        accept = ".txt"
      ),
      helpText("File must contain either plain text (sentiment analysis)
               or [SPEECH] and [REPORT] sections (fraud analysis).")
    ),
    
    mainPanel(
      tabsetPanel(
        
        # -------- Sentiment Tab --------
        tabPanel(
          "Sentiment Analysis",
          h4("Complete Input Text"),
          verbatimTextOutput("full_text"),
          
          br(),
          h4("Overall Sentiment Result"),
          tableOutput("sentiment_summary")
        ),
        
        # -------- Fraud Risk Tab --------
        tabPanel(
          "SEBI / SEC Fraud Risk Analysis",
          h4("Director's Speech"),
          verbatimTextOutput("speech_text"),
          
          h4("Company Final Report"),
          verbatimTextOutput("report_text"),
          
          br(),
          h4("Fraud Risk Dashboard"),
          tableOutput("fraud_dashboard")
        )
      )
    )
  )
)

# ---------------- SERVER ----------------
server <- function(input, output) {
  
  text_vector <- reactive({
    req(input$file)
    readLines(input$file$datapath, encoding = "UTF-8") |>
      trimws() |>
      (\(x) x[nchar(x) > 0])()
  })
  
  # -------- SENTIMENT ANALYSIS --------
  sentiment_result <- reactive({
    
    text <- text_vector()
    full_text <- paste(text, collapse = " ")
    
    sent <- sentiment_by(text)
    avg_sent <- mean(sent$ave_sentiment)
    
    avg_pct <- round((avg_sent + 1) / 2 * 100, 2)
    
    label <- cut(
      avg_pct,
      breaks = c(-Inf, 20, 45, 55, 80, Inf),
      labels = c(
        "Extremely Negative",
        "Negative",
        "Neutral",
        "Positive",
        "Extremely Positive"
      )
    )
    
    list(
      full_text = full_text,
      avg_sent = round(avg_sent, 3),
      avg_pct = avg_pct,
      label = label
    )
  })
  
  output$full_text <- renderText({
    sentiment_result()$full_text
  })
  
  output$sentiment_summary <- renderTable({
    data.frame(
      Average_Sentiment_Score = sentiment_result()$avg_sent,
      Sentiment_Percentage = sentiment_result()$avg_pct,
      Overall_Sentiment = sentiment_result()$label
    )
  })
  
  # -------- FRAUD RISK ANALYSIS --------
  fraud_result <- reactive({
    
    text <- text_vector()
    
    speech_start <- grep("^\\s*\\[SPEECH\\]\\s*$", text, ignore.case = TRUE)
    report_start <- grep("^\\s*\\[REPORT\\]\\s*$", text, ignore.case = TRUE)
    
    if (length(speech_start) == 0 || length(report_start) == 0) {
      return(NULL)
    }
    
    speech <- text[(speech_start + 1):(report_start - 1)]
    report <- text[(report_start + 1):length(text)]
    
    speech <- speech[nchar(speech) > 0]
    report <- report[nchar(report) > 0]
    
    speech_score <- mean(sentiment_by(speech)$ave_sentiment)
    report_score <- mean(sentiment_by(report)$ave_sentiment)
    
    divergence <- abs(speech_score - report_score)
    
    deception_words <- c(
      "temporary","timing","adjusted","reclassified",
      "believe","confident","expect","one-time",
      "noise","unprecedented"
    )
    
    count_markers <- function(txt, markers) {
      sum(sapply(markers, function(m)
        str_count(tolower(paste(txt, collapse=" ")), m)))
    }
    
    total_words <- length(strsplit(paste(text, collapse=" "), "\\s+")[[1]])
    deception_density <- count_markers(text, deception_words) / total_words * 1000
    
    risk_score <- min(
      round(
        min(divergence * 100, 30) +
          min(deception_density * 2, 30) +
          ifelse((speech_score - report_score) > 0.2, 20, 0),
        1
      ),
      100
    )
    
    risk_level <- cut(
      risk_score,
      breaks = c(-Inf, 20, 45, 55, 80, 100),
      labels = c("LOW RISK", "RISK", "MODERATE RISK", "HIGH RISK", "SUPER RISK")
    )
    
    list(
      speech = paste(speech, collapse = " "),
      report = paste(report, collapse = " "),
      dashboard = data.frame(
        Avg_Speech_Sentiment = round(speech_score, 3),
        Avg_Report_Sentiment = round(report_score, 3),
        Sentiment_Divergence = round(divergence, 3),
        Deception_Density_per_1000_Words = round(deception_density, 2),
        Fraud_Risk_Score = risk_score,
        Fraud_Risk_Level = risk_level
      )
    )
  })
  
  output$speech_text <- renderText({
    req(fraud_result())
    fraud_result()$speech
  })
  
  output$report_text <- renderText({
    req(fraud_result())
    fraud_result()$report
  })
  
  output$fraud_dashboard <- renderTable({
    req(fraud_result())
    fraud_result()$dashboard
  })
}

# ---------------- RUN APP ----------------
shinyApp(ui = ui, server = server)

