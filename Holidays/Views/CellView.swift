//
//  CellView.swift
//  Holidays
//
//  Created by Ricky Mangerie on 5/16/20.
//  Copyright © 2020 Ricky Mangerie. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    /**
     * An extension in the UITableViewClass which creates  custom text content for the cell
     */
    func makeCustomText (model: Holiday?)  {
        
        guard let _ = model else {
            return
        }
        
        /* Will display the holiday description, month, day and year in the textfield */
        let customText = model!.description + ", " + model!.month + " " + model!.day + " " + model!.year
        self.textLabel?.text = customText
        
    }
}
