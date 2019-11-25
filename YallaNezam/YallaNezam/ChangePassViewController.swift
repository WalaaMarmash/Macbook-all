//
//  ChangePassViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/16/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePassViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var oldPassTextfield: UITextField!
    @IBOutlet weak var newPassTextfield: UITextField!
    @IBOutlet weak var reNewPassTextfield: UITextField!
    
    var testVC = MenuViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "تغيير كلمة المرور"
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(ChangePassViewController.tappedFunc), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        newPassTextfield.delegate = self
        oldPassTextfield.delegate = self
        reNewPassTextfield.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePassViewController.keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePassViewController.keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil);

        // Do any additional setup after loading the view.
    }

    @objc func tappedFunc() {
        
        if(testVC.flagmenue == false)
        {
            
            self.testVC.view.frame = CGRect(x: 0, y: 0, width: 420, height: 850)
           // self.testVC.changePassBtn.addTarget(self, action: #selector(ChangePassViewController.moveFunc), for: .touchUpInside)
            self.testVC.settingBtn.addTarget(self, action: #selector(ChangePassViewController.moveSettingFunc), for: .touchUpInside)
            
            self.testVC.view.isHidden = false;
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
        testVC.flagmenue = false
        self.testVC.view.isHidden = true
    }
    @objc func  moveSettingFunc() {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

    
    @IBAction func changePassBtn(_ sender: Any) {
      
        if newPassTextfield.text == "" || reNewPassTextfield.text == "" || oldPassTextfield.text == "" {
            YSLNoticeAlert().showAlert(title: "يرجى تعبئة كافة البيانات", subTitle: "" , alertType: .failure)
        }
        else if newPassTextfield.text != reNewPassTextfield.text {
            YSLNoticeAlert().showAlert(title: "كلمة المرور غير متطابقة", subTitle: "" , alertType: .failure)
        }
        else if (newPassTextfield.text?.count)! < 8 {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة مرور لا تقل عن ٨ خانات", subTitle: "", alertType: .failure)
        }
        else{
            if reachability.isReachable{
                
                Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"ChangePasswordProfile","CustomerId":UserDefaults.standard.string(forKey: "id")!,"OldPassword":oldPassTextfield.text!.sha1(),"NewPassword":newPassTextfield.text!.sha1()], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                    response in
                    print(response)
                    
                     if response.result.value == "ErrorParameter" {
                    YSLNoticeAlert().showAlert(title: "حدث خلل يرجى المحاولة مرة اخرى", subTitle: "", alertType: .failure)
                    }
                    else if response.result.value == "PasswordChanged" {
//                        self.oldPassTextfield.isEnabled = false
//                        self.newPassTextfield.isEnabled = false
//                        self.reNewPassTextfield.isEnabled = false
                        
                        YSLNoticeAlert().showAlert(title: "تم تغيير كلمة المرور بنجاح", subTitle: "", alertType: .success)
                        self.navigationController?.popViewController(animated: false)
                    }
                    else if response.result.value == "PasswordNotChanged" {
                        YSLNoticeAlert().showAlert(title: "لم يتم تغيير كلمة المرور", subTitle: "", alertType: .failure)
                    }
                     else if response.result.value == "PasswordWrong" {
                        YSLNoticeAlert().showAlert(title: "كلمة المرور خاطئة", subTitle: "", alertType: .failure)
                    }
                    
                    
                } //alamofire
            }//reachability
            else {
                YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
            }
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        testVC.flagmenue = false
        self.testVC.view.isHidden = true
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        print("showwwwww")
        self.view.frame.origin.y = -150 // Move view 150 points upward
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
