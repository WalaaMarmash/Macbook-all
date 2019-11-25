//
//  TransporterBalance.swift
//  Transporter
//
//  Created by Fratello Software Group on 12/23/18.
//  Copyright © 2018 yara. All rights reserved.
//
import Foundation
import UIKit
import ObjectMapper

class TransporterBalanceResult: Mappable {
    
    var TransporterBalanceResult: [TransporterBalanceModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        TransporterBalanceResult <- map["server_response"]
    }
    
}


class TransporterBalanceModel: Mappable {
    
    
    var TransporterBalance: Float?
   
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        TransporterBalance <- map["TransporterBalance"]
       
        
        
    }
}
