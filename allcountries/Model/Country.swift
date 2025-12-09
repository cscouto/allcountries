//
//  Country.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

struct CountryListItem: Identifiable, Decodable, Hashable {
    var id: String { cca2 }
    let cca2: String
    let name: Name
    let region: String
    let flags: Flags
}

struct CountryDetail: Identifiable, Decodable {
    var id: String { cca2 }
    let name: Name
    let flags: Flags
    let capital: [String]?
    let region: String
    let subregion: String?
    let population: Int
    let languages: [String: String]?
    let currencies: [String: CurrencyInfo]?
    let latlng: [Double]?
    let cca2: String
}

struct Name: Decodable, Hashable, Equatable  {
    let common: String
}

struct Flags: Decodable, Hashable, Equatable  {
    let png: String
}

struct CurrencyInfo: Decodable {
    let name: String
    let symbol: String?
}
