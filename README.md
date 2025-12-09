# AllCountries

A SwiftUI app that displays information about countries worldwide, including flags, population, languages, currencies, and a map snippet for each country.  

Built with modern SwiftUI. 

## Features

- Browse a list of countries with search functionality  
- View country details including:  
  - Flag  
  - Name, region, subregion  
  - Capital, population, languages, currencies  
  - Map snippet with pinned location  
- Localizable strings for easy translation  
- Offline-friendly structure (can be extended for caching)  

## Installation

1. Clone the repo:

```bash
git clone https://github.com/yourusername/AllCountries.git
cd AllCountries
```
Open the project in Xcode:

```bash
open AllCountries.xcodeproj
```
Run on simulator or device (iOS 16+ recommended).

## Usage
Search countries using the top search bar

Tap a country to view detailed information

View flag, capital, population, languages, currencies, and map location

## Localization
All strings are localized using L10n.swift. To add a new language:

Add a .strings file for the language in Resources/Localization

Add translations for each key

Example keys in L10n.strings:
```bash
"countries" = "Countries";
"loading" = "Loading...";
"capital" = "Capital";
"population" = "Population";
"languages" = "Languages";
"currencies" = "Currencies";
"nA" = "N/A";
"errorTitle" = "Error";
"ok" = "OK";
```

## Testing
Run the unit tests to verify functionality:

CountryViewModelTests – tests fetching countries, search filter, error handling

NetworkClientTests – tests network error handling

Run all tests in Xcode using Cmd+U.

## Folder Structure
```
AllCountries/
├─ Models/
├─ Services/
├─ ViewModels/
├─ Views/
├─ Navigation/
├─ allcountriesTests/
└─ allcountriesUITests/
```

## Dependencies
SwiftUI (iOS 16+)

MapKit

URLSession (async/await)

No third-party dependencies.

## License
MIT License © 2025 Tiago Do Couto







