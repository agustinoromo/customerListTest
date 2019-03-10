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

        openJSONFile(forResource: "customerList")
//        customerListCloseBy = getClosestCustomers(100)
//        orderCustomerList()
//        printOutput()
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
    
    private func openJSONFile(forResource resource: String)  {
        
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let dataResponse = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
//                guard let jsonArray = dataResponse as? [[String:Any]] else { return }
//
//                for dict in jsonArray {
//                    customerList.append(Customer(dict))
//                }
                
                let decoder = JSONDecoder()
                let model = try decoder.decode([Customer].self, from:
                    data)
                print(model)
                
            } catch let error {
                print("Error: ", error)
            }
        }
    }
    
}

//        guard let url = URL(string: "https://s3.amazonaws.com/intercom-take-home-test/customers.txt#") else {return}
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let dataResponse = data,
//                error == nil else {
//                    print(error?.localizedDescription ?? "Response Error")
//                    return }
//            do{
//                //here dataResponse received from a network request
//                let jsonResponse = try JSONSerialization.jsonObject(with:
//                    dataResponse, options: [])
//                print(jsonResponse) //Response result
//            } catch let parsingError {
//                print("Error", parsingError)
//            }
//        }
//        task.resume()
