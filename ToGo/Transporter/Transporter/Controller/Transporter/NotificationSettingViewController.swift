//
//  NotificationSettingViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/21/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit


class NotificationSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // tick
        let tickBox = Checkbox(frame: CGRect(x: 30, y: 160, width: 25, height: 25))
        tickBox.borderStyle = .square
        tickBox.checkmarkStyle = .tick
        tickBox.checkmarkSize = 0.7
        view.addSubview(tickBox)
        // tick
        let tickBox2 = Checkbox(frame: CGRect(x: 30, y: 180, width: 25, height: 25))
        tickBox2.borderStyle = .square
        tickBox2.checkmarkStyle = .tick
        tickBox2.checkmarkSize = 0.7
        view.addSubview(tickBox2)
        // tick
        let tickBox3 = Checkbox(frame: CGRect(x: 30, y: 200, width: 25, height: 25))
        tickBox3.borderStyle = .square
        tickBox3.checkmarkStyle = .tick
        tickBox3.checkmarkSize = 0.7
        view.addSubview(tickBox3)
        
        tickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)

    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
    }
    
   
}
