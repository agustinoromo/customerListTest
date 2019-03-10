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
    var latitude: Double
    var longitude: Double

    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        userID = try values.decode(Int.self, forKey: .userID)
        guard let latitude = try Double(values.decode(String.self, forKey: .latitude)), let longitude = try Double(values.decode(String.self, forKey: .longitude)) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.latitude], debugDescription: "Expecting string representation of Double"))
        }
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(name: String, userID: Int, latitude: Double, longitude: Double) {
        self.name = name
        self.userID = userID
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Customer {
    enum CodingKeys: String, CodingKey {
        case name
        case userID = "user_id"
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    func isWithinDistance(_ distanceKm: Double, fromLocation location: CLLocation) -> Bool {
        return (location.distance(from: CLLocation(latitude: latitude, longitude: longitude))/1000) > distanceKm ? true : false
    }
    
}
