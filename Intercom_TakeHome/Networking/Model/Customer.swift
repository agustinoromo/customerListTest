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
    
    
//    init( _ dictionary: [String: Any]) {
//        self.name = dictionary[JsonKeys.name] as? String ?? ""
//        self.userID = dictionary[JsonKeys.userID] as? Int ?? 0
//        self.latitude = Double(dictionary[JsonKeys.latitude] as? String ?? "") ?? 0
//        self.longitude = Double(dictionary[JsonKeys.longitude] as? String ?? "") ?? 0
//    }
    
//    private struct JsonKeys {
//        static let latitude = "latitude"
//        static let longitude = "longitude"
//        static let name = "name"
//        static let userID = "user_id"
//    }

}

extension Customer {
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
    
    func isWithinDistance(_ distanceKm: Double, fromLocation location: CLLocation) -> Bool {
        guard let latitude = self.latitude, let longitude = self.longitude else { return false }
        return (location.distance(from: CLLocation(latitude: latitude, longitude: longitude))/1000) > distanceKm ? true : false
    }
    
}
