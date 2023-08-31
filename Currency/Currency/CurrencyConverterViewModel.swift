/// CurrencyConverterViewModel
/// Responsible for managing the logic for currency conversion including fetching rates and updating UI.
///
/// - Version: 1.0
/// - Author: Kyle Zeller
/// - Date: 08/30/2023
///
import Foundation

class CurrencyConverterViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Stores the conversion rates for various currencies.
    @Published var rates = [String: Double]()
    
    /// Indicates whether there is an error in fetching data.
    @Published var isError = false
    
    /// Stores the error message in case fetching fails.
    @Published var errorMessage = ""
    
    // MARK: - Methods
    
    /// Fetches the currency rates and updates the published `rates` property.
    ///
    /// This function fetches the currency rates asynchronously and uses `MainActor` to update the UI.
    func fetchRates() {
        Task {
            do {
                // Attempt to fetch currency rates data
                let currencyRate = try await self.fetchRatesData()
                
                // Update the rates dictionary on the main thread
                await self.updateRatesOnMainThread(newRates: currencyRate.rates)
            } catch {
                // Update error state on the main thread
                await self.updateErrorOnMainThread(isError: true, errorMessage: "Failed to fetch rates: \(error)")
            }
        }
    }
    
    /// Update the `rates` property on the main thread.
    ///
    /// - Parameter newRates: The new set of currency conversion rates.
    ///
    /// This function is marked with `@MainActor` to ensure that it runs on the main thread.
    @MainActor
    private func updateRatesOnMainThread(newRates: [String: Double]) {
        self.rates = newRates
    }

    /// Update the `isError` and `errorMessage` properties on the main thread.
    ///
    /// - Parameters:
    ///   - isError: Whether an error has occurred.
    ///   - errorMessage: The message detailing the error.
    ///
    /// This function is marked with `@MainActor` to ensure that it runs on the main thread.
    @MainActor
    private func updateErrorOnMainThread(isError: Bool, errorMessage: String) {
        self.isError = isError
        self.errorMessage = errorMessage
    }
    
    // MARK: - Helper Methods
    
    /// Fetches the currency rate data from the API.
    ///
    /// - Returns: A `CurrencyRate` object containing the latest currency rates.
    /// - Throws: An `NSError` if the URL is invalid or other network errors occur.
    ///
    /// This function sends an HTTP request to fetch the latest currency rates and decodes the JSON response.
    private func fetchRatesData() async throws -> CurrencyRate {
        let apiKey = "207342f9173a16c9f5d69ba5" // Replace with your actual API key
        let urlStr = "https://api.exchangerate-api.com/v4/latest/USD"

        // Validate the URL
        guard let url = URL(string: urlStr) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }

        // Setup the URLRequest with the API key header
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "api-key")

        // Perform the asynchronous URL data task
        let (data, _) = try await URLSession.shared.data(for: request)

        // Decode the JSON into a CurrencyRate object
        let decoder = JSONDecoder()
        let currencyRate = try decoder.decode(CurrencyRate.self, from: data)

        return currencyRate
    }
}
