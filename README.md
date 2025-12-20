# Sentiment-SEBI-Fraud-Risk-Shiny-Dashboard
R Shiny dashboard for sentiment analysis and SEBI-style fraud risk screening
# Sentiment & SEBI Fraud Risk Analysis – Shiny Dashboard

An **interactive R Shiny dashboard** for **Sentiment Analysis** and **SEBI / SEC-style Fraud Risk Screening** using Natural Language Processing (NLP).

Developed by **Parmesh Kumar**, this project demonstrates how textual narratives such as **director speeches** and **company reports** can be analyzed to identify **sentiment patterns, narrative inconsistencies, and potential governance risk signals**.

---

## 🚀 Live Dashboard Preview

👉 **Access the live Shiny app here:**  
🔗 https://parmeshkumar.shinyapps.io/sentiment-sebi-fraud-dashboard/

---

## 📊 Dashboard Preview

### Sentiment Analysis and SEBI / SEC Fraud Risk Analysis Module
![Sentiment Analysis Preview](Sentiment Analysis and SEBI Fraud Dashboard.png)

---

## 🔍 Key Features

### 1️⃣ Sentiment Analysis
- Upload `.txt` files
- Displays the **complete input text**
- Calculates:
  - Average sentiment score
  - Sentiment percentage (0–100%)
  - Overall sentiment category:
    - Extremely Negative
    - Negative
    - Neutral
    - Positive
    - Extremely Positive

---

### 2️⃣ SEBI / SEC-Style Fraud Risk Analysis
- Analyzes **narrative divergence** between:
  - Director / CEO speech
  - Company final or annual report
- Detects:
  - Sentiment divergence
  - Linguistic deception markers
  - Optimism bias
- Generates a **Fraud Risk Score (0–100)** with categories:
  - LOW RISK
  - RISK
  - MODERATE RISK
  - HIGH RISK
  - SUPER RISK

> ⚠️ This is a **risk-screening model**, not a fraud-detection or legal judgment system.

---

## 📁 Input File Format

### ✅ Sentiment Analysis Only
- The overall experience was satisfactory.
- However, delays caused frustration.
- The staff remained professional and helpful.

### ✅ SEBI Fraud Risk Analysis
- To perform SEBI Fraud Risk Analysis:
  -the text file must contain :
  -[SPEECH]
  -Director or CEO speech text.

  -[REPORT]
  -Company annual or final report text.

---

## ▶️ How to Run
1. Visit the link:
https://parmeshkumar.shinyapps.io/sentiment-sebi-fraud-dashboard
---
2. To run locally:
   -install.packages(c("shiny", "tm", "sentimentr", "stringr", "DT"))
   -setwd("path/to/Sentiment-SEBI-Fraud-Risk-Shiny-Dashboard"
   -shiny::runApp()

## 👤 About Author

This project is created and maintained by **Parmesh Kumar**.

📄 Read more about the author here:  
👉 [Author.md](Author.md)




