//
//  LangugeListLoader.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/9/18.
//  Copyright © 2018 yara. All rights reserved.


import Foundation
import Alamofire
import AlamofireObjectMapper


//Get Language List API
class LangugeListLoader{
    
    // Languge List
    var _langugeList = [LangugeListModel]()
    var langugeList: [LangugeListModel]{
        return _langugeList
    }
    
    // Get Languge List
    func GetLangugeList(completed: @escaping DownloadComplete) {
        
        let url =  Base_URL
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetLanguages"]).responseObject{ (response: DataResponse<LangugeResult>) in
            
            let result = response.result.value
            
            if let langugeList = result?.langugeResult{
                print(langugeList.count)
                self._langugeList = langugeList
            }
            
            completed()
            
            
        }
    }
}

// Get Place List API
class PlaceListLoader{
    
    // Languge List
    var _palceList = [PlaceListModel]()
    var palceList: [PlaceListModel]{
        return _palceList
    }
    
    // Get Place List
    func GetPlaceList(completed: @escaping DownloadComplete) {
        
        let url =  Base_URL
        
        let lang_id = UserDefaults.standard.string(forKey: "language_id")
        print("lang_id\(lang_id!)")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetRegions", "IdLanguages": lang_id!]).responseObject{ (response: DataResponse<PlaceResult>) in
            
            let result = response.result.value
            
            if let placeResult = result?.placeResult{
            
            if placeResult.count == 0{
                self._palceList = []
            }else{
                self._palceList = placeResult
            }
            }
            
            completed()
            
            
        }
    }
    
}




// Get Region List API
class RegionListLoader{
    
    
    // Languge List
    var _RegionList = [PostRegionListModel]()
    var RegionList: [PostRegionListModel]{
        return _RegionList
    }
    
    // Get Place List
    func GetPostRegions(completed: @escaping DownloadComplete) {
        
        let url =  Base_URL
        
        let Region_id = UserDefaults.standard.string(forKey: "Region_id")
        print("Region_id\(Region_id!)")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetPostRegions", "IdRegion": Region_id!]).responseObject{ (response: DataResponse<PostRegionResult>) in
            
            let result = response.result.value
            
            if let postRegionResult = result?.postRegionResult{
            
            if postRegionResult.count == 0{
                self._RegionList = []
            }else{
                
                self._RegionList = postRegionResult
            }
            }
            
            completed()
            
            
        }
    }
}



