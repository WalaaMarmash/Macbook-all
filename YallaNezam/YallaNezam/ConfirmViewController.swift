//
//  ConfirmViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/11/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConfirmViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var firstTextField: UITextField!
    
    @IBOutlet weak var secondTextfield: UITextField!
    
    @IBOutlet weak var thirdTextfield: UITextField!
    
    
    @IBOutlet weak var fourthTextfield: UITextField!
    
    @IBOutlet weak var mobileNumLabel: UILabel!
    
    
    var mobileNum = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "تفعيل الرمز"
        
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
//        button.addTarget(self, action:#selector(ConfirmViewController.tappedFunc), for:.touchUpInside)
//        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
//        let barButton = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton

        firstTextField.delegate = self
        secondTextfield.delegate = self
        thirdTextfield.delegate =  self
        fourthTextfield.delegate = self
    
        firstTextField.becomeFirstResponder()
        
        mobileNumLabel.text = mobileNum
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendCodeBtn(_ sender: Any) {
        
        let vc = CameraViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
        let code = firstTextField.text! + secondTextfield.text! +  thirdTextfield.text! + fourthTextfield.text!
        if code == ""  {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال الرمز", subTitle: "", alertType: .failure)
        }
        else {
        if reachability.isReachable{
        Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"ConfirmCode","MobileNumber":mobileNum, "CodeVerify":code], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
            
            response in
            print(response)
            
            if response.result.value == "NotConfirmData"{
                print("code \(code)")
              YSLNoticeAlert().showAlert(title: "رمز التفعيل غير صحيح", subTitle: "", alertType: .failure)
            }
            else {
                if let data = response.data {
                    let json = JSON(data)
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
        }
        }
        else{
            YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
        }
    }
   
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !(string == "") && textField.tag != 5{
            textField.text = string
            if textField == firstTextField {
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

//    @objc func tappedFunc() {
//        //do stuff here
//        print("tapped icon")
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
