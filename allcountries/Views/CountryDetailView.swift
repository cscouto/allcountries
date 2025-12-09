//
//  CountryDetailView.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import SwiftUI
import MapKit

struct CountryDetailView: View {
    let code: String
    @ObservedObject var viewModel: CountryViewModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    var body: some View {
        ScrollView {
            if let country = viewModel.selectedCountry {
                VStack(spacing: 20) {
                    // Flag Image
                    AsyncImage(url: URL(string: country.flags.png)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 5)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // Country Name
                    Text(country.name.common)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                    
                    // Region & Subregion
                    VStack(spacing: 4) {
                        Text(country.region)
                            .font(.headline)
                            .foregroundColor(.secondary)
                        if let subregion = country.subregion {
                            Text(subregion)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Divider()
                        .padding(.vertical, 10)
                    
                    // Country Info
                    VStack(alignment: .leading, spacing: 10) {
                        InfoRow(title: L10n.capital, value: country.capital?.first ?? L10n.nA)
                        InfoRow(title: L10n.population, value: country.population.formattedWithSeparator())
                        InfoRow(title: L10n.languages, value: country.languages?.values.joined(separator: ", ") ?? L10n.nA)
                        InfoRow(title: L10n.currencies, value: country.currencies?.map { "\($0.value.name) (\($0.value.symbol ?? ""))" }.joined(separator: ", ") ?? L10n.nA)
                        
                        // Map Snippet
                        if let latlng = country.latlng, latlng.count == 2 {
                            Map(coordinateRegion: $region, annotationItems: [PinLocation(coordinate: CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1]))]) { location in
                                MapPin(coordinate: location.coordinate)
                            }
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .onAppear {
                                region.center = CLLocationCoordinate2D(latitude: latlng[0], longitude: latlng[1])
                                region.span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            } else {
                ProgressView(L10n.loading)
                    .task {
                        await fetchCountry()
                    }
            }
        }
        .navigationTitle(viewModel.selectedCountry?.name.common ?? L10n.loading)
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $viewModel.error) { alertError in
            Alert(
                title: Text(L10n.errorTitle),
                message: Text(alertError.message),
                dismissButton: .default(Text(L10n.ok)) { viewModel.error = nil }
            )
        }
        .onDisappear {
            viewModel.selectedCountry = nil
        }
    }
    
    // MARK: - Fetch Country
    private func fetchCountry() async {
        await viewModel.fetchCountry(for: code)
    }
}

// MARK: - Helpers

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title + ":")
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct PinLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? "\(self)"
    }
}
