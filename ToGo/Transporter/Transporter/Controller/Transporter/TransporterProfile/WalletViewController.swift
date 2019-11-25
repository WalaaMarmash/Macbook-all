//
//  WalletViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/21/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    
    
    @IBOutlet weak var balanceCount: UILabel!
    
    var transporterLoader = TransporterLoader()
    static var BalanceResult = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
       
        
    }

  
    override func viewWillAppear(_ animated: Bool) {
        transporterLoader.GetBalanceTransporter {
            self.balanceCount.text = WalletViewController.BalanceResult + "شيكل"
        }
    }

}
