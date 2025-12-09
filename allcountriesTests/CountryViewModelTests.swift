//
//  CountryViewModelTests.swift
//  allcountriesTests
//
//  Created by Tiago Do Couto on 12/9/25.
//

import XCTest
@testable import allcountries

@MainActor
final class CountryViewModelTests: XCTestCase {
    
    func testFetchCountriesSuccess() async {
        let vm = CountryViewModel(service: MockCountryService())
        
        await vm.fetchCountries()
        
        XCTAssertFalse(vm.countries.isEmpty)
        XCTAssertNil(vm.error)
    }
    
    func testFetchCountrySuccess() async {
        let vm = CountryViewModel(service: MockCountryService())
        
        await vm.fetchCountry(for: "US") // match key in MockCountryService
        
        XCTAssertEqual(vm.selectedCountry?.cca2, "US")
        XCTAssertNil(vm.error)
    }
    
    func testFetchCountriesFailure() async {
        let vm = CountryViewModel(service: MockCountryService(shouldFail: true))
        
        await vm.fetchCountries()
        
        XCTAssertTrue(vm.countries.isEmpty)
        XCTAssertNotNil(vm.error)
        XCTAssertEqual(vm.error?.message, NetworkClient.NetworkError.notFound.localizedDescription)
    }
    
    func testSearchFilter() {
        let vm = CountryViewModel(service: MockCountryService())
        vm.countries = [
            CountryListItem(cca2: "BR", name: Name(common: "Brazil"), region: "Americas", flags: Flags(png: "")),
            CountryListItem(cca2: "JP", name: Name(common: "Japan"), region: "Asia", flags: Flags(png: ""))
        ]
        
        vm.search = "bra"
        XCTAssertEqual(vm.filteredCountries.count, 1)
        XCTAssertEqual(vm.filteredCountries.first?.name.common, "Brazil")
    }
}
