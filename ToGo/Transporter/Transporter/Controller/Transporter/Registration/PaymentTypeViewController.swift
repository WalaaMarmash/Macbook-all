//
//  PaymentTypeViewController.swift
//  Transporter
//
//  Created by Fratello Software Group on 1/21/19.
//  Copyright © 2019 yara. All rights reserved.
//

import UIKit

class PaymentTypeViewController: UIViewController {
    
    
    @IBOutlet weak var uiStack: UIStackView!
    @IBOutlet var RoundedBtn: [RoundedBtn]!
    @IBOutlet weak var uiLable: UILabel!
    @IBOutlet weak var otherCreditCard: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // SetUpOriantation()
        SetupBtn()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ChoosePaymentType(_ sender: UIButton) {
        
        
        for item in RoundedBtn{
            
            if item.tag != sender.tag{
                item.backgroundColor = UIColor.clear
            }
        }
        
        if sender.backgroundColor == UIColor(netHex: 0x29A89A){
            sender.backgroundColor = UIColor.clear
        }else{
            sender.backgroundColor = UIColor(netHex: 0x29A89A)
        }
        
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            if otherCreditCard.isHidden == true{
                otherCreditCard.isHidden = false
            }else{
                otherCreditCard.isHidden = true
            }
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
        
        
    }
    
    
    
    
    // called when back btn pressed
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Configure ui Oriantation
    func SetUpOriantation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            uiStack.semanticContentAttribute = .forceRightToLeft
            uiLable.semanticContentAttribute = .forceRightToLeft
            uiLable.textAlignment = .right
            
        }else{
            uiStack.semanticContentAttribute = .forceLeftToRight
            uiLable.semanticContentAttribute = .forceLeftToRight
            uiLable.textAlignment = .left
        }
    }
    
    func SetupBtn()  {
        
        for item in RoundedBtn{
            item.layer.borderWidth = 1
            item.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        }
    }
    
    
}
