//
//  Airports.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Gloss

class Airports: NSObject, Decodable, NSCoding {
    
    let airports: [Airport]?
    
    // MARK: - Decodable
    
    required init?(json: JSON) {
        airports = AirportsDataKey.airports <~~ json
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        airports = aDecoder.decodeObject(forKey: AirportsDataKey.airports) as? [Airport]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(airports, forKey: AirportsDataKey.airports)
    }
}
