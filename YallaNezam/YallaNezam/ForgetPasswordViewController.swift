//
//  ForgetPasswordViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/11/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var mobileNumTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "استعادة كلمة المرور"
        
//        let button = UIButton.init(type: .custom)
//        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
//        button.addTarget(self, action:#selector(ForgetPasswordViewController.tappedFunc), for:.touchUpInside)
//        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
//        let barButton = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func confirmBtn(_ sender: Any) {
        
        if mobileNumTextfield.text == "" {
            YSLNoticeAlert().showAlert(title: "يرجى ادخال رقم الهاتف المحمول", subTitle: "" , alertType: .failure)
        }
        else {
        if reachability.isReachable{
            
            Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"ForgetPassword","MobileNumber":mobileNumTextfield.text!], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                response in
                print(response)
                if response.result.value == "BlockedUser" {
                    YSLNoticeAlert().showAlert(title: "المستخدم محظور", subTitle: "", alertType: .failure)
                }
                else if response.result.value == "SendCode" {
                    YSLNoticeAlert().showAlert(title: "تم ارسال الرمز", subTitle: "", alertType: .success)
                    let vc = NewPassViewController()
                    vc.mobileNum = self.mobileNumTextfield.text!
                    self.navigationController?.pushViewController(vc, animated: false)
                }
                else if response.result.value == "ErrorUpdateCode" {
                    YSLNoticeAlert().showAlert(title: "لم يتم ارسال الرمز", subTitle: "يرجى المحاولة مرة اخرى", alertType: .failure)
                }
                else if response.result.value == "CustomerNotExists" {
                    YSLNoticeAlert().showAlert(title: "الرقم غير مستخدم", subTitle: "", alertType: .failure)
                }
            }
        }
        else {
          YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
        }
        
        
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
