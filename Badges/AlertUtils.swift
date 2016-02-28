//
//  AlertUtils.swift
//  Badges
//
//  Created by Samuel Gonzalez Portilla on 2/26/16.
//  Copyright © 2016 Stanford. All rights reserved.
//

import Foundation
import UIKit

class AlertUtils {
    
    class func getMessageAlert (title: String, message: String) ->UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default)
            { (action: UIAlertAction) -> Void in
                // Do nothing
            }
        )
        return alert
    }
    
    class func getAlertWithAction (title: String, message: String, action: UIAlertAction) ->UIAlertController {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .ActionSheet)
        
        alert.addAction(action)
        return alert
    }
}
