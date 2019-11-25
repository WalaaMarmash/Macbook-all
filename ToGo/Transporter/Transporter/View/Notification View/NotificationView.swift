//
//  NotificationView.swift
//  صفا
//
//  Created by me on 12/13/17.
//  Copyright © 2017 universe. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    @IBOutlet weak var notificationText: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var titel: UILabel!
    @IBOutlet weak var showNotificationButton: UIButton!
    
    //   @IBOutlet weak var clickBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//
        //self.showNotificationButton.layer.borderWidth = 1.0
       // self.showNotificationButton.layer.cornerRadius = 15
       //  self.showNotificationButton.layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = UIColor(netHex: 0x52A9B4).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 25.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        clipsToBounds = true
    }
}
