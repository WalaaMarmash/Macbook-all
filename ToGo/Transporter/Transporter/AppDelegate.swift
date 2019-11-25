//
//  AppDelegate.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase
import UserNotifications
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var googleAPIKey = "AIzaSyA8_TurOEiGaBf_3cQvKRPRyRhzZ6Ux1VE"
    static var Transportlocation = CLLocationManager()
    var transporter = TransporterLoader()
   static var setLocationResult = ""
    static var NotificationTitleType = ""
    
    
    let View = UIView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        AppDelegate.Transportlocation = CLLocationManager()
        AppDelegate.Transportlocation.delegate = self
        AppDelegate.Transportlocation.requestWhenInUseAuthorization()
        AppDelegate.Transportlocation.startUpdatingLocation()
        AppDelegate.Transportlocation.desiredAccuracy = kCLLocationAccuracyBest
        AppDelegate.Transportlocation.allowsBackgroundLocationUpdates = true
        AppDelegate.Transportlocation.startMonitoringSignificantLocationChanges()
        
        GMSServices.provideAPIKey(googleAPIKey)
        GMSPlacesClient.provideAPIKey(googleAPIKey)
        
        let pageContoller = UIPageControl.appearance()
        pageContoller.pageIndicatorTintColor = UIColor(netHex: 0x29A89A)
        pageContoller.currentPageIndicatorTintColor = UIColor.darkGray
        
        
        
        
        let Transporetr_Status_reg = UserDefaults.standard.bool(forKey: "Transporter_susess_registration")
        
        let PersonalFlagRegistration =  UserDefaults.standard.bool(forKey: "PersonalInfoRegistration")
        
        let CarFlagRegistration =  UserDefaults.standard.bool(forKey: "CarFlagRegistration")
        
        
        //        let FlagRegistration =  UserDefaults.standard.string(forKey: "FlagRegistration")
        
        
        if Transporetr_Status_reg == true{
            self.window = UIWindow(frame: UIScreen.main.bounds)

            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterHomePage")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        else if CarFlagRegistration == true{
            //move to work
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreWorkCityInfo")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
            
            
            
        else if  PersonalFlagRegistration == true {
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreCarInfo")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
            
        else {
            
//
//            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterPersonalInfo")
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
            
            
            //personal
        }
        
        
        
        
        //
        //        else if PersonalFlagRegistration == true{
        //
        //            self.window = UIWindow(frame: UIScreen.main.bounds)
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreCarInfo")
        //            self.window?.rootViewController = initialViewController
        //            self.window?.makeKeyAndVisible()
        //
        //            UserDefaults.standard.set(false, forKey: "PersonalInfoRegistration")
        //
        //        }
        //
        //        else if CarFlagRegistration == true{
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreWorkCityInfo")
        //            self.window?.rootViewController = initialViewController
        //            self.window?.makeKeyAndVisible()
        //            UserDefaults.standard.set(false, forKey: "CarFlagRegistration")
        //       }
        //
        //        else{
        //        if FlagRegistration == "TransporterPersonalInfo"{
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterPersonalInfo")
        //            self.window?.rootViewController = initialViewController
        //            self.window?.makeKeyAndVisible()
        //
        //        }
        //
        //
        //        if FlagRegistration == "TransportreCarInfo"{
        //
        //            self.window = UIWindow(frame: UIScreen.main.bounds)
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreCarInfo")
        //            self.window?.rootViewController = initialViewController
        //            self.window?.makeKeyAndVisible()
        //        }
        //
        //        if FlagRegistration == "TransportreWorkCityInfo" || FlagRegistration == "TransportreWorkTimeInfo"{
        //
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransportreWorkCityInfo")
        //            self.window?.rootViewController = initialViewController
        //            self.window?.makeKeyAndVisible()
        //        }
        //
        //
        //        }
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        FirebaseApp.configure()
        
        
        return true
    }
    
    
    //////////////Transporter Location/////////
//    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // you're good to go!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last{

            let TransporterLat = location.coordinate.latitude
            let TransporterLong = location.coordinate.longitude

            print("TransporterLat\(TransporterLat)TransporterLong\(TransporterLong)")

            UserDefaults.standard.set(TransporterLat, forKey: "TransporterLat")
            UserDefaults.standard.set(TransporterLong, forKey: "TransporterLong")


//
            DispatchQueue.global(qos: .background).async {

             
                if UserDefaults.standard.string(forKey: "userID") != ""{

                    self.transporter.TransporterSetLocationCurrentOrders{

                        if AppDelegate.setLocationResult == "NoTripFount" || AppDelegate.setLocationResult == "Blocked" || AppDelegate.setLocationResult == "TokenError"{

                            AppDelegate.Transportlocation.stopUpdatingLocation()
                        }

                        else {

                            AppDelegate.Transportlocation.startUpdatingLocation()

                        }

                    }

                }

            }
        }

  }
    
    
    //////////////Transporter Location/////////
    
    
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
        print("Firebase registration token: \(fcmToken)")
        
    }
    
    
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        // Print full message.
        print("userInfo\(userInfo)")
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
                switch notificationSettings.authorizationStatus {
                case .notDetermined: break
                // Request Authorization
                case .authorized: break
                // Schedule Local Notification
                case .denied:
                    print("Application Not Allowed to Display Notifications")
                case .provisional:
                    print("Application Not Allowed to Display Notifications")
                    
                }
            }
        } else {
            
            // Fallback on earlier versions
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    // [END receive_message]
    // [START refresh_token]
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    // [START connect_to_fcm]
    func connectToFcm() {
        // Won't connect since there is no token
        guard InstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().shouldEstablishDirectChannel = false
        
        Messaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error?.localizedDescription ?? "")")
            } else {
                
                
                
                print("Connected to FCM.")
                //            self.setUpNotificationView()
                //            self.DisplayNotificationPopup()
            }
        }
    }
    // [END connect_to_fcm]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        InstanceID.instanceID().setAPNSToken(deviceToken, type: InstanceIDAPNSTokenType.sandbox)
        print("APNs token retrieved: \(deviceToken)")
        
        // RegistrationID.sharedInstance.reg_ID = deviceToken
        
        // With swizzling disabled you must set the APNs token here.
        // FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
    }
    
    // [START connect_on_active]
    func applicationDidBecomeActive(_ application: UIApplication) {
        connectToFcm()
    }
    // [END connect_on_active]
    // [START disconnect_from_fcm]
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        if  CurrentOrderViewController.Orders.count != 0{
            
            // print("ss")
        }
        
        
        Messaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    // [END disconnect_from_fcm]
}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print(notification.request.content.userInfo)
        
        if let aps = notification.request.content.userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                
                
                if let title = alert["title"] as? NSString {
                    if title == "New Order"{
                        AvailableOrderViewController.isPageRefreshing = false
                    }
                }
            }
        }
        completionHandler([.alert, .badge, .sound])
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let response = response.notification.request.content.userInfo
        
        print(response)
        
      
        for view in (self.window?.subviews)!{
            print(view.tag)
        }
        let Notification = NotificationManager()
        
        if let TypeIntent = response["TypeIntent"] as? NSString {
            Notification.title = TypeIntent as String
            AppDelegate.NotificationTitleType = Notification.title
           
            
        }
        
        if let IdOrder = response["IdOrder"] as? NSString {
            
            Notification.orderID = IdOrder as String
            
        }
       
        if let aps = response["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                
                
                if let title = alert["title"] as? NSString {
                    Notification.titleType = title as String
                }
                if let body = alert["body"] as? NSString {
                    
                    print(body)
                    //Do stuff
                }
            } else if let alert = aps["alert"] as? NSString {
                print(alert)
            }
        }
       // Notification.requestForNotification()
        //setUpNotificationView()
        DisplayNotificationPopup(titleType: Notification.titleType ,titel:  Notification.title, notificationText:  Notification.title, orderid: Int(Notification.orderID)!)
        completionHandler()
    }
    
    
//    // Add transperant background to the current screen when display notification
//    func setUpNotificationView() {
//        self.View.frame = CGRect(x: 0, y: 0, width: (self.window?.bounds.width)!, height: (self.window?.bounds.height)!)
//        self.View.backgroundColor = UIColor.black.withAlphaComponent(0.7)
//        self.View.tag = 51
//        self.window?.addSubview(self.View)
//    }
    //Display Notification PopUp
    func DisplayNotificationPopup(titleType: String , titel: String, notificationText: String, orderid: Int)  {
        
        self.View.frame = CGRect(x: 0, y: 0, width: (self.window?.bounds.width)!, height: (self.window?.bounds.height)!)
        self.View.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.View.tag = 51
        self.window?.addSubview(self.View)


        if let NotificationView = Bundle.main.loadNibNamed("NotificationView", owner: self, options: nil)?.first as? NotificationView {

            if AppDelegate.NotificationTitleType == "NewOrderDetails"{
                
                NotificationView.titel.text = "طلب جديد"
                 NotificationView.notificationText.text = "وصول طلب جديد"
            }
           else if AppDelegate.NotificationTitleType == "OrderCurrentDetails"{
                
                NotificationView.titel.text = "قبول طلب"
                NotificationView.notificationText.text = "قبول طلب"
            }
            else {
                NotificationView.titel.text = "حذف طلب"
                NotificationView.notificationText.text = titel
            }

            NotificationView.center = (self.window?.center)!
           
            NotificationView.tag = 50
             NotificationView.showNotificationButton.tag = orderid
            NotificationView.cancelBtn.addTarget(self, action: #selector(self.handleCancelBtn(sneder:)), for: .touchUpInside)
            NotificationView.showNotificationButton.addTarget(self, action: #selector(self.handleshowNotificationBtn(sneder:)), for: .touchUpInside)
            self.window?.addSubview(NotificationView)

        }
    }
    //Cancel notification
    func handleCancelBtn(sneder: UIButton){
        
        for view in (self.window?.subviews)!{
             print(view.tag)
            if view.tag == 50 || view.tag == 51{
                view.removeFromSuperview()
            }
        }
        
//        if let viewWithTag = self.window?.viewWithTag(50) {
//            viewWithTag.removeFromSuperview()
//        }
//
//        if let viewWithTag = self.window?.viewWithTag(51) {
//            viewWithTag.removeFromSuperview()
//        }
        
    }
    
    //show notification
    func handleshowNotificationBtn(sneder: UIButton){
        
        
        for view in (self.window?.subviews)!{
            print(view.tag)
            if view.tag == 50 || view.tag == 51{
                view.removeFromSuperview()
            }
        }

        if AppDelegate.NotificationTitleType == "NewOrderDetails"{
            
            OrderDetailsViewController.OrderID = "\(sneder.tag)"
            OrderDetailsViewController.pushType = "1"
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "AvailableOrderDetail")
           self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
        if AppDelegate.NotificationTitleType == "OrderCurrentDetails"{
            
            OrderDetailViewController.OrderID = "\(sneder.tag)"
            OrderDetailsViewController.pushType = "2"
            AppDelegate.Transportlocation.startUpdatingLocation()
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailCurrent")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
        
        if AppDelegate.NotificationTitleType == "ClientDeleteOrder"{
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterHomePage")
           self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
        }
    }
    
}


// [END ios_10_message_handling]
// [START ios_10_data_message_handling]
extension AppDelegate : MessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    @objc(applicationReceivedRemoteMessage:) func application(received remoteMessage: MessagingRemoteMessage) {
        
        print(remoteMessage.appData)
        
    }
    
}



class NotificationManager{
    
    static let shared = NotificationManager()
    var orderID: String = ""
    var title: String = ""
    var titleType: String = ""
    init(){}
    
    func requestForNotification(){
        
        print(title)
        if title == "NewOrderDetails"{
            print(title)
            OrderDetailsViewController.OrderID = orderID
            
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "AvailableOrderDetail")
            UIApplication.shared.windows.first?.rootViewController = initialViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
        if title == "OrderCurrentDetails"{
            
            OrderDetailViewController.OrderID = orderID
            
            AppDelegate.Transportlocation.startUpdatingLocation()
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "OrderDetailCurrent")
            UIApplication.shared.windows.first?.rootViewController = initialViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
        
        if title == "ClientDeleteOrder"{
            
            let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterHomePage")
            UIApplication.shared.windows.first?.rootViewController = initialViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
        }
        
    }
    
    
   
    
}


