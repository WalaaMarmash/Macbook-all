//
//  SettingsViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/23/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController , UITextFieldDelegate {

    var testVC = MenuViewController()
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var landPhoneTextfield: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "تفاصيل الحساب"
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(SettingsViewController.tappedFunc), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        // Do any additional setup after loading the view.
        
        landPhoneTextfield.delegate = self
        //emailTextfield.delegate = self
        
        
       // emailTextfield.text = UserDefaults.standard.string(forKey: "Email") ?? ""
        nameTextField.text = UserDefaults.standard.string(forKey: "FullName") ?? ""
        landPhoneTextfield.text = UserDefaults.standard.string(forKey: "Telephone") ?? ""
        if UserDefaults.standard.string(forKey: "Telephone") == "" {
            landPhoneTextfield.text = "لا يوجد"
        }
        mobileTextField.text = UserDefaults.standard.string(forKey: "MobilePhone") ?? ""
        cityTextField.text = UserDefaults.standard.string(forKey: "CityName") ?? ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil);
    }

    
    @objc func tappedFunc() {
        
        if(testVC.flagmenue == false)
        {
            
            self.testVC.view.frame = CGRect(x: 0, y: 0, width: 420, height: 850)
           // self.testVC.changePassBtn.addTarget(self, action: #selector(SettingsViewController.moveFunc), for: .touchUpInside)
            self.testVC.settingBtn.addTarget(self, action: #selector(SettingsViewController.moveSettingFunc), for: .touchUpInside)
            self.testVC.logoutBtn.addTarget(self, action: #selector(SettingsViewController.moveFunc), for: .touchUpInside)
            self.testVC.shareBtn.addTarget(self, action: #selector(SettingsViewController.shareFunc), for: .touchUpInside)
            
            self.testVC.view.isHidden = false
            self.view.addSubview(testVC.view)
            
            testVC.flagmenue = true
        }
        else
        {
            testVC.flagmenue = false
            self.testVC.view.isHidden = true
        }
        
    }
    @objc func  moveFunc() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @objc func  moveSettingFunc() {
        testVC.flagmenue = false
        self.testVC.view.isHidden = true
    }

    @objc func  shareFunc() {
           
            //if let name = NSURL(string: "https://itunes.apple.com/us/app/myapp/id1274063330?ls=1&mt=8") {
            if let name = NSURL(string: "") {
                let objectsToShare = [name]
                //            let text = "http://google.com"
                let shareViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
                if let popoverPresentationController = shareViewController.popoverPresentationController {
                    popoverPresentationController.sourceView = self.view
                    popoverPresentationController.sourceRect = CGRect(x: self.view.frame.width/2, y: 0, width: 0, height: 0)
                }
                
                self.present(shareViewController, animated: true, completion: nil)
                
                
            }
          
    }
 
    override func viewWillAppear(_ animated: Bool) {
        testVC.flagmenue = false
        self.testVC.view.isHidden = true
    }
    
    
 
    @objc func keyboardWillShow(sender: NSNotification) {
        print("showwwwww")
        self.view.frame.origin.y = -80 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        print("hiiiide")
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    //func to hide keyboard when touch outside the textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
