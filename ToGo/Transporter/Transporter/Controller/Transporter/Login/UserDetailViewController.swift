//
//  UserDetailViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/22/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class UserDetailViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var placeTextField: CustomTextField!
    @IBOutlet weak var PostRegionTextField: CustomTextField!
    @IBOutlet weak var PostRegionPickerView: UIPickerView!
    @IBOutlet weak var placePickerView: UIPickerView!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var submitBtn: RoundedBtn!
    @IBOutlet weak var stringLable: UILabel!
    @IBOutlet weak var guidLable: UILabel!
    static var PostRegion = ""
    
    // Internet Connection
    let reachability = Reachability()!
    
    // ActivityIndicator
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
   // @IBOutlet weak var LoadingView: UIView!
    
    //Loader
    var placeLoader = PlaceListLoader()
    var _placeeList = [PlaceListModel]()
    
    var RegionLoader = RegionListLoader()
    var _RegionList = [PostRegionListModel]()
    
    var loginLoager = LoginLoader()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sv = UIViewController.displaySpinner(onView: self.view)

        PostRegionTextField.isEnabled = false
       // SetUpOriantation()
        
        // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                self.placeTextField.isEnabled = true
                // Get language list
                self.placeLoader.GetPlaceList {
                    
                    self._placeeList = self.placeLoader.palceList
                    
                    if  self._placeeList.count == 0{
                        // self.placeTextField.isEnabled = false
                    }else{
                        self.placeTextField.isEnabled = true
                        
                        self.placePickerView.reloadAllComponents()
                    }
                   UIViewController.removeSpinner(spinner: sv)
                }
                
            }
            
            
        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                self.placeTextField.isEnabled = false
                
                let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        SetUpTextField()
        //SetGradientBackground()
    }
    
    
    //textField//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == placeTextField{
            placePickerView.isHidden = false
            
            self.view.endEditing(true)
        }else if textField == PostRegionTextField{
            
            PostRegionPickerView.isHidden = false
            
            self.view.endEditing(true)
        }
    }
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
//    // maxLength for mobileTextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        if textField ==  mobileNumberTextField{

            let maxLength = 10
            let currentString: NSString = mobileNumberTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }

        else{
            return true
        }

    }
    //textField//
    
    
    @IBAction func choosePlaceBtnTapped(_ sender: Any) {
        
        placePickerView.isHidden = false
        
        self.view.endEditing(true)
        
    }
    
    
    @IBAction func chooseReginBnPressed(_ sender: Any) {
        PostRegionPickerView.isHidden = false
        
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    // Configure TextField
    func SetUpTextField()  {
        
        placeTextField.delegate = self
        PostRegionTextField.delegate = self
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SubmitBtnPressed(_ sender: Any) {
        
        
        
        // Check internet connection
        //when Reachable
        
        if reachability.isReachable == true{
            
            if mobileNumberTextField.text == "" || PostRegionTextField.text == "" {
                let alert = UIAlertController(title: "", message: DataWarning_Message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{
                
                
                // }else{
                
                if mobileNumberTextField.text!.hasPrefix("0"){
                    mobileNumberTextField.text!.remove(at: mobileNumberTextField.text!.startIndex)
                    LoginLoader.phoneNumber = UserDetailViewController.PostRegion + mobileNumberTextField.text!
                }
                else{
                    LoginLoader.phoneNumber = UserDetailViewController.PostRegion + mobileNumberTextField.text!
                    
                }
                
                if (mobileNumberTextField.text?.characters.count)! > 9{
                    let alert = UIAlertController(title: "", message: DataCount_Message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                else{
                    
                    let sv = UIViewController.displaySpinner(onView: self.view)
                    loginLoager.Login {
                        
                        
                        if LoginLoader.loginReult.contains("Updated"){
                            
                            self.performSegue(withIdentifier: "ActivationSegue", sender: nil)
                            
                        }else if LoginLoader.loginReult.contains("NotUpdated")  {
                            
                            let alert = UIAlertController(title: "", message: "NotUpdated", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }else if LoginLoader.loginReult.contains("TypeCustomerError" ) {
                            
                            let alert = UIAlertController(title: "", message: "TypeCustomerError", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }else if LoginLoader.loginReult.contains("inserted")  {
                            
                            
                            self.performSegue(withIdentifier: "ActivationSegue", sender: nil)
                            
                        }else if LoginLoader.loginReult.contains("Not_Insert")  {
                            let alert = UIAlertController(title: "", message: "Not_Insert", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }else if  LoginLoader.loginReult.contains("TokenError"){
                            
                            let alert = UIAlertController(title: "تحذير", message: "لقد تم الدخول لحسابك من جهاز اخر قم بالاغلاق وحاول لاحقا", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "اغلاق", style: .default, handler: {(alert: UIAlertAction!) in
                                
                                exit(0)
                                
                            }))
                            self.present(alert, animated: true)
                            
                        }
                        
                        
                        
                        UIViewController.removeSpinner(spinner: sv)
                    }
                }
            }
            
            
        }else{
            let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
    
    
    
    
    
    ////////////// PickerView///////////////
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == placePickerView{
            return  _placeeList.count
        }else if pickerView == PostRegionPickerView{
            return _RegionList.count
        }
        else{
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if pickerView == placePickerView{
            if _placeeList.count == 0{
                return ""
            }else{
                return _placeeList[row].Name
            }
            
        }else if pickerView == PostRegionPickerView{
            
            UserDetailViewController.PostRegion = _RegionList[row].PostValue!
            return _RegionList[row].PostValue
        }
        else{
            return ""
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == placePickerView{
            
            if _placeeList.count == 0{
                self.placeTextField.text =  "لا يوجد قيم"
            }else{
                self.placeTextField.text = _placeeList[row].Name
                UserDefaults.standard.set(_placeeList[row].RegId, forKey: "Region_id")
            }
            
            
            // get Region
            self.RegionLoader.GetPostRegions {
                
                self._RegionList = self.RegionLoader.RegionList
                self.PostRegionTextField.isEnabled = true
                self.PostRegionPickerView.reloadAllComponents()
                
            }
        }else if pickerView == PostRegionPickerView{
            
            if _RegionList.count != 0{
                 self.PostRegionTextField.text  = _RegionList[row].PostValue
            }else{
                self.PostRegionTextField.text = "لا يوجد قيم"
            }
            
           
        }
        
        placePickerView.isHidden = true
        PostRegionPickerView.isHidden = true
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    ////////////// PickerView///////////////
    
    
    
    func SetUpOriantation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            guidLable.semanticContentAttribute = .forceRightToLeft
            guidLable.textAlignment = .right
            mobileNumberTextField.textAlignment = .right
            
        }else{
            mobileNumberTextField.textAlignment = .left
            guidLable.semanticContentAttribute = .forceLeftToRight
            guidLable.textAlignment = .left
        }
    }
    
    
    // display Loading Indicator
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(netHex: 0xffffff).withAlphaComponent(0.3)
        
        loadingView.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(netHex: 0x444444).withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2)
        activityIndicator.color = UIColor.white
        
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    
    //  Hide loading indicator
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ActivationSegue"{
            
            _ = segue.destination as?
            ActivationViewController
        }
        
        
        
    }
}
