//
//  TransporterLoader.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/22/18.
//  Copyright © 2018 yara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON
import ObjectMapper


class TransporterLoader{
    
    static var transporterLoader = TransporterLoader()
    
    
    // Transporter Personal info
    static var Email = ""
    static var date = ""
    static var FullName = ""
    static var IDPlace = ""
    static var IDNumber = ""
    static var LicenceNumber = ""
    static var LicenceType = ""
    static var AccountName = ""
    static var PersonalImgName = ""
    static var PersonalImgCode = ""
    static var LicenceImgName = ""
    static var LicenceImgCode = ""
    static var TransporterinfoResult = ""
    static var CarInfoResult = ""
    
    // Transporter car info
    static var RegistrationNumber = ""
    static var RegistrationFinshDay = ""
    static var CarImgId = ""
    static var CarColorId = ""
    static var CarImgName = ""
    static var CarImgCode = ""
    static var RegistrationImgName = ""
    static var RegistrationImgCode = ""
    static var LicenceCarNumber = ""
    
    
    //Transporter Work Details
    static var choosenPlaceList = [String : [AnyObject]]()
    static var choosenTimeWork = [String : [AnyObject]]()
    
    static var CancelOrderId = ""
    static var  CancelOrderResult = ""
    //static var placeList = [String]()
    
    // Licence Place
    var _IdPlaceModel = [idPlaceModel]()
    
    var IdPlaceModel: [idPlaceModel]{
        return _IdPlaceModel
    }
    // Licence type
    var _IdPlaceTypeModel = [idPlaceTypeModel]()
    
    var IdPlaceTypeModel: [idPlaceTypeModel]{
        return _IdPlaceTypeModel
    }
    
    // Car Color
    var _CarColorModel = [CarColorModel]()
    
    var carColorModel: [CarColorModel]{
        return _CarColorModel
    }
    // Car Photos
    var _carPhotos = [CarPhotos]()
    
    var carPhotos: [CarPhotos]{
        return _carPhotos
    }
    
    // palce List
    var _placeList = [PlaceListResultModel]()
    
    var placeList: [PlaceListResultModel]{
        return _placeList
    }
    //Order Details
    static var availableOrderID:[String] = []
    static var availableOrderFromPlace:[String] = []
    static var availableToPlace:[String] = []
    static var availableTimeOrder:[String] = []
    static var availableDateOrder:[String] = []
    static var availabledeliveryWay:[String] = []
    // Licence type
    static  var  _WorkTranspoterResult = [WorkTranspoterModel]()
    static var jsonStringWorkTime: String = ""
    static var GetIdPlaceResult = ""
    static var IdPlace  : [String]! =  []
    static var NamePlace  : [String]! =  []
    static var Idlicence : [String]! =  []
    static var Namelicence  : [String]! =  []
    
    //OrderDetails
    static  var  _OrderDetailsResult = [OrderDetails]()
    
    
    
    static var TypeAction = ""
    static var NewCost = ""
    
    let url =  Base_URL
    // get Transporter Licence id place
    func GetIdPlaceLicence(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        
        let lang_id = UserDefaults.standard.string(forKey: "language_id")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetIdPlaceLicence", "Idlanguage":lang_id!,"CustomerId":userID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if   let result = response.result.value{
                
                if result == "TokenError" || result == "Blocked" {
                    
                }
                    
                else{
                    if let result = response.result.value{
                        let licenceResult = Mapper<licenceResult>().map(JSONString: result)
                        
                        if let licenceResult = licenceResult?.idPlaceType{
                             self._IdPlaceModel = licenceResult
                        }
                        if let IdPlaceType = licenceResult?.idPlaceResult {
                             self._IdPlaceTypeModel = IdPlaceType
                        }
                        
                       
                       
                    }
                }
            }
            completed()
            
            
        }
    }
    
    
    // get Car details(colors, photos)
    func GetColorPhotoCar(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        let lang_id = UserDefaults.standard.string(forKey: "language_id")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetColorPhotoCar", "Idlanguage":lang_id!,"CustomerId":userID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if  let result = response.result.value{
                
                if result == "TokenError"{
                    
                }else{
                    if let result = response.result.value{
                        let CarDetailsResult = Mapper<CarDetailsResult>().map(JSONString: result)
                        
                        if let CarDetailsResult = CarDetailsResult?.Color{
                            self._CarColorModel = CarDetailsResult
                        }
                        if let carPhotoResult = CarDetailsResult?.Photos{
                            self._carPhotos  = carPhotoResult
                        }
                        
                       
                    }
                }
            }
            
            completed()
            
            
        }
    }
    
    
    
    
    // Post Transporter Information
    func SetTransporterInfo(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"SetTransporterInfo", "CustomerId":userID,"FullName":TransporterLoader.FullName,"BirthDay":TransporterLoader.date,"IDPlace":TransporterAccountViewController.PlaceId,"IDNumber":TransporterLoader.IDNumber,"LicenceNumber":TransporterLoader.LicenceNumber,"LicenceType": TransporterAccountViewController.LicenseId,"Email":TransporterLoader.Email,"AccountName":TransporterLoader.AccountName,"PersonalImgName":TransporterLoader.PersonalImgName,"PersonalImgCode":TransporterLoader.PersonalImgCode,"LicenceImgName":TransporterLoader.LicenceImgName,"LicenceImgCode":TransporterLoader.LicenceImgCode,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            print(response.result.value)
            
            if let result = response.result.value{
                
                TransporterLoader.TransporterinfoResult = result
                
                print("SetTransporterInfo\(result)")
            }
            completed()
            
            
        }
    }
    
    // Post Transporter car information
    func SetCarInfo(completed: @escaping DownloadComplete) {
        
        print(TransporterLoader.CarImgId)
        print(TransporterLoader.RegistrationImgCode)
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"SetCarInfo", "CustomerId":userID,"RegistrationNumber":TransporterLoader.RegistrationNumber,"RegistrationFinshDay":TransporterLoader.RegistrationFinshDay,"CarImgId":TransporterLoader.CarImgId,"CarColorId":TransporterLoader.CarColorId,"CarImgName":TransporterLoader.CarImgName,"CarImgCode":TransporterLoader.CarImgCode,"RegistrationImgName":TransporterLoader.RegistrationImgName,"RegistrationImgCode":TransporterLoader.RegistrationImgCode,"LicenceCarNumber":TransporterLoader.LicenceCarNumber,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            print(response.result.value)
            
            if let result = response.result.value{
                
                
                TransporterLoader.CarInfoResult = (result)
                
                print(result)
                
            }
            completed()
            
            
        }
    }
    
    
    
    
    //  Get City Region
    func GetCityRegion(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        
        let lang_id = UserDefaults.standard.string(forKey: "language_id")
        let Region_id = UserDefaults.standard.string(forKey: "Region_id")
        
        
        print(UserDefaults.standard.string(forKey: "deviceToken")!)
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetCityRegion", "Idlanguage":lang_id!, "IdRegion": Region_id!,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,"CustomerId":userID]).responseString{ response in
            
            print(response.result.value)
            if   let result = response.result.value{
                
                if result == "TokenError"{
                    
                }else{
                    if  let result = response.result.value{
                        let TransporterPlaceListResult = Mapper<TransporterPlaceListResult>().map(JSONString: result)
                        
                        if let TransporterPlaceListResult = TransporterPlaceListResult?.PlaceListResult{
                           self._placeList = TransporterPlaceListResult
                        }
                        
                       
                    }
                    
                }
            }
            completed()
            
            
        }
        
    }
    
    //SetWorkTranspoterParameter
    func SetWorkTranspoterParameter(completed: @escaping DownloadComplete) {
        
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        // City IDs
        let jsonDataPlaceList = try? JSONSerialization.data(withJSONObject: TransporterLoader.choosenPlaceList, options: [])
        
        let jsonStringPlaceList = String(data: jsonDataPlaceList!, encoding: .utf8)
        print("jsonStringPlaceList:\(jsonStringPlaceList!)")
        
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"SetWorkTranspoterParameter", "CustomerId":userID, "CityWork": jsonStringPlaceList!,"TimeWork":TransporterLoader.jsonStringWorkTime,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            print(response.result.value)
            
            if let result = response.result.value{
                
                if result == "TokenError"{
                    
                }else{
                    if  let result = response.result.value{
                        let WorkTranspoterResult = Mapper<WorkTranspoterResult>().map(JSONString: result)
                        
                        if let WorkTranspoterResult = WorkTranspoterResult?.workTranspoterResult{
                            TransporterLoader._WorkTranspoterResult  = WorkTranspoterResult
                        }
                    
                        
                    }
                }
                
            }
            
            
            completed()
        }
        
        
    }
    
    func TransporterGetOrder(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        print("transporterID:\(userID)")
        print("TokenDevice \(UserDefaults.standard.string(forKey: "deviceToken")!)")
        
        Alamofire.request(url, method: .post
            ,parameters:["CheckTypeFunction":"TransporterGetOrder", "TokenDevice":UserDefaults.standard.string(forKey: "deviceToken")!, "TransporterId": userID, "Counter": PageNumber]).responseString{ response in
                
                print("PageNumber\(PageNumber)")
               
                print("response:\(response.result.value ?? "")")
                
                
                if  let result = response.result.value{
                
                    
                    if result == "NotActiveNow"{
                        AvailableOrderViewController.GetOrderResult = "NotActiveNow"
                        print("NotActiveNow")
                    }else if result == "NotAccepted"{
                        
                        AvailableOrderViewController.GetOrderResult = "NotAccepted"
                        
                        print("NotAccepted")
                    }
                    else if result == "TokenError"{
                        AvailableOrderViewController.GetOrderResult = "TokenError"
                    }
                        
                    else{
                        
                         AvailableOrderViewController.GetOrderResult = result
                        let ordersModelResult = Mapper<OrdersModelResult>().map(JSONString: result)
                            
                            if let OrdersModelResult = ordersModelResult?.ordersModelResult{
                                
                                if OrdersModelResult.count == 0 {
                                   // AvailableOrderViewController.isPageRefreshing = true
                                }
                                else{
                                    AvailableOrderViewController.isPageRefreshing = false
                                }
                                //  AvailableOrderViewController.Orders = OrdersModelResult
                                
                                for item in OrdersModelResult{


                                 AvailableOrderViewController.Orders.append(item)
                                }
                                
                            }
                            
                            
                      
                    }
                }
                
                //  print(result!)
                
                completed()
                
                
        }
    }
    
    
    
    
    func TransporterSetCostOrder(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        print(PopUpViewController.OrderID)
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterSetCostOrder", "TransporterId":userID,"OrderId":PopUpViewController.OrderID,"CostDelivery":PopUpViewController.PriceOffer,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            if  let result = response.result.value{
                
                PopUpViewController.SubmitCostResult = result
                
                print("TransporterSetCostOrderResponse:\(PopUpViewController.SubmitCostResult)")
                
                
            }
            completed()
            
            
        }
    }
    
    func TransporterShowDetailsOrder(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        print("orderID\(OrderDetailsViewController.OrderID)")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterShowDetailsOrder", "TransporterId":userID,"OrderId":OrderDetailsViewController.OrderID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
       
            print(response.result.value)
            
            if  let result = response.result.value{
                
                if result == "TokenError"{
                    print( "TokenError")
                }else if result == "OrderNotFound"{
                    OrderDetailsViewController.OrderDetailsResult = "OrderNotFound"
                    print("OrderNotFound")
                }else if result == "Blocked"{
                    print("Blocked")
                }
                    
                    
                else{
                       OrderDetailsViewController.OrderDetailsResult = "OrderFound"
                        let OrderDetailsResult = Mapper<OrderDetailsResult>().map(JSONString: result)
                        
                        if let OrderDetailsResult = OrderDetailsResult?.orderDetailsResult{
                         
                        TransporterLoader._OrderDetailsResult = OrderDetailsResult
                       
                    }
                }
                
            }
            completed()
            
            
        }
    }
    
    
    
    func TransporterShowDetailsOrderCurrent(completed: @escaping DownloadComplete) {
        
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterShowDetailsOrderCurrent", "TransporterId":userID,"OrderId":OrderDetailViewController.OrderID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            print(response.result.value)
            if  let result = response.result.value{
                
                if result == "TokenError"{
                    print( "TokenError")
                }else if result == "OrderNotFound"{
                    print("OrderNotFound")
                    OrderDetailsViewController.OrderDetailsResult = "OrderNotFound"
                }else if result == "Blocked"{
                    print("Blocked")
                }
                    
                    
                else{
                  OrderDetailsViewController.OrderDetailsResult = "OrderFound"
                        let OrderDetailsResult = Mapper<OrderDetailsResult>().map(JSONString: result)
                        
                        if let OrderDetailsResult = OrderDetailsResult?.orderDetailsResult{
                             TransporterLoader._OrderDetailsResult = OrderDetailsResult
                        }
                     
                        
                  
                }
                
            }
            completed()
            
            
        }
    }
    
    
    
    // show order Details--Current order
    func TransporterOrderCurrent(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        print("userID \(userID)")
        print("TokenDevice \(UserDefaults.standard.string(forKey: "deviceToken")!)")
        // let lang_id = UserDefaults.standard.string(forKey: "language_id")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":
            "TransporterOrderCurrent","TransporterId":userID,
                                      "TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,
                                      ]).responseString{ response in
                                        
                                        print(response.result.value)
                                        
                                        
                                        if let result = response.result.value{
                                            
                                            if result == "TokenError"{
                                                
                                                print( "TokenError")
                                            }else if result == "Blocked"{
                                                print("Blocked")
                                            }
                                                
                                                
                                            else{
                                                
                                                    let ordersModelResult = Mapper<OrdersModelResult>().map(JSONString: result)
                                                    
                                                    if let  ordersModelResult = ordersModelResult?.ordersModelResult{
                                                    CurrentOrderViewController.Orders = ordersModelResult
                                                    }
                                                
                                            }
                                        }
                                        
                                        completed()
                                        
                                        
        }
    }
    
    
    //All  Previous Client Orders
    func TransporterHistoryOrder(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        
        print("userID: \(userID)")
        print("TokenDevice: \(UserDefaults.standard.string(forKey: "deviceToken")!)")
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterHistoryOrder","TransporterId":userID
            ,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,"Counter": HistoryPageNumber]).responseString{ response in
                
                print("HistoryPageNumber\(HistoryPageNumber)")
                
                if  let result = response.result.value{
                    
                    print(result)
                    
                    if result == "TokenError"{
                        print( "TokenError")
                    }else if result == "Blocked"{
                        print("Blocked")
                    }
                        
                        
                    else{
                        
                            let ordersModelResult = Mapper<OrdersModelResult>().map(JSONString: result)
                            
                            if let ordersModelResult = ordersModelResult?.ordersModelResult {
                                
                                
                                
                                if ordersModelResult.count == 0 {
                                   // PreviousViewController.isPageRefreshing = true
                                }
                                else{
                                    PreviousViewController.isPageRefreshing = false
                                }
                                //  AvailableOrderViewController.Orders = OrdersModelResult
                                
                                for item in ordersModelResult{
                                    
                                    
                                   PreviousViewController.Orders.append(item)
                                }
                                
                                
                                
                            }
                       
                    }}
                completed()
                
                
        }
    }
    
    
    // cancel order
    func TransporterDeleteOrder(completed: @escaping DownloadComplete) {
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterDeleteOrder", "TransporterId":userID,"OrderId":TransporterLoader.CancelOrderId,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if  let result = response.result.value{
                TransporterLoader.CancelOrderResult = result
                
            }
            completed()
            
        }
    }
    
    
    
    func TransporterSetLocationCurrentOrders(completed: @escaping DownloadComplete) {
        
        var Id = ""
        if let userID = UserDefaults.standard.string(forKey: "userID"){
            Id = userID
        
        
        var LatLocation: String = ""
        var LongLocation: String = ""
        
        if  let TransporterLatLocation = UserDefaults.standard.string(forKey: "TransporterLat"), let
            TransporterLongLocation = UserDefaults.standard.string(forKey: "TransporterLong"){
            
            LatLocation = TransporterLatLocation
            LongLocation = TransporterLongLocation
        }
        
        
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterSetLocationCurrentOrders", "TransporterId":Id,"TransporterLatLocation":LatLocation,"TransporterLongLocation":LongLocation,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if  let result = response.result.value{
                
                AppDelegate.setLocationResult = result
                
            }
           
            
            completed()
            
            
        }
        }
        
        
        
    }
    
    
    
    // cancel order
    func TransporterFinshTrip(completed: @escaping DownloadComplete) {
        
        print("OrderDetailViewController.OrderID\(OrderDetailViewController.OrderID)")
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterFinshTrip", "TransporterId":userID,"OrderId":OrderDetailViewController.OrderID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if  let result = response.result.value{
                OrderDetailViewController.SendVerfiedCodeToReciverResult = result
               print(result)
                
            }
            
            
            completed()
            
            
        }
    }
    
    
    
    
    func TransporterConfirmFinshTrip(completed: @escaping DownloadComplete) {
        
       
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterConfirmFinshTrip", "TransporterId":userID,"OrderId":OrderDetailViewController.OrderID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,"CodeVerify": OrderDetailViewController.CodeVerify ]).responseString{ response in
            
            
            if  let result = response.result.value{
               OrderDetailViewController.SendVerfiedCodeConfirmFinshTrip = result
                print(result)
                
            }
            
            
            completed()
            
            
        }
    }

    
    
    
    func GetBalanceTransporter (completed: @escaping DownloadComplete) {
        
        
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"GetBalanceTransporter", "TransporterId":userID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!]).responseString{ response in
            
            
            if  let result = response.result.value{
                print(result)
                
                let TransporterBalanceResult = Mapper<TransporterBalanceResult>().map(JSONString: result)
                
                if let BalanceResult = TransporterBalanceResult?.TransporterBalanceResult {
                    WalletViewController.BalanceResult = "\(BalanceResult[0].TransporterBalance!)"
            }
            }
            
            
            completed()
            
            
        }
    }
    
    
    
    
    
    func CheckPriceTrip (completed: @escaping DownloadComplete) {
        
        print(PopUpViewController.OrderID)
        
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"CheckPriceTrip", "TransporterId":userID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,"OrderId" : PopUpViewController.OrderID]).responseString{ response in
            
            
            if  let result = response.result.value{
                print(result)
                if result == "CostNotSend"{
                    AvailableOrderViewController.submitCostStatus = result

                }else{
                    AvailableOrderViewController.submitCostStatus = "CostSent"
                    do {
                    let data = response.data
                    if
                        let json = try JSONSerialization.jsonObject(with: data!) as? [String: Any],
                        let res = json["server_response"] as? [[String: Any]] {
                        for item in res {
                            if let CostDelivery = item["CostDelivery"] as? String {
                                CheckCostPopupViewController.CostDelivery = CostDelivery
                               print("CostDelivery\(CostDelivery)")
                            }
                        }
                        }
               
                    }catch {
                        print("Error deserializing JSON: \(error)")
                    }
            
                }
            
           
            
            
        }
             completed()
    }
    
}
    
    
    
    func TransporterEditPriceTrip (completed: @escaping DownloadComplete) {
        
        
        
        let userID = UserDefaults.standard.string(forKey: "userID")!
        Alamofire.request(url, method: .post,parameters:["CheckTypeFunction":"TransporterEditPriceTrip", "TransporterId":userID,"TokenDevice": UserDefaults.standard.string(forKey: "deviceToken")!,"OrderId" : PopUpViewController.OrderID,"NewCost": TransporterLoader.NewCost,"TypeAction": TransporterLoader.TypeAction]).responseString{ response in
            
            
            if  let result = response.result.value{
                print(result)
                CheckCostPopupViewController.DeleteSubmitCostResult = result
                
            }
            
            
            completed()
            
            
        }
    }
    
    
}
