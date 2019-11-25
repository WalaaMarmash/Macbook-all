//
//  TabBarControllerViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/16/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class TabBarControllerViewController: UITabBarController {
    // Internet Connection
    let reachability = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                // self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
                //
            }
            
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NetworkUnavailable"{
            
            _ = segue.destination as?
            OfflineViewController
        }
        
        
        
    }
}
