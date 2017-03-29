//
//  Location.swift
//  Airports
//
//  Created by Zhilnikov, Alexey on 30/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import Gloss

class Location: NSObject, Decodable, NSCoding {
    
    let latitude: Double?
    let longitude: Double?
    
    // MARK: - Decodable
    
    required init?(json: JSON) {
        latitude = AirportsDataKey.latitude <~~ json
        longitude = AirportsDataKey.longitude <~~ json
    }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        latitude = aDecoder.decodeObject(forKey: AirportsDataKey.latitude) as? Double
        longitude = aDecoder.decodeObject(forKey: AirportsDataKey.longitude) as? Double
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: AirportsDataKey.latitude)
        aCoder.encode(longitude, forKey: AirportsDataKey.longitude)
    }
}
