//
//  PaymentDetailViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/17/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class PaymentDetailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var numberCardTextField: CustomTextField!
    @IBOutlet weak var dayTextField: CustomTextField!
    @IBOutlet weak var yearTextField: CustomTextField!
    @IBOutlet weak var monthTextField: CustomTextField!
    @IBOutlet weak var PasswordCodeTextField: CustomTextField!

    
    
    @IBOutlet var uiLable: [UILabel]!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
      //  SetUpOriantation()
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    

    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textField//
    

    
    func SetUpOriantation()  {
        
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            for item in uiLable{
                item.semanticContentAttribute = .forceRightToLeft
                item.textAlignment = .right
            }
            numberCardTextField.semanticContentAttribute = .forceRightToLeft
            numberCardTextField.textAlignment = .right
            PasswordCodeTextField.semanticContentAttribute = .forceRightToLeft
            PasswordCodeTextField.textAlignment = .right
            
            
        }else{
            for item in uiLable{
                item.semanticContentAttribute = .forceLeftToRight
                item.textAlignment = .left
            }
            numberCardTextField.semanticContentAttribute = .forceLeftToRight
            numberCardTextField.textAlignment = .left
            PasswordCodeTextField.semanticContentAttribute = .forceLeftToRight
            PasswordCodeTextField.textAlignment = .left
            
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
