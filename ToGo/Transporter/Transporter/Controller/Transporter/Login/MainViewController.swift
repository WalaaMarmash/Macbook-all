//
//  MainViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift


class MainViewController: UIViewController,UITextFieldDelegate{
    
    
    // Outlets
    //languageTextField
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var LanguagePickerList: UIPickerView!
    @IBOutlet weak var submitBtn: RoundedBtn!
    var choosenLanguage: String! = ""
    var choosenLanguage_id: String! = ""
    // TextFieldIcons
    @IBOutlet weak var Icon1: UIImageView!
    
    //Loader
    var langugeLoader = LangugeListLoader()
    var _langugeList = [LangugeListModel]()
    
    var PostRegionLoader = RegionListLoader()
    var _postRegionList = [LangugeListModel]()

    
    // Internet Connection
    let reachability = Reachability()!
    
    
    // ActivityIndicator
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    
    let View = UIView()
   // @IBOutlet weak var loadingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                let sv = UIViewController.displaySpinner(onView: self.view)

                
                self.languageTextField.isEnabled = false
                // Get language list
                self.langugeLoader.GetLangugeList{
                    
                    self._langugeList = self.langugeLoader.langugeList
                      self.languageTextField.isEnabled = true
                    UIViewController.removeSpinner(spinner: sv)

                    self.LanguagePickerList.reloadAllComponents()
                }
                
            }
            UserDefaults.standard.set("ar", forKey: "lang")
            
        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                self.languageTextField.isEnabled = false
//                self.setUpPopupView()
//               self.DisplayPopup(message: "")
                self.performSegue(withIdentifier: "NetworkUnavailable", sender: nil)
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
        if textField == languageTextField{
            LanguagePickerList.isHidden = false
            
            submitBtn.isHidden = true
            
            self.view.endEditing(true)
        }
    }
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textField//
    
    

    // Configure TextField
    func SetUpTextField()  {
        
        languageTextField.delegate = self
        
    }
    
    // called when user select the language
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        UserDefaults.standard.set(choosenLanguage_id, forKey: "language_id")
        
        if choosenLanguage ==  "TestLang"{
            UserDefaults.standard.set("ar", forKey: "lang")
        }else{
            UserDefaults.standard.set("en", forKey: "lang")
        }
        
        
        // Check internet connection
        //when Reachable
        
        if reachability.isReachable == true{
            
           self.performSegue(withIdentifier: "RegSegue", sender: nil)
            
        }else{
            let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
      
        
       
        
      //  RegSegue
        
    }
    
    
    // Set GradientBackground for textField
    func SetGradientBackground()  {
        // Create a gradient layer
        let gradient = CAGradientLayer()
        
        // gradient colors in order which they will visually appear
        gradient.colors = [UIColor(netHex:0x2FAB9B), UIColor(netHex:0x6FC4A1)]
        
        // Gradient from left to right
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        // set the gradient layer to the same size as the view
        gradient.frame = languageTextField.bounds
        // add the gradient layer to the views layer for rendering
        languageTextField.layer.addSublayer(gradient)
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
    
    
    // Add transperant background to the current screen when display notification
    func setUpPopupView() {
        self.View.frame = CGRect(x: 0, y: 0, width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        self.View.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.View.tag = 51
        self.view?.addSubview(self.View)
    }
    
    
    
    //Display  PopUp
    func DisplayPopup(message: String)  {
        
        let PopUpView = Bundle.main.loadNibNamed("CustomPopupView", owner: self, options: nil)?.first as? CustomPopupView
        PopUpView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
      //  PopUpView?.notificationText.text = message
        PopUpView?.center = (self.View.center)
        PopUpView?.tag = 50
        PopUpView?.saveBtn.addTarget(self, action: #selector(self.handleCancelBtn(sneder:)), for: .touchUpInside)
        self.View.addSubview(PopUpView!)
        
    }
    //Cancel Popup
    @objc func handleCancelBtn(sneder: UIButton){
        
        if let viewWithTag = self.view?.viewWithTag(50) {
            viewWithTag.removeFromSuperview()
        }
        if let viewWithTag = self.view?.viewWithTag(51) {
            viewWithTag.removeFromSuperview()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "RegSegue"{
            
            _ = segue.destination as?
            PrivecyViewController
        }
        
        
        if segue.identifier == "NetworkUnavailable"{
            
            _ = segue.destination as?
            OfflineViewController
        }
        
    }

}



