//
//  licenceResult.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/22/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper


class licenceResult: Mappable {
    
    var idPlaceResult: [idPlaceTypeModel]?
    var idPlaceType: [idPlaceModel]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        idPlaceResult <- map["license"]
        idPlaceType <- map["place"]
    }
    
}
