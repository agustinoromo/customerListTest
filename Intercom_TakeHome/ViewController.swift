//
//  ViewController.swift
//  Intercom_TakeHome
//
//  Created by Agustin Mendoza Romo on 3/9/19.
//  Copyright © 2019 Agustin Mendoza Romo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var intercomLocation = CLLocation(latitude: 53.339428, longitude: -6.257664)
    var customerList = [Customer]()
    var customerListCloseBy = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parseJSONFile(forResource: "customerList")
        customerListCloseBy = getClosestCustomers(100)
        orderCustomerList()
        printOutput()
    }
    
    private func getClosestCustomers(_ distanceKm: Double) -> [Customer] {
        return customerList.filter {
            $0.isWithinDistance(distanceKm, fromLocation: intercomLocation) == true
        }
    }
    
    private func orderCustomerList() {
        guard !customerList.isEmpty else { return }
        customerList.sort{ u1, u2 in
            return u1.userID > u2.userID
        }
    }
    
    private func printOutput() {
        customerListCloseBy.forEach {
            print("\($0.name)")
        }
    }
    
    private func parseJSONFile(forResource resource: String)  {
        
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                customerList = try decoder.decode([Customer].self, from:
                    data)
                
            } catch let error {
                print("Error: ", error)
            }
        }
    }
    
}
