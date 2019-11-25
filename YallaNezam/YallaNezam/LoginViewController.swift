//
//  LoginViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/2/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        mobileTextField.delegate = self
       // passTextField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(sender:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(sender:)), name:UIResponder.keyboardWillHideNotification, object: nil);

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }

    @IBAction func forgetPassBtn(_ sender: Any) {
        let vc = ForgetPasswordViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        
        let vc = ConfirmViewController()
        self.navigationController?.pushViewController(vc, animated: false)
        
        var final = mobileTextField.text!
        if (mobileTextField.text?.count)! > 0 {
            let NumberStr: String = mobileTextField.text!
            let Formatter: NumberFormatter = NumberFormatter()
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
            final = String(describing: Formatter.number(from: NumberStr)!)
            final.insert("0", at: final.startIndex)
        }
        
        if mobileTextField.text! == "" {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال رقم الهاتف المحمول", subTitle: "" , alertType: .failure)
        }
//        else if passTextField.text! == "" {
//             YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة المرور", subTitle: "" , alertType: .failure)
//        }
//        else if mobileTextField.text! == "" && passTextField.text! == "" {
//            YSLNoticeAlert().showAlert(title: "يرجى تعبئة كافة البيانات" , subTitle: "" , alertType: .failure)
//        }
        
        else {
        
        if reachability.isReachable{
            
            Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"Login","MobileNumber":mobileTextField.text!,"Password":""], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                response in
                print(response)
                
                if response.result.value == "BlockedUser" {
                   YSLNoticeAlert().showAlert(title: "المستخدم محظور", subTitle: "", alertType: .failure)
                }
                else if response.result.value == "AccountNotVerified" {
                    let vc = ConfirmViewController()
                    vc.mobileNum = self.mobileTextField.text!
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if response.result.value == "CustomerNotExists" {
                    YSLNoticeAlert().showAlert(title: "يرجى التأكد من البيانات المدخلة", subTitle: "", alertType: .success)
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
            }
        }
        else{
            YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
        
    }
        
        
      //  let vc = CameraViewController()
     //   navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: false)
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
