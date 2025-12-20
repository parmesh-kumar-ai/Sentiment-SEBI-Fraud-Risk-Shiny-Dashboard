# Sentiment-SEBI-Fraud-Risk-Shiny-Dashboard
R Shiny dashboard for sentiment analysis and SEBI-style fraud risk screening
# Sentiment & SEBI Fraud Risk Analysis – Shiny Dashboard

This repository contains an **R Shiny dashboard** developed by **Parmesh Kumar**
for performing:

- Sentiment Analysis
- SEBI / SEC-style Fraud Risk Screening using NLP

The project is intended for **research, governance analysis, compliance screening,
and academic demonstration purposes**.

---

## 🔍 Features

### 1. Sentiment Analysis
- Upload `.txt` files
- Displays complete input text
- Calculates:
  - Average sentiment score
  - Sentiment percentage
  - Overall sentiment category

### 2. SEBI / SEC Fraud Risk Analysis
- Compares:
  - Director / CEO speech
  - Company final reports
- Measures:
  - Sentiment divergence
  - Linguistic deception markers
  - Optimism bias
- Generates a **Fraud Risk Score (0–100)**

---

## 📁 Input File Format
The  input text file must be in this format:
[SPEECH]
Director or CEO speech text here.

[REPORT]
Company annual or final report text here.

### Sentiment Analysis Only
```text
The service quality was acceptable.
However, delays caused some frustration.




