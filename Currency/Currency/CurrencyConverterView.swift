//  ContentView.swift
//  Currency
//
//  Created by Kyle Zeller on 8/30/23.
//
// API Key: 207342f9173a16c9f5d69ba5
//
// This file contains the main UI for the Currency Converter app.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State Variables
    
    /// The amount of money in the source currency.
    @State private var sourceAmount = ""
    
    /// The amount of money in the destination currency.
    @State private var destinationAmount = ""
    
    /// The index of the selected source currency in the `currencies` array.
    @State private var selectedSourceCurrency = 0
    
    /// The index of the selected destination currency in the `currencies` array.
    @State private var selectedDestinationCurrency = 1
    
    // MARK: - Constants
    
    /// An array of currency codes that the app supports.
    let currencies = ["USD", "EUR", "JPY", "GBP"]
    
    // MARK: - ViewModel
    
    /// The ViewModel that provides functionality for fetching and converting currencies.
    @StateObject var viewModel = CurrencyConverterViewModel()
    
    // MARK: - UI Body
    
    var body: some View {
        VStack {
            // Handling errors from ViewModel
            if viewModel.isError {
                Text("Error: \(viewModel.errorMessage)")
            } else {
                // Main UI
                NavigationView {
                    VStack(spacing: 20) {
                        // UI for Source Amount and Currency
                        createCurrencyTextField(title: "Source Amount", text: $sourceAmount, selectedCurrency: $selectedSourceCurrency)
                        
                        // UI for Destination Amount and Currency
                        createCurrencyTextField(title: "Destination Amount", text: $destinationAmount, selectedCurrency: $selectedDestinationCurrency)
                        
                        // Convert Button
                        Button("Convert") {
                            convertCurrency()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                    .navigationTitle("Currency Converter")
                }
            }
        }
        // Fetch the rates when the view appears
        .onAppear {
            viewModel.fetchRates()
        }
    }
    
    // MARK: - Helper Functions
    
    /// Creates a TextField and Picker for currency input.
    ///
    /// - Parameters:
    ///   - title: The placeholder text for the TextField.
    ///   - text: A binding to the text property for the TextField.
    ///   - selectedCurrency: A binding to the selected currency index.
    /// - Returns: some View
    private func createCurrencyTextField(title: String, text: Binding<String>, selectedCurrency: Binding<Int>) -> some View {
        VStack {
            TextField(title, text: text)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker(title, selection: selectedCurrency) {
                ForEach(0 ..< currencies.count) {
                    Text(self.currencies[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    /// Converts the source amount to the destination amount using the rates from the ViewModel.
    private func convertCurrency() {
        let sourceCurrency = currencies[selectedSourceCurrency]
        let destinationCurrency = currencies[selectedDestinationCurrency]

        if let sourceRate = viewModel.rates[sourceCurrency],
           let destinationRate = viewModel.rates[destinationCurrency],
           let amount = Double(sourceAmount) {

            let convertedAmount = amount / sourceRate * destinationRate
            destinationAmount = String(format: "%.2f", convertedAmount)
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
