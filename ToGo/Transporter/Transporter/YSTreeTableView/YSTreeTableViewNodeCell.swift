//
//  YSTreeTableViewCell.swift
//  YSTreeTableView
//
//  Created by yaoshuai on 2017/1/10.
//  Copyright © 2017年 ys. All rights reserved.
//

import UIKit

/// Cell
class YSTreeTableViewNodeCell: MenuCellTableViewCell {
    
    // Language
    // let lan: String = UserDefaults.standard.string(forKey: "Language")!
    
    //    // Selected Menu Images
    //    var SelectedImages = [UIImage(named: "Home-fill"),UIImage(named: "Video-fill"),UIImage(named: "Picture-fill"),
    //                          UIImage(named: "Compass-fill"),UIImage(named: "Reading-fill"),UIImage(named: "About-fill"),UIImage(named: "sms")]
    // Menu Images
    var Images = [UIImage(named: "To Go picture-24"),UIImage(named: "To Go picture-26"),UIImage(named: "To Go picture-27"),
                  UIImage(named: "To Go picture-39")]
    
    var node:YSTreeTableViewNode?{
        
        didSet{
            
            indentationLevel = node?.depth ?? 0
            indentationWidth = 10
            
            if UIDevice.current.userInterfaceIdiom == .pad{
                
                
                
                textLabel?.semanticContentAttribute = .forceRightToLeft
                textLabel?.textAlignment = .right
                textLabel?.font = UIFont(name: "NeoSansArabic", size: 17)
                
            }
            else{
                
                
                textLabel?.font = UIFont(name: "NeoSansArabic", size: 17)
                textLabel?.semanticContentAttribute = .forceRightToLeft
                textLabel?.textAlignment = .right
                
                
                
            }
            
            
            textLabel?.text = node?.nodeName
            
            imageView?.frame = CGRect(x: 0,y: 0,width: 5,height: 5)
            imageView?.contentMode = .scaleToFill
            imageView?.image = UIImage(named: (node?.rightImageName)!)
            
            
            
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    
    // selected menu item
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
        if (selected){
            
           // textLabel?.textColor = UIColor(netHex: 0xD93557)
            
            
            if node?.nodeID == 1{
                //imageView?.image = SelectedImages[1]
                
                
            }
            else if node?.nodeID == 11{
                // imageView?.image = SelectedImages[2]
               // textLabel?.textColor = UIColor(netHex: 0xD93557)
                
            }
            else if node?.nodeID == 12{
                // imageView?.image = SelectedImages[3]
                //textLabel?.textColor = UIColor(netHex: 0xD93557)
                
            }
            else if node?.nodeID == 12{
                // imageView?.image = SelectedImages[4]
               // textLabel?.textColor = UIColor(netHex: 0xD93557)
                
            }
            
            
        }
            
        else{
            if node?.nodeID == 1{
                textLabel?.textColor = UIColor.black
                imageView?.image = Images[0]
                //self.layer.backgroundColor =  UIColor(red: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: 0.5).cgColor
                // self.backgroundColor = UIColor(netHex: 0x9B9B9B).withAlphaComponent(0.5)
            }
            
            if node?.nodeID == 2{
                textLabel?.textColor = UIColor.black
                imageView?.image = Images[1]
            }
            else if node?.nodeID == 3{
                textLabel?.textColor = UIColor.black
                imageView?.image = Images[2]
            }
            else if node?.nodeID == 4{
                textLabel?.textColor = UIColor.black
                imageView?.image = Images[3]
            }
            else if node?.nodeID == 11{
                //textLabel?.font = UIFont(name: "NeoSansArabic-Bold", size: 15)
               
            }
            else if node?.nodeID == 12{
                //textLabel?.font = UIFont(name: "NeoSansArabic-Bold", size: 15)
                
            }
            else if node?.nodeID == 13{
               // textLabel?.font = UIFont(name: "NeoSansArabic-Bold", size: 15)
                
            }
            else if node?.nodeID == 14{
               // textLabel?.font = UIFont(name: "NeoSansArabic-Bold", size: 15)
                
            }
            
            
        }
    }
}
