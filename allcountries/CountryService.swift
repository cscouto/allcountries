//
//  CountryAPI.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

protocol CountryAPIProtocol {
    func fetchCountries() async throws -> [CountryListItem]
    func loadCountryDetail(for cca3: String) async throws -> CountryDetail?
}

final class CountryAPI: CountryAPIProtocol {
    private let session: URLSession = .shared
    
    func fetchCountries() async throws -> [CountryListItem] {
        let url = URL(string:
            "https://restcountries.com/v3.1/all?fields=name,flags,capital,region,subregion,population,languages,currencies,latlng,cca3"
        )!
        
        let (data, _) = try await session.data(from: url)
        return try JSONDecoder().decode([CountryListItem].self, from: data)
    }
    
    func loadCountryDetail(for cca3: String) async throws -> CountryDetail? {
        let urlString = "https://restcountries.com/v3.1/alpha/\(cca3)"
        guard let url = URL(string: urlString) else { return nil }
        let request = URLRequest(url: url)
        
        let (data, _) = try await session.data(from: url)
        let countries = try? JSONDecoder().decode([CountryDetail].self, from: data)
        return countries?.first
    }
}
