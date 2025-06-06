
# 💸 Price Spier – Smart Price Tracking App

**Price Spier** is a price-tracking application built with **Flutter** and powered by a **Node.js backend** that helps users monitor product prices on **Amazon**. Users can track items, set target prices, and receive real-time **email alerts** when prices drop — ensuring they never miss a great deal again.

---

## 📌 Project Overview

With online prices constantly fluctuating, manually tracking them can be tedious. Price Spier automates this process by combining a beautiful Flutter interface with powerful backend automation. It uses **web scraping APIs (Puppeteer, Cheerio)** to fetch live price data and **sends alerts via Nodemailer** whenever a product price meets the user’s set threshold.

---

## ✅ Features

✔️ **Track Product Prices on Amazon**
✔️ **Set Target Prices & Monitor Changes**
✔️ **Receive Email Alerts for Price Drops**
✔️ **Automated Price Monitoring using Cron Jobs**
✔️ **Real-time Scraping using Puppeteer + Cheerio**
✔️ **Clean & Intuitive UI built with Flutter**

---

## 📱 App Flow

1. 🛒 **Add a Product**: Users paste an Amazon product link into the app.
2. 🎯 **Set a Target Price**: Enter the desired price you want to pay.
3. 🔍 **Automated Tracking**: Backend regularly checks the product price.
4. ✉️ **Get Notified**: When the price drops below your target, an email is sent.

---

## 🧪 Tech Stack

### Frontend (Flutter)

* Flutter (Dart)
* Provider / Riverpod (State Management)
* HTTP (for API integration)

### Backend (Node.js)

* **Express.js** – REST API
* **Puppeteer + Cheerio** – Web scraping Amazon product pages
* **Nodemailer** – Send price drop alerts via email
* **CronJob** – Schedule periodic price checks
* **MongoDB** – Store product data and user preferences

---

## 🚀 Getting Started

### 📱 For Flutter App:

```bash
git clone https://github.com/vivekbargude/PriceSpier-Price-Tracking-App.git
cd FRONTEND\pricespyer
flutter pub get
flutter run
```

### 🌐 For Backend:

```bash
cd BACKEND\
npm install
npm run dev
```

> ⚙️ Ensure MongoDB URI, email credentials, and product tracking frequency are set in your `.env` file.

---

## ✉️ Example Use Case

* You want to buy a smartwatch, but only when it drops below ₹5,000.
* Paste the Amazon link, set ₹5,000 as your target.
* Price Spier will scrape the price daily and notify you by email when it drops below that value.

---

## 📬 Contributing

We’d love your contributions to improve product support (Flipkart, Walmart, etc.), notification systems (push/WhatsApp), and UI enhancements.

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a pull request 🎉

---

## 👨‍💻 Developed By

Vivek Bargude
Crafted as a smart solution to automate deal hunting and save money using automation and Flutter.

