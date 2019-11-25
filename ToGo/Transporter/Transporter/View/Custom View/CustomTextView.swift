//
//  CustomTextView.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/29/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class CustomTextView: UITextView{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
    }
}
