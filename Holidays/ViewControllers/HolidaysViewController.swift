//
//  HolidaysViewController.swift
//  Holidays
//
//  Created by Ricky Mangerie on 5/16/20.
//  Copyright © 2020 Ricky Mangerie. All rights reserved.
//

import Foundation
import UIKit

/**
 * Implements all the methods from the UITableViewController
 * For the sake of simplicity, only one section is returned in the UITableViewController
 */
class HolidaysViewController: UITableViewController {
    
    var model: [Holiday]?   // An instance of our Holiday model needs to be wrapped into an array because we may be retrieving more than one Holiday model from the view controller passing the data
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        guard let _ = self.model else {
            return 0
        }
        
        return self.model!.count
        
    }
    
    /**
     * Defines the content shown in the cells
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "holidaysid", for: indexPath)
        // Holiday selection
        let holiday = self.model![indexPath.row]
        
        // Based on a self-created extension of the UITableCellView to create unique text content in the cell’s textfield
        cell.makeCustomText(model: holiday)
        
        // Return the configured cell
        return cell     // The number of cells returned is based on the number of elements in the Holiday model array
        
    }
}
