//
//  WorkTranspoterResult.swift
//  ToGo
//
//  Created by Fratello Software Group on 8/8/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class WorkTranspoterResult: Mappable {
    
    var workTranspoterResult: [WorkTranspoterModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        workTranspoterResult <- map["server_response"]
    }
    
}


class WorkTranspoterModel: Mappable {
    
    
    var StatusCity: Any?
    var StatusWork: Any?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        StatusCity <- map["StatusCity"]
        StatusWork <- map["StatusWork"]
      
        
    }
}
