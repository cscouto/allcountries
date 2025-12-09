//
//  MockCountryService.swift
//  allcountriesTests
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation
@testable import allcountries

final class MockCountryService: CountryServiceProtocol {
    private let shouldFail: Bool
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    var countries: [CountryListItem] = [
        CountryListItem(
            cca2: "US",
            name: Name(common: "United States"),
            region: "Americas",
            flags: Flags(png: "https://flagcdn.com/w320/us.png")
        ),
        CountryListItem(
            cca2: "FR",
            name: Name(common: "France"),
            region: "Europe",
            flags: Flags(png: "https://flagcdn.com/w320/fr.png")
        )
    ]
    
    var countryDetails: [String: CountryDetail] = [
        "US": CountryDetail(
            name: Name(common: "United States"),
            flags: Flags(png: "https://flagcdn.com/w320/us.png"),
            capital: ["Washington D.C."],
            region: "Americas",
            subregion: "Northern America",
            population: 331000000,
            languages: ["eng": "English"],
            currencies: ["USD": CurrencyInfo(name: "United States Dollar", symbol: "$")],
            latlng: [38.0, -97.0],
            cca2: "US"
        ),
        "FR": CountryDetail(
            name: Name(common: "France"),
            flags: Flags(png: "https://flagcdn.com/w320/fr.png"),
            capital: ["Paris"],
            region: "Europe",
            subregion: "Western Europe",
            population: 67000000,
            languages: ["fra": "French"],
            currencies: ["EUR": CurrencyInfo(name: "Euro", symbol: "€")],
            latlng: [46.0, 2.0],
            cca2: "FR"
        )
    ]
    
    func fetchCountries() async -> Result<[CountryListItem], NetworkClient.NetworkError> {
        if shouldFail {
            return .failure(.notFound)
        }
        return .success(countries)
    }
    
    func fetchCountry(for code: String) async -> Result<[CountryDetail], NetworkClient.NetworkError> {
        if shouldFail {
            return .failure(.notFound)
        }
        if let detail = countryDetails[code] {
            return .success([detail])
        } else {
            return .failure(.notFound)
        }
    }
}
