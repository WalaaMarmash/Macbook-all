//
//  OfflineViewController.swift
//  reachability-playground
//
//  Created by Neo Ighodaro on 28/10/2017.
//  Copyright © 2017 CreativityKills Co. All rights reserved.
//

import UIKit
import ReachabilitySwift

class OfflineViewController: UIViewController {
    
    // Internet Connection
    let reachability = Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()

        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                 self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
              
            }
            
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
//    private func showMainController() -> Void {
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "MainController", sender: self)
//        }
//    }
}
