//
//  ordersTableViewCell.swift
//  ToGo
//
//  Created by Fratello Software Group on 6/20/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class ordersTableViewCell: UITableViewCell {

    @IBOutlet var uiStack: [UIStackView]!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // setUpOrintation()
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
