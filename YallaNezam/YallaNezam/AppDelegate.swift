//
//  AppDelegate.swift
//  YallaNezam
//
//  Created by fratello software house on 12/2/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

        window = UIWindow(frame: UIScreen.main.bounds)

        
        if UserDefaults.standard.bool(forKey: "IsLogged") == true && (UserDefaults.standard.string(forKey: "id") != "" || UserDefaults.standard.string(forKey: "id") != nil){
            let myViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: myViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        
        else {
        
        let myViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: myViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        }


        let navigationBarAppearace = UINavigationBar.appearance()

        navigationBarAppearace.tintColor = UIColor(hex: 0xffffff)
        navigationBarAppearace.barTintColor = UIColor(hex : 0x00B23D)
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white , NSAttributedString.Key.font: UIFont(name: "NeoSansArabic", size: 17)!]
        

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension UIColor {
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}
