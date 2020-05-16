//
//  Network.swift
//  Holidays
//
//  Handles connection to the MySQL Database and appropriate table
//
//  Created by Ricky Mangerie on 5/16/20.
//  Copyright © 2020 Ricky Mangerie. All rights reserved.
//

import Foundation

/**
 * In charge of passing the data downloaded to other models or view controllers that implement this protocol
 * This mechanism of communication between iOS interfaces is called Protocol Delegation
 */
protocol Downloadable: class {
    func didReceiveData(data: Any)
}

/**
 * All the URL end points to the PHP scripts in our server go here
 */
enum URLServices {
    static let holidays: String = "http://mangerie.net/holidays/holidays.php"
}

/**
 * Creates the request and response methods that will handle the communication between the client and the server
 */
class Network{
    
    func request(parameters: [String: Any], url: String) -> URLRequest {
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        return request
        
    }
    
    /**
     * Takes the request and a complexion block as parameters
     * Since the Session Shared Data Task method is asynchronous, the completion block will make sure that the data is available when we need it
     */
    func response(request: URLRequest, completionBlock: @escaping (Data) -> Void) -> Void {
        
        /* Create a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion */
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {   // Check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else { // Check for http errors
                
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
                
            }
            
            // Data will be available for other models that implements the block
            completionBlock(data);
        }
        
        // Resume the URLSession task if it is suspended
        task.resume()
        
    }
}

/**
 * Provides escape functionality to the URLSession
 */
extension Dictionary {
    
    func percentEscaped() -> String {
        
        return map { (key, value) in
            
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            
            return escapedKey + "=" + escapedValue
            
            }
            .joined(separator: "&")
        
    }
    
}

/**
* Provides parsing functionality to the URLSession
*/
extension CharacterSet {
    
    static let urlQueryValueAllowed: CharacterSet = {
        
        let generalDelimitersToEncode = ":#[]@" // Does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return allowed
        
    }()
    
}
