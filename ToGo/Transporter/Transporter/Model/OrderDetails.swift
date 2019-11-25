//
//  OrderDetails.swift
//  TOGOTransporter
//
//  Created by Fratello Software Group on 9/19/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class OrderDetails: Mappable {
    
    
    var deliveryWay: String?
    var FullNameCustomer: String?
    var DetailsLoad: String?
    var LengthLoad: String?
    var WidthLoad: String?
    var HeightLoad: String?
    var WeightLoad: String?
    var DateLoad: String?
    var IdCitySource: String?
    var IdCityDes: String?
    var NameStreet: String?
    var NameBuilding: String?
    var NameNeighborhood: String?
    var FloorNumbers: String?
    var ApartmentNumber: String?
    var OtherDetails: String?
    var LatSender: String?
    var LongSender: String?
    var LatReciver: String?
    var LongReciver: String?
    var NameNeighborhoodDes: String?
    var NameStreetDes: String?
     var NameBuildingDes: String?
     var FloorNumbersDes: String?
     var ApartmentNumberDes: String?
    var OtherDetailsDes: String?
    
    var PhoneCustomer: String?
    var TypeLoad: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        
        deliveryWay <- map["deliveryWay"]
        FullNameCustomer <- map["FullNameCustomer"]
        DetailsLoad <- map["DetailsLoad"]
        LengthLoad <- map["LengthLoad"]
        WidthLoad <- map["WidthLoad"]
        HeightLoad <- map["HeightLoad"]
        WeightLoad <- map["WeightLoad"]
        DateLoad <- map["DateLoad"]
        IdCitySource <- map["IdCitySource"]
        IdCityDes <- map["IdCityDes"]
        NameStreet <- map["NameStreet"]
        NameBuilding <- map["NameBuilding"]
        NameNeighborhood <- map["NameNeighborhood"]
        FloorNumbers <- map["FloorNumbers"]
        ApartmentNumber <- map["ApartmentNumber"]
        OtherDetails <- map["OtherDetails"]
        LatSender <- map["LatSender"]
        LongSender <- map["LongSender"]
        LatReciver <- map["LatReciver"]
        LongReciver <- map["LongReciver"]
        NameNeighborhoodDes <- map["NameNeighborhoodDes"]
        NameStreetDes <- map["NameStreetDes"]
        NameBuildingDes <- map["NameBuildingDes"]
        FloorNumbersDes <- map["FloorNumbersDes"]
        ApartmentNumberDes <- map["ApartmentNumberDes"]
        OtherDetailsDes <- map["OtherDetailsDes"]
        PhoneCustomer <- map["PhoneCustomer"]
        TypeLoad <- map["TypeLoad"]
        
    }
}

class OrderDetailsResult: Mappable {
    
    var orderDetailsResult: [OrderDetails]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        orderDetailsResult <- map["server_response"]
    }
    
}

