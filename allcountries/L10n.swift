//
//  LocalizationHelper.swift
//  allcountries
//
//  Created by Tiago Do Couto on 12/9/25.
//

import Foundation

enum L10n {
    // General
    static let ok = NSLocalizedString("ok", comment: "OK button title")
    static let errorTitle = NSLocalizedString("error_title", comment: "Error alert title")
    static let loading = NSLocalizedString("loading", comment: "Loading text")
    static let nA = NSLocalizedString("nA", comment: "Not available")
    
    // Country List
    static let countries = NSLocalizedString("countries", comment: "Countries view title")
    
    // Country Detail
    static let capital = NSLocalizedString("capital", comment: "Capital row title")
    static let population = NSLocalizedString("population", comment: "Population row title")
    static let languages = NSLocalizedString("languages", comment: "Languages row title")
    static let currencies = NSLocalizedString("currencies", comment: "Currencies row title")
    
    // Network errors
    static var urlError: String { NSLocalizedString("url_error", comment: "URL session/network error") }
    static var decodingError: String { NSLocalizedString("decoding_error", comment: "Decoding JSON error") }
    static var invalidResponse: String { NSLocalizedString("invalid_response", comment: "Server returned invalid response") }
    static var badRequest: String { NSLocalizedString("bad_request", comment: "HTTP 400") }
    static var unauthorized: String { NSLocalizedString("unauthorized", comment: "HTTP 401") }
    static var forbidden: String { NSLocalizedString("forbidden", comment: "HTTP 403") }
    static var notFound: String { NSLocalizedString("not_found", comment: "HTTP 404") }
    static var tooManyRequests: String { NSLocalizedString("too_many_requests", comment: "HTTP 429") }
    static var serverError: String { NSLocalizedString("server_error", comment: "HTTP 5xx") }
    static var unexpectedStatus: String { NSLocalizedString("unexpected_status", comment: "Unexpected HTTP status code") }
    static var unknownError: String { NSLocalizedString("unknown_error", comment: "Any unknown error") }
}
