//
//  NotesViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/16/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import CoreLocation
//import GoogleMaps
//import GooglePlacePicker
import Alamofire
import SwiftyJSON

protocol MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?)
    func reopenMenu()
}

class NotesViewController: UIViewController , UITextViewDelegate {
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var addInfoTextview: UITextView!
    

    var testVC = MenuViewController()
    
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )

    @IBOutlet weak var checkBox: CheckBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.title = "ملاحظات"
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "Yala Nezam icon-3.png"), for: UIControl.State.normal)
        button.addTarget(self, action:#selector(NotesViewController.tappedFunc), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        

        noteTextView.delegate = self
        noteTextView.text = "اضف هنا"
        noteTextView.textColor = UIColor.lightGray
        
        addInfoTextview.delegate = self
        
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func sendBtn(_ sender: Any) {
        if reachability.isReachable{
            
            if checkBox.isChecked == true {
                flagSeen = ""
            }
            else if checkBox.isChecked == false {
                flagSeen = "seen"
            }
            
            if noteTextView.text != "اضف هنا" || addInfoTextview.text != "" {
                flagDetails = "Show"
            }
            else if noteTextView.text == "اضف هنا" && addInfoTextview.text == "" {
                noteTextView.text = ""
                addInfoTextview.text = ""
                flagDetails = ""
            }
        
            
            if checkTypeUpload == "Vedio" {
                    self.callAPIForUploadVideo(myVideoURL: videoURL)
                }
            else if checkTypeUpload == "Image" {
                    
               
                
                let alertWait = SCLAlertView(appearance: appearance)
                alertWait.showWait("يرجى الانتظار...", subTitle: "", closeButtonTitle: "", timeout: nil , colorStyle: 0x00B23D, colorTextButton: 0xFFFFFF  , circleIconImage: nil, animationStyle: .topToBottom)
                
                    Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"UploadComplaints","CustomerId":UserDefaults.standard.string(forKey: "id") as! String,"CheckTypeUpload":checkTypeUpload , "FlagDetails":flagDetails, "FlagSeen":flagSeen , "LatLocation": latLocation , "LongLocation":longLocation , "ComplaintPhotos":photoArray , "Description": noteTextView.text! ,  "InfoLocation":addInfoTextview.text!], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                        response in
                        print(response)
                        alertWait.hideView()
                        if response.result.value == "InsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "تم الارسال بنجاح", subTitle: "", alertType: .success)
                            let vc = CameraViewController()
                            self.navigationController?.pushViewController(vc, animated: false)
                        }
                        else if response.result.value == "NotInsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "لم يتم الارسال", subTitle: "", alertType: .failure)
                        }
                        else {
                            YSLNoticeAlert().showAlert(title: "حدث خلل يرجى اعادة المحاولة", subTitle: "", alertType: .failure)
                        }
                    }//alamofire
                } // if checkTypeUpload
            
        }
        else{
            YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
        }
    }
    
    func callAPIForUploadVideo (myVideoURL : URL){
        print("callAPIForUploadVideo")
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let dateTime = formatter.string(from: currentDateTime)
        let videoName = "video" + dateTime + ".mp4"
        
        
        let parameters : Parameters = ["CheckTypeFunction":"UploadComplaints","CustomerId":UserDefaults.standard.string(forKey: "id") as! String,"CheckTypeUpload":checkTypeUpload,"FlagDetails":flagDetails, "FlagSeen":flagSeen , "LatLocation": String(latLocation) , "LongLocation":String(longLocation) , "ComplaintPhotos":"" , "Description": noteTextView.text! , "InfoLocation":addInfoTextview.text!]
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        
        let alertWait = SCLAlertView(appearance: appearance)
        alertWait.showWait("يرجى الانتظار...", subTitle: "", closeButtonTitle: "", timeout: nil , colorStyle: 0x00B23D, colorTextButton: 0xFFFFFF  , circleIconImage: nil, animationStyle: .topToBottom)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            // code
            // here you can upload only mp4 video
            for (key,value) in parameters {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(myVideoURL, withName: "myFile", fileName: videoName , mimeType: "video/mp4")
            
            // here you can upload any type of video
            //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
            multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
            
            //  }, to: "http://46.253.95.83/YallaNezam/YallaNezamApis/public/TestVedio.php", encodingCompletion: { (result) in
        }, to: url, encodingCompletion: { (result) in
            // code
            print(result)
            switch result {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.validate().responseString {
                    
                    response in
                    print("responseee")
                    print(response)
                    alertWait.hideView()
                    if response.result.isFailure {
                        debugPrint(response)
                    } else {
                        //                        let result = response.value as! NSDictionary
                        //                        print("reeeesult")
                        //                        print(result)
                        if response.result.value == "InsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "تم الارسال بنجاح", subTitle: "", alertType: .success)
                            self.viewDidLoad()
                        }
                        else if response.result.value == "NotInsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "لم يتم الارسال", subTitle: "", alertType: .failure)
                        }
                        else {
                            YSLNoticeAlert().showAlert(title: "حدث خلل يرجى اعادة المحاولة", subTitle: "", alertType: .failure)
                        }
                    }
                }
            case .failure(let encodingError):
                NSLog((encodingError as NSError).localizedDescription)
            }
        })
        
        
    }
    
    @objc func tappedFunc() {
        
        if(testVC.flagmenue == false)
        {

        self.testVC.view.frame = CGRect(x: 0, y: 0, width: 420, height: 850)
        //self.testVC.changePassBtn.addTarget(self, action: #selector(NotesViewController.moveFunc), for: .touchUpInside)
        self.testVC.settingBtn.addTarget(self, action: #selector(NotesViewController.moveSettingFunc), for: .touchUpInside)
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

    } // tappedFunc on menu item
    
    @objc func  moveFunc() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @objc func  moveSettingFunc() {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: false)
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
   
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if noteTextView.textColor == UIColor.lightGray {
            noteTextView.text = ""
            noteTextView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if noteTextView.text == "" {
            
            noteTextView.text = "اضف هنا"
            noteTextView.textColor = UIColor.lightGray
        }
    }
    
    //func to hide keyboard when touch outside the textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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


