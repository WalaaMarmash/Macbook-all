//
//  SignUpViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/10/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DropDown


class SignUpViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var myScroll: UIScrollView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passTextfield: UITextField!
    @IBOutlet weak var rePassTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    @IBOutlet weak var landPhoneTextfield: UITextField!
    
    
    @IBOutlet weak var cityBtn: UIButton!
    
    var cityDropDown:DropDown!
    var cities:[[AnyHashable:Any]] = []
 
    var cityArray:[String] = []
    var idArray:[String] = []
    var selectedId = -1
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.title = "انشاء حساب"
       
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
//        button.addTarget(self, action:#selector(SignUpViewController.tappedFunc), for:.touchUpInside)
//        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
//        let barButton = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton
        
       // emailTextfield.delegate = self
        phoneTextfield.delegate = self
        landPhoneTextfield.delegate = self
        nameTextfield.delegate = self
       // passTextfield.delegate = self
       // rePassTextfield.delegate = self
        

        cityDropDown = DropDown(anchorView: cityBtn)
        
        getCities()
        

        cityDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.cityBtn.setTitle("  " + item, for:.normal)
            self.cityDropDown.hide()
            for city in self.cities{
                if city["Name"] as! String == item{
                    self.cityBtn.setTitle("  " + ((city["Name"] as? String)!), for: .normal)
                    self.selectedId = index
                }
            }
        } //typeDropDown
    }
    
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        
      
        var final = phoneTextfield.text!
        if (phoneTextfield.text?.count)! > 0 {
            let NumberStr: String = phoneTextfield.text!
            let Formatter: NumberFormatter = NumberFormatter()
            Formatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
            final = String(describing: Formatter.number(from: NumberStr)!)
            final.insert("0", at: final.startIndex)
        }
        
//       if nameTextfield.text! == "" && passTextfield.text! == "" && selectedId == -1 && phoneTextfield.text! == "" {
//            YSLNoticeAlert().showAlert(title: "يرجى تعبئة كافة البيانات", subTitle: "" , alertType: .failure)
//        }
//        else if passTextfield.text != rePassTextfield.text {
//            YSLNoticeAlert().showAlert(title: "كلمة المرور غير متطابقة", subTitle: "" , alertType: .failure)
//        }
//        else if passTextfield.text! == "" {
//            YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة المرور", subTitle: "" , alertType: .failure)
//        }
        
         if nameTextfield.text! == "" {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال الاسم", subTitle: "" , alertType: .failure)
        }
        else if selectedId == -1 {
            YSLNoticeAlert().showAlert(title: "يرجى اختيار المدينة", subTitle: "" , alertType: .failure)
        }
        else if phoneTextfield.text! == "" {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال رقم الهاتف المحمول", subTitle: "" , alertType: .failure)
        }
            
//        else if (passTextfield.text?.count)! < 8 {
//            YSLNoticeAlert().showAlert(title: "يرجى ادخال كلمة مرور لا تقل عن ٨ خانات", subTitle: "", alertType: .failure)
//        }
       else if !validateNumber(enteredNumber: final)  {
        print("final \(final)")
        YSLNoticeAlert().showAlert(title: " صيغة رقم الهاتف المحمول غير صحيحة", subTitle: "", alertType: .failure)
       }
        
    else {
        
    if reachability.isReachable{
            
        Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"SignUp","FullName":nameTextfield.text!,"Email":"","Password":"","CityId":idArray[selectedId],"MobileNumber":phoneTextfield.text!,"LandPhone":landPhoneTextfield.text!], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
            response in
            print(response)
            
            if response.result.value == "Inserted" {
              let vc = ConfirmViewController()
                vc.mobileNum = self.phoneTextfield.text!
                self.navigationController?.pushViewController(vc, animated: false)
            }
            else if response.result.value == "ExistsNumber" {
                 YSLNoticeAlert().showAlert(title: "الرقم مستخدم مسبقاً", subTitle: "", alertType: .failure)
                
            }
            else if response.result.value == "NotInserted" {
                YSLNoticeAlert().showAlert(title: "حدث خطأ حاول مرة اخرى", subTitle: "", alertType: .failure)
            }
            else{
                YSLNoticeAlert().showAlert(title: "حدث خطأ حاول مرة اخرى", subTitle: "", alertType: .failure)
            }

        } // alamofire
        } //reachability
    else{
        YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
        }
    } // signUpBtn
    
    
    
    
    func getCities() {
        Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"GetCityRegistration"], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseJSON {
            response in
            print(response)
             if let data = response.data{
                
            let json = JSON(data)
            print(json)
            self.cities = json.object as? [[AnyHashable:Any]] ?? [[:]]

            for city in self.cities
            {
                if city["Name"] as? String != nil && city["Name"] as? String != ""{
                    self.cityArray.append(city["Name"] as? String ?? "")
                    self.idArray.append(city["id"] as? String ?? "")
                    
                }
            }
                self.cityDropDown.dataSource = self.cityArray
            }
        }
    }

//    @objc func tappedFunc() {
//        //do stuff here
//        print("tapped icon")
//    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    @IBAction func chooseCityBtn(_ sender: Any) {
        cityDropDown.show()
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

extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

class CheckBox: UIButton {
    // Images
    let checkedImage = #imageLiteral(resourceName: "6")
    let uncheckedImage = #imageLiteral(resourceName: "3")
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
} // CLASS CheckBox
