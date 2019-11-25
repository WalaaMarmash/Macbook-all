//
//  OrdersModel.swift
//  TOGOClient
//
//  Created by Fratello Software Group on 9/20/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class OrdersModel: Mappable {
    
    
    var DateOrder: String?
    var idOrder: String?
    var TimeOrder: String?
    var DeliveryWays: String?
    var ToCity: String?
    var FromCity: String?
    
    
    
    init() {
        
    }
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        
        DateOrder <- map["DateOrder"]
        idOrder <- map["idOrder"]
        TimeOrder <- map["TimeOrder"]
        DeliveryWays <- map["DeliveryWays"]
        ToCity <- map["ToCity"]
        FromCity <- map["FromCity"]
    }
}


import Foundation
import ObjectMapper

class OrdersModelResult: NSObject, Mappable {
    
    var ordersModelResult: [OrdersModel]?
    
   required init?(map: Map) {}
    
    func mapping(map: Map){
        ordersModelResult <- map["server_response"]
    }
    
}
