//
//  MenuCellTableViewCell.swift
//  Transporter
//
//  Created by Fratello Software Group on 11/6/18.
//  Copyright © 2018 yara. All rights reserved.
//


import UIKit

class MenuCellTableViewCell: UITableViewCell {
    
    //Menu Outles
    @IBOutlet weak var menuText: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

