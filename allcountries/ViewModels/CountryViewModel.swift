//
//  CountryListViewModel.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

@MainActor
final class CountryViewModel: ObservableObject {
    @Published var countries: [CountryListItem] = []
    @Published var search: String = ""
    @Published var isLoading = false
    @Published var error: AlertError?
    @Published var selectedCountry: CountryDetail?
    
    private let service: CountryServiceProtocol
    
    init(service: CountryServiceProtocol = CountryService()) {
        self.service = service
    }
    
    var filteredCountries: [CountryListItem] {
        if search.isEmpty { return countries }
        return countries.filter { $0.name.common.localizedCaseInsensitiveContains(search) }
    }
    
    // MARK: - Fetch Countries
    func fetchCountries() async {
        isLoading = true
        defer { isLoading = false }
        
        let result = await service.fetchCountries()
        switch result {
        case .success(let response):
            countries = response.sorted(by: { $0.name.common < $1.name.common })
        case .failure(let networkError):
            handleError(networkError)
        }
    }
    
    // MARK: - Fetch Single Country
    func fetchCountry(for code: String) async {
        isLoading = true
        defer { isLoading = false }
        
        let result = await service.fetchCountry(for: code)
        switch result {
        case .success(let response):
            selectedCountry = response.first
        case .failure(let networkError):
            handleError(networkError)
        }
    }
    
    // MARK: - Error Handling
    private func handleError(_ error: NetworkClient.NetworkError) {
        self.error = AlertError(message: error.localizedDescription)
        print("❌ Network Error:", error.localizedDescription)
    }
}

struct AlertError: Identifiable {
    let id = UUID()
    let message: String
}
