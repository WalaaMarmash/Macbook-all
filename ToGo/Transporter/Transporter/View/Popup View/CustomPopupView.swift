//
//  CustomPopupView.swift
//  ToGo
//
//  Created by Fratello Software Group on 7/12/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class CustomPopupView: UIView {

    @IBOutlet weak var saveBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
import UIKit

class CustomPickerView: UIPickerView {
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
