//
//  CountryService.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation
protocol CountryServiceProtocol {
    func fetchCountries() async -> Result<[CountryListItem], NetworkClient.NetworkError>
    func fetchCountry(for code: String) async -> Result<[CountryDetail], NetworkClient.NetworkError>
}


final class CountryService: CountryServiceProtocol {
    private let client = NetworkClient()
    private let baseUrlString = "https://restcountries.com/v3.1/"
    private let defaultFields = ["name", "region", "flags", "cca2"]
    
    private func makeURL(path: String, queryItems: [URLQueryItem]? = nil) -> URL? {
        guard let baseUrl = URL(string: baseUrlString),
              var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = queryItems
        return components.url
    }
    
    func fetchCountries() async -> Result<[CountryListItem], NetworkClient.NetworkError> {
        guard let url = makeURL(
            path: "all",
            queryItems: [URLQueryItem(name: "fields", value: defaultFields.joined(separator: ","))]
        ) else {
            return .failure(.invalidResponse)
        }
        
        let request = URLRequest(url: url)
        return await client.request(request, type: [CountryListItem].self)
    }
    
    func fetchCountry(for code: String) async -> Result<[CountryDetail], NetworkClient.NetworkError> {
        guard let url = makeURL(path: "alpha/\(code)") else {
            return .failure(.invalidResponse)
        }
        
        let request = URLRequest(url: url)
        return await client.request(request, type: [CountryDetail].self)
    }
}
