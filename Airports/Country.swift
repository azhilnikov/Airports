//
//  Country.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Gloss

class Country: NSObject, Decodable, NSCoding {
    
    let code: String?
    let displayName: String?
    
    // MARK: - Decodable
    
    required init?(json: JSON) {
        code = AirportsDataKey.countryCode <~~ json
        displayName = AirportsDataKey.countryName <~~ json
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        code = aDecoder.decodeObject(forKey: AirportsDataKey.countryCode) as? String
        displayName = aDecoder.decodeObject(forKey: AirportsDataKey.countryName) as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(code, forKey: AirportsDataKey.countryCode)
        aCoder.encode(displayName, forKey: AirportsDataKey.countryName)
    }
}
