//
//  ViewController.swift
//  Holidays
//
//  Created by Ricky Mangerie on 5/16/20.
//  Copyright © 2020 Ricky Mangerie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Programmatically handle the month values entered by the user into the UITextfield
    @IBOutlet weak var months: UITextField!
    
    let model = HolidaysModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
    }

    /**
     * Handles all the functionality after the user clicks on the find holidays button
     * Create the parameters that will be passed to the downloadHolidays method from the HolidaysModel object.
     */
    @IBAction func findHolidays(_ sender: Any) {
        
        let param = ["month": self.months.text!]
        model.downloadHolidays(parameters: param, url: URLServices.holidays)
    }

}

/**
 * Implements the didRecieveData() methodl in order to conform to the Downloadable protocol
 * Once the flow of the program reach this method, the model decoded with the data downloaded from our server is already available
 * To present the data, all that is left to do is to instantiate the UITableViewController
 */
extension ViewController: Downloadable { // implements our Downloadable protocol
    
    /**
     * Gets called whenever a part of the requested URL has been downloaded
     */
    func didReceiveData(data: Any) {
        
        /* The data model has been dowloaded at this point and is passed to the Holidays table view controller */
       DispatchQueue.main.sync {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "holidaysID") as! HolidaysViewController
        
            secondViewController.model = (data as! [Holiday])
            self.present(secondViewController, animated: true, completion: nil)
        
        }
        
    }
    
}
