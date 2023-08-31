//
//  CurrencyRateModel.swift
//  Currency
//
//  Created by Kyle Zeller on 8/30/23.
//

import Foundation

/// `CurrencyRate` Struct
///
/// A Codable struct that represents currency rates received from the API.
/// It adheres to the `Codable` protocol to allow easy decoding from JSON.
///
/// - Version: 1.0
/// - Author: Kyle Zeller
/// - Date: 08/30/2023
///
struct CurrencyRate: Codable {
    
    /// A dictionary containing currency abbreviations as keys and their corresponding rates as values.
    ///
    /// For example, ["USD": 1.0, "EUR": 0.85] signifies 1 USD is equivalent to 0.85 EUR.
    let rates: [String: Double]
}
