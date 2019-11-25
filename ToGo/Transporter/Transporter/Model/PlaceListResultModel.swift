//
//  PlaceListResultModel.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/30/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class PlaceListResultModel: Mappable {
    
    // langauge lis parameters
    var IdCity: String?
    var Name: String?
    var LatRegion: String?
    var LongRegion: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        IdCity <- map["IdCity"]
        Name <- map["Name"]
        LatRegion <- map["LatRegion"]
        LongRegion <- map["LongRegion"]
    }
}


