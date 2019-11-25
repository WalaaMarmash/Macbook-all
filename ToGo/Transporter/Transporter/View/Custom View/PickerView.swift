//
//  PickerView.swift
//  Transporter
//
//  Created by Fratello Software Group on 10/21/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
@IBDesignable
class PickerView: UIPickerView {

    override func awakeFromNib() {
    
//    self.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
//    self.layer.borderWidth = 0.8
    //self.layer.cornerRadius = 15
//    self.layer.shadowColor = UIColor.black.cgColor
//    self.layer.shadowOpacity = 5
//    self.layer.shadowOffset = CGSize.zero
//    self.layer.shadowRadius = 10

        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 2.7
        self.layer.shadowOpacity = 0.6
        

   
    }
}
