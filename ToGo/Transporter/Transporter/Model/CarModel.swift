//
//  CarColorModel.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/24/18.
//  Copyright © 2018 yara. All rights reserved.
//


import Foundation
import ObjectMapper
import UIKit

class CarColorModel: Mappable {

    var ColorId: String?
    var Name: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        ColorId <- map["ColorId"]
        Name <- map["Name"]
        
    }
}


class CarDetailsResult: Mappable {
    
    var Color: [CarColorModel]?
    var Photos: [CarPhotos]?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        Color <- map["Color"]
        Photos <- map["Photos"]
    }
    
}


class CarPhotos: Mappable {
    
    var vehicleId: String?
    var Name: String?
    var PhotoUrl: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        vehicleId <- map["vehicleId"]
        Name <- map["Name"]
        PhotoUrl <- map["PhotoUrl"]
        
    }
}


class ClientCarPhoto: Mappable {
    
    var vehicleId: String?
    var PhotoUrl: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        vehicleId <- map["vehicleId"]
        PhotoUrl <- map["PhotoUrl"]
        
    }
}
