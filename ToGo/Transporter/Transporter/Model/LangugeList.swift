//
import Foundation

import ObjectMapper

import UIKit

class LangugeListModel: Mappable {
    
    // langauge list parameters
    var id: String?
    var Name: String?
    var Orintation: String?
    
   
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
     
        id <- map["id"]
        Name <- map["Name"]
        Orintation <- map["Orintation"]
     
    }
}

class LangugeResult: Mappable {
    
    var langugeResult: [LangugeListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        langugeResult <- map["server_response"]
    }
    
}
