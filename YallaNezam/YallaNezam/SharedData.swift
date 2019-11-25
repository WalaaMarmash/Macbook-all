//
//  SharedData.swift
//  YallaNezam
//
//  Created by fratello software house on 1/2/19.
//  Copyright © 2019 FSH. All rights reserved.
//

import Foundation
import SwiftyJSON


let url = "http://46.253.95.83/YallaNezam/YallaNezamApis/public/FunctionApis.php"

let reachability = Reachability()!

var longLocation = 0.0
var latLocation = 0.0
var checkTypeUpload = ""
var flagSeen = ""
var flagDetails = ""
var photoArray = JSON()
var videoURL : URL!

func validateNumber(enteredNumber:String) -> Bool {
    
    let numberFormat = "^05(9[9875421]|6[982])\\d{6}$"
    let numberPredicate = NSPredicate(format:"SELF MATCHES %@", numberFormat)
    return numberPredicate.evaluate(with: enteredNumber)
    
}
