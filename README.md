
# Currency Converter App

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Getting Started](#getting-started)
- [Usage](#usage)

## Overview

Currency Converter is a simple yet powerful application that converts currency in real-time. The app is built using SwiftUI for the UI and Swift's new concurrency model for network calls. Whether you need to convert USD to EUR or GBP to JPY, this app has got you covered.

## Features

- Real-time currency conversion
- Support for multiple currencies (USD, EUR, JPY, GBP, etc.)
- User-friendly interface with SwiftUI
- Robust ViewModel architecture
- Error-handling for API failures
- Thorough documentation for easy code maintainability

## Technologies Used

- SwiftUI for UI
- Swift 5.5's new concurrency model (`async/await`)
- URLSession for API requests
- JSONDecoder for JSON parsing

## Getting Started

### Prerequisites

- Xcode 13 or later
- Swift 5.5 or later
- iOS 15 or later

### Installation

1. Clone this repository: `git clone https://github.com/KyleZeller02/CurrencyConverter.git`
2. Navigate into the project directory: `cd CurrencyConverter`
3. Open the project in Xcode: `open CurrencyConverter.xcodeproj`
4. Build and run the app on your iOS simulator or real device.

## Usage

1. Launch the app.
2. Enter the amount you want to convert in the 'Source Amount' TextField.
3. Select the source currency using the 'Source Currency' Picker.
4. Select the destination currency using the 'Destination Currency' Picker.
5. Press the 'Convert' button to perform the conversion.
