//
//  CountryListViewModel.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

@MainActor
final class CountryListViewModel: ObservableObject {
    @Published var countries: [CountryListItem] = []
    @Published var search: String = ""
    @Published var isLoading = false
    @Published var error: String?
    
    private let api: CountryAPIProtocol
    
    init(api: CountryAPIProtocol = CountryAPI()) {
        self.api = api
    }
    
    var filteredCountries: [CountryListItem] {
        if search.isEmpty { return countries }
        return countries.filter { $0.name.common.localizedCaseInsensitiveContains(search) }
    }
    
    func loadCountries() async {
        isLoading = true
        
        do {
            countries = try await api.fetchCountries()
        } catch {
            self.error = "Failed to fetch countries."
        }
            
        isLoading = false
    }
    
    func loadCountry(for code: String) async -> CountryDetail? {
        return try? await api.loadCountryDetail(for: code)
    }
}
