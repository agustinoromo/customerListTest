//
//  Customer.swift
//  Intercom_TakeHome
//
//  Created by Agustin Mendoza Romo on 3/9/19.
//  Copyright © 2019 Agustin Mendoza Romo. All rights reserved.
//

import Foundation
import CoreLocation

struct Customer: Codable {
    var name: String
    var userID: Int
    private var latitudeString: String
    private var longitudeString: String
    
    var latitude: Double? {
        return Double(latitudeString)
    }
    
    var longitude: Double? {
        return Double(longitudeString)
    }
}

extension Customer {
    enum CodingKeys: String, CodingKey {
        case name
        case userID = "user_id"
        case latitudeString = "latitude"
        case longitudeString = "longitude"
    }
    
    func isWithinDistance(_ distanceKm: Double, fromLocation location: CLLocation) -> Bool? {
        guard let latitude = self.latitude, let longitude = self.longitude else { return nil }
        return (location.distance(from: CLLocation(latitude: latitude, longitude: longitude))/1000) > distanceKm ? true : false
    }
    
}
