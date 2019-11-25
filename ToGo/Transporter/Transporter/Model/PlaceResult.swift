//
//  PlaceResult.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/10/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper


class PlaceResult: Mappable {
    
    var placeResult: [PlaceListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        placeResult <- map["server_response"]
    }
    
}
