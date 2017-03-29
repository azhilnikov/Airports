//
//  AirportDataStructure.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Foundation

struct AirportsDataKey {
    static let airports = "airports"
    static let airportCode = "code"
    static let airportName = "display_name"
    static let internationalAirport = "international_airport"
    static let regionalAirport = "regional_airport"
    static let currencyCode = "currency_code"
    static let country = "country"
    static let countryCode = "code"
    static let countryName = "display_name"
    static let location = "location"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let timezone = "timezone"
}

enum AirportsAPIResult {
    case success
    case failure(Error)
}

enum AirportsAPIError: Error {
    case noInternetConnection
    case invalidURL
    case invalidResponse
    case invalidStatusCode
    case invalidData
    case invalidJSONFormat
}

extension AirportsAPIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("No Internet connection", comment: "")
            
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
            
        case .invalidResponse:
            return NSLocalizedString("Invalid Response", comment: "")
            
        case .invalidStatusCode:
            return NSLocalizedString("Invalid status code", comment: "")
            
        case .invalidData:
            return NSLocalizedString("Invalid data", comment: "")
            
        case .invalidJSONFormat:
            return NSLocalizedString("Invalid JSON format", comment: "")
        }
    }
}
