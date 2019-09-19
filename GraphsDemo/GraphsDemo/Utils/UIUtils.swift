//
//  UIUtils.swift
//  GraphsDemo
//
//  Created by Vijay Godse on 9/16/19.
//  Copyright © 2019 Vijay Godse. All rights reserved.
//

import Foundation

class UIUtils {
    
    /**
     Function used to convert Date to Date string
     - Parameter timestamp: Date
     - Parameter Format: Date format (eg. "MMM dd, yyyy")
     - Returns String: Date String
     */
    static func convertDateToString(date: Date, format: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
    
}
