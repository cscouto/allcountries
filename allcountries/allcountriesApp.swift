//
//  allcountriesApp.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import SwiftUI
import SwiftData

@main
struct allcountriesApp: App {
    @StateObject private var navVM = NavigationViewModel()

    var body: some Scene {
        WindowGroup {
            CountryListView()
                .environmentObject(navVM)
        }
    }
}
