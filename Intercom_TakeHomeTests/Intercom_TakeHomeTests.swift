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
    
    var testCustomer: Customer {
        return Customer(name: "John", userID: 10, latitude: 52.986375, longitude: -6.043701)
    }
    var testLocation: CLLocation {
        return CLLocation(latitude: 53.339428, longitude: -6.257664)
    }
    
    func testJSONMapping() throws {
        guard let path = Bundle.main.path(forResource: "customerList", ofType: "json") else {
            XCTFail("Missing file: customerList.json")
            return
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let decoder = JSONDecoder()
        let customerList = try decoder.decode([Customer].self, from:
            data)
        guard let latitude = customerList[0].latitude, let longitude = customerList[0].longitude else { return }
        
        XCTAssertEqual(latitude, 52.986375)
        XCTAssertEqual(longitude, -6.043701)
    }
    
    func testIsWithinDistance() {
        print(testCustomer.latitude)
        print(testCustomer.isWithinDistance(100, fromLocation: testLocation))
        
        XCTAssertNotNil(testCustomer.isWithinDistance(100, fromLocation: testLocation))
    }

}
