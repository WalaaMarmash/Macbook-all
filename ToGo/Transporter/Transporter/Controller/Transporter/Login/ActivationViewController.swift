//
//  ActivationViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import SACodedTextField
import KOPinCodeView



class ActivationViewController: UIViewController,KOPinCodeViewDelegate {
    
    
    @IBOutlet weak var pinCodeView: KOPinCodeView!
    @IBOutlet weak var msglable: UILabel!
    static var  Usertype: Int = 1
    // outlets
    // @IBOutlet weak var codeTextField: ActivationCodeTextField!
    //Loader
    var verifiedAcountLoader = VerifiedAcountLoader()
    //device Token
    
    var textField: ActivationCodeTextField!
    
    @IBOutlet weak var CodeView: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        pinCodeView.delegate = self
        pinCodeView.initPin(withCount: 4)
        
        pinCodeView.initPinView(withConfirmPIN: false, countSymbol: 4, sizeSimbol: CGSize(width: 45, height: 45), formView: kCircle)
        
        //thickness view line
        pinCodeView.lineDeep = 2.0
        //Color view line
        pinCodeView.lineColor = UIColor.red
        //Background color view in select state
        //  pinCodeView.selectColor = [].withAlphaComponent(0.5)
        
        //Text color UITextField
        pinCodeView.symbolColor =  UIColor.red
        //Font UITextField
        pinCodeView.symbolFont = UIFont.systemFont(ofSize: 14)
        
        //UILabel show only initPinViewWithConfirmPIN:
        //Text color Label
        // pinCodeView.titleColor = []
        //Font Label
        pinCodeView.titleFont = UIFont.systemFont(ofSize: 14)
        //Text Label - Default: "enter Pin code"
        // pinCodeView.enterPinString = "Any text 1"
        //Text Label - Default: "Confirm Pin code"
        // pinCodeView.confirmPinString = "Any text 2"
        
        //Create Confirm Pin Code
        // pinCodeView.confirm = false
        //Secure Text - Default: YES
        pinCodeView.secure = false
        //Keyboard Type
        pinCodeView.typeKeyboard = UIKeyboardType.numberPad
        
        
        updateUI()
        
        let DeviceTokenStatus = UserDefaults.standard.bool(forKey: "deviceTokenStatus")
        
        if DeviceTokenStatus == false{
            
            let token = genarateDeviceToken()
            UserDefaults.standard.set(true, forKey: "deviceTokenStatus")
            UserDefaults.standard.set(token, forKey: "deviceToken")
        }
        ////        //setup codeTextField ui
        //        codeTextField.layer.borderWidth = 0
        //        codeTextField.maxCodeLength = 4
        //        codeTextField.customPlaceholder =  "-";
        //
        //        codeTextField.frame = CGRect(x: 0, y: 0, width: Int(codeTextField.minWidthTextField()), height: Int(codeTextField.bounds.height))
        //        codeTextField.activationCodeTFDelegate = self
        
        
    }
    func pinDidEnterAllSymbol(_ symbolArray: [Any]!, string pin: String!) {
        
        VerifiedAcountLoader.VerifiedCode = pin
        print(pin)
    }
    
    func updateUI() {
        
        let  phone_number =   LoginLoader.phoneNumber
        print(phone_number.dropLast())
        print(LoginLoader.phoneNumber)
        msglable.text = "يرجي ادخال رمز التفعيل الذي سيتم ارساله الي رقم هاتفك المحمول " + "\(phone_number.dropFirst())+"
        
    }
    
    //    func fillingComplete(for textField: ActivationCodeTextField) {
    //
    //         print("fill")
    //         view.endEditing(true)
    //     }
    //
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    // called after user select transporter or client
    @IBAction func submitBtnClicked(_ sender: Any) {
        
        
        let currentDateTime = Date().timeIntervalSinceReferenceDate
        print(String(currentDateTime))
        let hash = SHA1.hexString(from: String(currentDateTime))
        print(hash!)
        
        
        
        if VerifiedAcountLoader.VerifiedCode == ""{
            let alert = UIAlertController(title: "", message: "عدد الخانات المدخلة غير صحيحة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }else{
            
            VerifiedAcountLoader.VerifiedCode = ArToEnStingConverter()
            
            
            let sv = UIViewController.displaySpinner(onView: self.view)
            verifiedAcountLoader.VerifiedAcount {
                
                if VerifiedAcountLoader.VerifiedReult == "Wrong_Code" || VerifiedAcountLoader.VerifiedReult == "ParameterError"{
                    
                    let alert = UIAlertController(title: "", message: VerifiedAcountLoader.VerifiedReult, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }else{
                    
                    let regstrationStatus = UserDefaults.standard.string(forKey: "FlagRegistration")
                    print(regstrationStatus)
                    
                    if regstrationStatus == "TransporterPersonalInfo"{
                        
                        self.performSegue(withIdentifier: "PersonalInfoSegue", sender: nil)
                        
                    }else if regstrationStatus == "TransportreCarInfo"{
                        
                        self.performSegue(withIdentifier: "CarInfoSegue", sender: nil)
                        
                        
                    }else if regstrationStatus == "TransportreWorkTimeInfo"  || regstrationStatus == "TransportreWorkCityInfo"{
                        
                        self.performSegue(withIdentifier: "WorkInfoSegue", sender: nil)
                        
                        
                    }
                    else{
                        
                        
                         self.performSegue(withIdentifier: "TransporterHomePage", sender: nil)
                    }
                    
                    
                    
                    //  self.performSegue(withIdentifier: "PersonalInfoSegue", sender: nil)
                    
                    //                self.performSegue(withIdentifier: "WorkInfoSegue", sender: nil)
                    //
                    //               let regstrationStatus = UserDefaults.standard.string(forKey: "FlagRegistration")
                    //
                    //                if regstrationStatus == "TransporterPersonalInfo"{
                    //
                    //                    self.performSegue(withIdentifier: "PersonalInfoSegue", sender: nil)
                    //
                    //                }else if regstrationStatus == "TransporterCarInfo"{
                    //
                    //                    self.performSegue(withIdentifier: "CarInfoSegue", sender: nil)
                    //
                    //
                    //                }else if regstrationStatus == "TransporterWorkInfo"{
                    //
                    //                    self.performSegue(withIdentifier: "WorkInfoSegue", sender: nil)
                    //
                    //
                    //                }
                    
                    
                    //
                    
                }
                
                
                UIViewController.removeSpinner(spinner: sv)
                
                
            }
            
            
        }
        
    }
    
    func ArToEnStingConverter()-> String{
        
        let NumberStr: String = VerifiedAcountLoader.VerifiedCode
        let Formatter = NumberFormatter()
        Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale!
        let final = Formatter.number(from: NumberStr)
        
        return "\(final!)"
        
    }
    
    
    @IBAction func changeMobileNumber(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resendActivationCode(_ sender: UIButton) {
    }
    
    func genarateDeviceToken() -> String {
        
        let currentDateTime = Date().timeIntervalSinceReferenceDate
        print(String(currentDateTime))
        let hash = SHA1.hexString(from: String(currentDateTime))
        print(hash!)
        return hash!
    }
    
    // called when back btn pressed
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PersonalInfoSegue"{
            
            _ = segue.destination as?
            TransporterAccountViewController
        }
        if segue.identifier == "CarInfoSegue"{
            
            _ = segue.destination as?
            CarDetailsViewController
            
        }
        
        if segue.identifier == "WorkInfoSegue"{
            
            _ = segue.destination as?
            WorkDetailViewController
        }
        
        
        
    }
}
