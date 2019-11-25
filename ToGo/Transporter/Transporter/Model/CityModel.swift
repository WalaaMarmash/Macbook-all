//
//  ClientCityCarResult.swift
//  ToGo
//
//  Created by Fratello Software Group on 8/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper


class ClientCityCarResult: Mappable {
    
    var Citys: [ClientCityList]?
    var Photos: [ClientCarPhoto]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        Citys <- map["Citys"]
        Photos <- map["Photos"]
    }
    
}


class ClientCityList: Mappable {
    
    var IdCity: String?
    var LatRegion: String?
    var LongRegion: String?
    var Name: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        IdCity <- map["IdCity"]
        LatRegion <- map["LatRegion"]
        Name <- map["Name"]
        LongRegion <- map["LongRegion"]
    }
}


class IdPlaceResult: Mappable {
    
    var Result: licenceResult?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        Result <- map["SUCCESS"]
        
    }
    
}


class idPlaceModel: Mappable {
    
    
    var IdPlace: String?
    var NamePlace: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        IdPlace <- map["IdPlace"]
        NamePlace <- map["NamePlace"]
        
    }
}


class idPlaceTypeModel: Mappable {
    
    
    var IdTypeLicence: String?
    var TypeName: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        IdTypeLicence <- map["IdTypeLicence"]
        TypeName <- map["TypeName"]
        
    }
}
