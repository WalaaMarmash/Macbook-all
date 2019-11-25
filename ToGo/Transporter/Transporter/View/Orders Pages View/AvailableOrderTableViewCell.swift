//
//  AvailableOrderTableViewCell.swift
//  ToGo
//
//  Created by Fratello Software Group on 6/20/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

// Transporter Available Order Table Cell
class AvailableOrderTableViewCell: UITableViewCell {
    
    @IBOutlet var uiStack: [UIStackView]!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var delivaryWay: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var fromPlace: UILabel!
    @IBOutlet weak var toPlace: UILabel!
    @IBOutlet weak var submitOfferCostBtn: GradientButton!
    @IBOutlet weak var cancelBtn: GradientButton!
    
    @IBOutlet weak var orderDetailBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setUpOrintation()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func submitOfferCostBtnPressed(_ sender: Any) {
    }
    
    
    
    
    
    func setUpOrintation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            
            for item in uiStack{
                item.semanticContentAttribute = .forceLeftToRight
            }
            
            
        }else{
            for item in uiStack{
                item.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
}
