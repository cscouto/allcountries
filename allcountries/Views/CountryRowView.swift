//
//  CountryRowView.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import SwiftUI

struct CountryRowView: View {
    let country: CountryListItem
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: country.flags.png)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 30)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
            VStack(alignment: .leading) {
                Text(country.name.common)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(country.region)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
