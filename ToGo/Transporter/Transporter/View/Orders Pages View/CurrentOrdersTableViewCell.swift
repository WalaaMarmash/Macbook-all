//
//  CurrentOrdersTableViewCell.swift
//  TOGOClient
//
//  Created by Fratello Software Group on 9/23/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class CurrentOrdersTableViewCell: UITableViewCell {
    @IBOutlet var uiStack: [UIStackView]!
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var delivaryWay: UILabel!
    @IBOutlet weak var OrderNumber: UILabel!
    @IBOutlet weak var orderDetails: UIButton!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setUpOrintation()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
