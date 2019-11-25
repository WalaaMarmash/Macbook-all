//
//  NewPassViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/30/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class NewPassViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var newPassTextField: UITextField!
    
    @IBOutlet weak var reNewPassTextfield: UITextField!
    
    
    @IBOutlet weak var firstTextfiled: UITextField!
    
    @IBOutlet weak var secondTextfield: UITextField!
    
    @IBOutlet weak var thirdTextfield: UITextField!
    
    @IBOutlet weak var fourthTextfield: UITextField!
    
    var mobileNum = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "استعادة كلمة المرور"
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        firstTextfiled.delegate = self
        secondTextfield.delegate = self
        thirdTextfield.delegate =  self
        fourthTextfield.delegate = self
        
        firstTextfiled.becomeFirstResponder()
        
        numLabel.text = mobileNum
        // Do any additional setup after loading the view.
    }

    
    @IBAction func resetPassBtn(_ sender: Any) {
        
        let code = firstTextfiled.text! + secondTextfield.text! +  thirdTextfield.text! + fourthTextfield.text!
        if code == ""  {
         YSLNoticeAlert().showAlert(title: "يرجى ادخال الرمز", subTitle: "", alertType: .failure)
        }
        else if newPassTextField.text != reNewPassTextfield.text {
           YSLNoticeAlert().showAlert(title: "كلمة المرور غير متطابقة", subTitle: "", alertType: .failure)
        }
        else if newPassTextField.text == "" || reNewPassTextfield.text == "" {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة المرور", subTitle: "", alertType: .failure)
        }
        else if (newPassTextField.text?.count)! < 8 {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة مرور لا تقل عن ٨ خانات", subTitle: "", alertType: .failure)
        }
            
        else {
        if reachability.isReachable{
            
            Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"ForgetPasswordConfirm","MobileNumber":mobileNum,"Code":code,"NewPassword":newPassTextField.text!.sha1()], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                response in
                print(response)
                
                if response.result.value == "WrongCode" {
                    YSLNoticeAlert().showAlert(title: "الرمز غير", subTitle: "", alertType: .failure)
                }
                else {
                    if let data = response.data {
                        let json = JSON(data)
                        print(json)
                        if let id = json[0]["id"].string {
                            print("User id =  \(id)")
                            UserDefaults.standard.set(id, forKey: "id")
                        }
                        if let mobilePhone = json[0]["MobilePhone"].string {
                            print("User MobilePhone =  \(mobilePhone)")
                            UserDefaults.standard.set(mobilePhone, forKey: "MobilePhone")
                        }
                        if let fullName = json[0]["FullName"].string {
                            print("User FullName =  \(fullName)")
                            UserDefaults.standard.set(fullName, forKey: "FullName")
                        }
                        if let isVeify = json[0]["IsVeify"].string {
                            print("isVeify =  \(isVeify)")
                            UserDefaults.standard.set(isVeify, forKey: "IsVeify")
                        }
                        if let email = json[0]["Email"].string {
                            print("email =  \(email)")
                            UserDefaults.standard.set(email, forKey: "Email")
                        }
                        if let telephone = json[0]["Telephone"].string {
                            print("telephone =  \(telephone)")
                            UserDefaults.standard.set(telephone, forKey: "Telephone")
                        }
                        if let cityName = json[0]["CityName"].string {
                            print("cityName =  \(cityName)")
                            UserDefaults.standard.set(cityName, forKey: "CityName")
                        }
                        UserDefaults.standard.set(true, forKey: "IsLogged")
                        let vc = CameraViewController()
                        self.navigationController?.pushViewController(vc, animated: false)
                    }
                }
                
            }//alamofire
        }//reachability
        
        else {
            YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
    }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !(string == "") && textField.tag != 5{
            textField.text = string
            if textField == firstTextfiled {
                secondTextfield.becomeFirstResponder()
            }
            else if textField == secondTextfield {
                thirdTextfield.becomeFirstResponder()
            }
            else if textField == thirdTextfield {
                fourthTextfield.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            return false
        }
        return true
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
