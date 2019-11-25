//
//  LoginLoader.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/11/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

// Login Api by the mobile number
class LoginLoader{
    
    static var phoneNumber = ""
    static var loginReult = ""
    
    // Login Api
    func Login(completed: @escaping DownloadComplete) {
        
        let url =  Base_URL
        let phoneNumber = LoginLoader.phoneNumber
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"Login", "PhoneNumber":phoneNumber,"TypeCustomer": "Transporter"]).responseString{ response in
            
            print("LoginResponse:\(response.result.value)")
            
            if let result = response.result.value{
                
                LoginLoader.loginReult = result
                print(LoginLoader.loginReult)
                completed()
            }
            
            
            
            
        }
    }
}

// Activation user account
class VerifiedAcountLoader{
    
    static var VerifiedReult = ""
    static var VerifiedCode = ""
    static var VerifiedToken = "tt"
    var TokenNotifiy = ""
    
    func VerifiedAcount(completed: @escaping DownloadComplete) {
        
        let url =  Base_URL
        let lang_id = UserDefaults.standard.string(forKey: "language_id")
        let Region_id = UserDefaults.standard.string(forKey: "Region_id")
        VerifiedAcountLoader.VerifiedToken = UserDefaults.standard.string(forKey: "deviceToken")!
        
        
        if let fcmToken = UserDefaults.standard.string(forKey: "fcmToken"){
            TokenNotifiy = fcmToken
        }
        
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"VerifiedAcount", "PhoneNumber":LoginLoader.phoneNumber,"Code": VerifiedAcountLoader.VerifiedCode,"TokenDevice": VerifiedAcountLoader.VerifiedToken,"TokenNotifiy":TokenNotifiy,"RegionId":Region_id!,"LangId":lang_id!]).responseString{ response in
            
            print(response.result.value)
            
            if let result = response.result.value{
                
            if result == "Wrong_Code"{
                VerifiedAcountLoader.VerifiedReult = result
                
            }else if result == "ParameterError"{
                VerifiedAcountLoader.VerifiedReult = result
                
            }
            
                
            else{
                
                
                VerifiedAcountLoader.VerifiedReult = "right_Code"
                do {
                    let data = response.data
                    if
                        let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                        let res = json["server_response"] as? [[String: Any]] {
                        for item in res {
                            if let id = item["id"] as? String {
                                
                                UserDefaults.standard.set(id, forKey: "userID")
                                
                                print("userid\(id)")
                            }
                            
                            if let FlagRegistration = item["FlagRegistration"] as? String {
                                
                                UserDefaults.standard.set(FlagRegistration, forKey: "FlagRegistration")
                                
                                print("FlagRegistration\(FlagRegistration)")
                            }
                            
                            if let PhoneNumber = item["PhoneNumber"] as? String {
                                
                                UserDefaults.standard.set(PhoneNumber, forKey: "PhoneNumber")
                                
                                print("PhoneNumber\(PhoneNumber)")
                            }
                        }
                    }
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
                
                
                
                
            }
                
            }
            
            completed()
        }
        
    }
}



