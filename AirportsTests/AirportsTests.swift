//
//  AirportsTests.swift
//  AirportsTests
//
//  Created by Zhilnikov, Alexey on 29/3/17.
//  Copyright © 2017 Zhilnikov, Alexey. All rights reserved.
//

import XCTest
import Gloss
@testable import Airports

class AirportsTests: XCTestCase {
    
    let airportDataManager = AirportDataManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        airportDataManager.testDelete()
        XCTAssert(airportDataManager.airports.isEmpty, "airports must be empty after removing all items")
        
        testAppendAirports()
        XCTAssert(2 == airportDataManager.airports.count, "invalid number of airports")
        
        airportDataManager.testSave()
        airportDataManager.testRemoveAll()
        airportDataManager.testLoad()
        XCTAssert(!airportDataManager.airports.isEmpty, "no saved data")
        XCTAssert(2 == airportDataManager.airports.count, "invalid number of saved data")
        
        airportDataManager.testDelete()
        XCTAssert(airportDataManager.airports.isEmpty, "airports must be empty after removing all items")
        
        testFetch()
        XCTAssert(!airportDataManager.airports.isEmpty, "invalid number of airports")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    fileprivate func testAppendAirports() {
        
        let bzdJSON: JSON = [
            "code": "BZD",
            "display_name": "Balranald",
            "international_airport": false,
            "regional_airport": false,
            "location": ["latitude": -34.616665,"longitude": 143.61667],
            "currency_code": "AUD",
            "timezone": "Australia/Sydney",
            "country": ["code": "AU", "display_name": "Australia"]
        ]
        
        let bzeJSON: JSON = [
            "code": "BZE",
            "display_name": "Belize",
            "international_airport": false,
            "regional_airport": false,
            "location": ["latitude": 17.533333,"longitude": -88.3],
            "currency_code": "BZD",
            "timezone": "Canada/Mountain",
            "country": ["code": "BZ", "display_name": "Belize"]
        ]
        
        guard let bzdAirport = Airport(json: bzdJSON) else {
            return
        }
        
        guard let bzeAirport = Airport(json: bzeJSON) else {
            return
        }
        
        airportDataManager.testAppend([bzdAirport, bzeAirport])
    }
    
    fileprivate func testFetch() {
        let expect = expectation(description: "downloading airports data")
        
        airportDataManager.fetch(completion: { (result) in
            switch result {
            case .success:
                XCTAssert(!self.airportDataManager.airports.isEmpty, "no data received")
                
            case let .failure(error):
                XCTFail("unsuccessful API call: \(error)")
            }
            expect.fulfill()
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
}
