//
//  HolidaysModel.swift
//  Holidays
//
//  Decodes the data downloaded in the response from the Network API
//  The data downloaded is then parsed and decoded into the Holiday struct model
//
//  Created by Ricky Mangerie on 5/16/20.
//  Copyright © 2020 Ricky Mangerie. All rights reserved.
//

import Foundation

/**
 * The model where our data will be decoded
 * Implements the Decodable protocol in order to meet all the decoding rules
 * The variables in the struct need to have exactly the same name and data type that the attributes in the Holiday table from the database have
 */
struct Holiday: Decodable {
    
    var hid: Int
    var description: String
    var month: String
    var day: String
    var year: String
    
}

/**
 * Instantiates a weal delegate property from the Downloadable protocol and a NetworkModel object (the API)
 * Will make the data available and ready to be handled for all the ViewControllers implementing the Downloadable protocol
 */
class HolidaysModel {
    
    weak var delegate: Downloadable?    // Set to Optional because nil responses from the server need to be taken care of
    let networkModel = Network()
    
    /**
     * Creates a URLSession request and then passes that request to the response method from the Network API object
     */
    func downloadHolidays(parameters: [String: Any], url: String) {
        
        let request = networkModel.request(parameters: parameters, url: url)
        networkModel.response(request: request) { (data) in
            
            // The response is parsed and decoded into the Holiday model
            let model = try! JSONDecoder().decode([Holiday]?.self, from: data) as [Holiday]?
            
            // Protocol delegation to invoke the didReceiveData() method from the Downloadable protocol
            self.delegate?.didReceiveData(data: model! as [Holiday])
            
        }
        
    }
}
