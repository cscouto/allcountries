//
//  CountryListView.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//
import SwiftUI

struct CountryListView: View {
    @StateObject private var vm = CountryViewModel()
    @EnvironmentObject private var navVM: NavigationViewModel
    
    var body: some View {
        NavigationStack(path: $navVM.path) {
            List(vm.filteredCountries) { country in
                Button {
                    navVM.showCountryDetail(countryCode: country.cca2)
                } label: {
                    CountryRowView(country: country)
                }
            }
            .searchable(text: $vm.search)
            .navigationTitle(L10n.countries)
            .task {
                await vm.fetchCountries()
            }
            .alert(item: $vm.error) { alertError in
                Alert(
                    title: Text(L10n.errorTitle),
                    message: Text(alertError.message),
                    dismissButton: .default(Text(L10n.ok)) { vm.error = nil }
                )
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .countryDetail(let code):
                    CountryDetailView(code: code)
                }
            }
        }
    }
}
