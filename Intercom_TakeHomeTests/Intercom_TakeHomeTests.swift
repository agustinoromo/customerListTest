//
//  Intercom_TakeHomeTests.swift
//  Intercom_TakeHomeTests
//
//  Created by Agustin Mendoza Romo on 3/9/19.
//  Copyright © 2019 Agustin Mendoza Romo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Intercom_TakeHome

class Intercom_TakeHomeTests: XCTestCase {
    
    private let testCustomer = Customer(name: "Alice Cahill", userID: 1, latitude: 51.92893, longitude: -10.27699)
    private let testLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)
    
    func testJSONMapping() throws {
        guard let path = Bundle.main.path(forResource: "customerList", ofType: "json") else {
            XCTFail("Missing file: customerList.json")
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customerList = try decoder.decode([Customer].self, from:
            data)
        
        XCTAssertEqual(customerList[0].latitude, 52.986375)
        XCTAssertEqual(customerList[0].longitude, -6.043701)
    }
    
    func testIsWithinDistance() {
        XCTAssertTrue(testCustomer.isWithinDistance(100, fromLocation: testLocation))
        var farCustomer = testCustomer
        farCustomer.latitude = 52.986375
        farCustomer.longitude = -6.043701
        XCTAssertFalse(farCustomer.isWithinDistance(100, fromLocation: testLocation))
    }

}
