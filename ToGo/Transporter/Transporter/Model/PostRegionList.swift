//
//  PostRegionList.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/10/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import ObjectMapper
import UIKit

class PostRegionListModel: Mappable {
    
    
    var PostValue: String?
    var id: String?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        
        PostValue <- map["PostValue"]
        id <- map["id"]
        
    }
}
class PostRegionResult: Mappable {
    
    var postRegionResult: [PostRegionListModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map){
        postRegionResult <- map["server_response"]
    }
    
}
