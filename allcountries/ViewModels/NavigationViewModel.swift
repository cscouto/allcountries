//
//  NavigationViewModel.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import SwiftUI

class NavigationViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    func showCountryDetail(countryCode: String) {
        path.append(Route.countryDetail(countryCode))
    }
}
