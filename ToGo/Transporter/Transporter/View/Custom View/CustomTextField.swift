//
//  CustomTextField.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
@IBDesignable
class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);

   
    @IBInspectable var rightview: UIImage?{
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        didSet{
            updateView()
        }
    }
    
    
    @IBInspectable var lefttview: UIImage?{
        didSet{
            updateleftView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet{
            updateleftView()
        }
    }
    
    
    func updateView(){
        if let image =  rightview{
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 5, y: 0, width:  15, height: 20))
            imageView.image = image
            
            let width = rightPadding + 40
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            rightView = view
        }
        else{
            rightViewMode = .never
        }
        
    }
    func updateleftView(){
        
        if let image =  lefttview{
            leftViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: 5 , y: 5, width:  20, height: 15))
            imageView.image = image
            
            let width = leftPadding + 40
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            leftView = view
        }
        else{
            leftViewMode = .never
        }
        
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 35, 0, 35))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(0, 25, 0, 25))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        self.returnKeyType = .done
        
        
    }
    
}




