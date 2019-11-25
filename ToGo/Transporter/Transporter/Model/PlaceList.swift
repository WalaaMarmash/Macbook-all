//
//  PlaceList.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/10/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class PlaceListModel: Mappable {
    
    var Name: String?
    var RegId: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
       
        Name <- map["Name"]
        RegId <- map["RegId"]
        
    }
}

