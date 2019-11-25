//
//  TransporterPlaceListResult.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/30/18.
//  Copyright © 2018 yara. All rights reserved.
//



import Foundation
import ObjectMapper


class TransporterPlaceListResult: Mappable {
    
    var PlaceListResult: [PlaceListResultModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        PlaceListResult <- map["server_response"]
    }
    
}
