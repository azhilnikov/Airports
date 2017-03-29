//
//  Airport.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Gloss

class Airport: NSObject, Decodable, NSCoding {
    
    let code: String?
    let displayName: String?
    let isInternational: Bool?
    let isRegional: Bool?
    let location: Location?
    let currencyCode: String?
    let timezone: String?
    let country: Country?
    
    // MARK: - Decodable
    
    required init?(json: JSON) {
        code = AirportsDataKey.airportCode <~~ json
        displayName = AirportsDataKey.airportName <~~ json
        isInternational = AirportsDataKey.internationalAirport <~~ json
        isRegional = AirportsDataKey.regionalAirport <~~ json
        location = AirportsDataKey.location <~~ json
        currencyCode = AirportsDataKey.currencyCode <~~ json
        timezone = AirportsDataKey.timezone <~~ json
        country = AirportsDataKey.country <~~ json
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObject(forKey: AirportsDataKey.airportCode) as? String
        displayName = aDecoder.decodeObject(forKey: AirportsDataKey.airportName) as? String
        isInternational = aDecoder.decodeObject(forKey: AirportsDataKey.internationalAirport) as? Bool
        isRegional = aDecoder.decodeObject(forKey: AirportsDataKey.regionalAirport) as? Bool
        location = aDecoder.decodeObject(forKey: AirportsDataKey.location) as? Location
        currencyCode = aDecoder.decodeObject(forKey: AirportsDataKey.currencyCode) as? String
        timezone = aDecoder.decodeObject(forKey: AirportsDataKey.timezone) as? String
        country = aDecoder.decodeObject(forKey: AirportsDataKey.country) as? Country
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: AirportsDataKey.airportCode)
        aCoder.encode(displayName, forKey: AirportsDataKey.airportName)
        aCoder.encode(isInternational, forKey: AirportsDataKey.internationalAirport)
        aCoder.encode(isRegional, forKey: AirportsDataKey.regionalAirport)
        aCoder.encode(location, forKey: AirportsDataKey.location)
        aCoder.encode(currencyCode, forKey: AirportsDataKey.currencyCode)
        aCoder.encode(timezone, forKey: AirportsDataKey.timezone)
        aCoder.encode(country, forKey: AirportsDataKey.country)
    }
}
