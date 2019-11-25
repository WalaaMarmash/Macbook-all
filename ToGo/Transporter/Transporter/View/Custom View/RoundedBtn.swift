//
//  RoundedBtn.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
let SHADOW_GRAY: CGFloat = 120.0 / 255.0

class RoundedBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
       // layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: SHADOW_GRAY).cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 6.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 10
        
        
    }
}
