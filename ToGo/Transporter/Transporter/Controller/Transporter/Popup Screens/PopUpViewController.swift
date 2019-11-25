//
//  PopUpViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/16/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class PopUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var submitBtn: RoundedBtn!
    @IBOutlet weak var cancelBtn: RoundedBtn!
    static var OrderID: String = ""
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var LoadingView: UIView!
    var transporterLoader = TransporterLoader()
    var container: UIView = UIView()
   // var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    let View = UIView()
    
    // Cost
    static var SubmitCostResult: String = ""
    static var PriceOffer: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
        setUpUI()
        
        
        
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackTranslucent
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(PopUpViewController.doneTap(_:)))]
        
        tooBar.sizeToFit()
        PriceTextField.inputAccessoryView = tooBar
    }
    
    
    
    @objc func doneTap(_: UILabel) {
        view.endEditing(true)
        PriceTextField.resignFirstResponder()
       
    }
    
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        if PriceTextField.text == ""{
            let alert = UIAlertController(title: "", message: "الرجاء ادخال سعر", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            PopUpViewController.PriceOffer =  PriceTextField.text!
              let reachability = Reachability()!
            
                // Check internet connection
                //when Reachable
                reachability.whenReachable = { reachability in
                    
                    DispatchQueue.main.async {
                        
                        let sv = UIViewController.displaySpinner(onView: self.view)

                        
                        self.transporterLoader.TransporterSetCostOrder{
                            
                           UIViewController.removeSpinner(spinner: sv)
                      
                            if PopUpViewController.SubmitCostResult.contains("InsertedBid") {
                                
                                
                                let alert = UIAlertController(title: "", message: "تم ارسال طلبك بنجاح", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                                 self.removeAnimate()
                                
                                }))
                             
                                self.present(alert, animated: true)
                                
                                
                            }else if  PopUpViewController.SubmitCostResult == "AlreadyAddedValue"{
                                
                                let alert = UIAlertController(title: "", message: "AlreadyAddedValue", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                                    self.removeAnimate()
                                    
                                }))
                                
                                self.present(alert, animated: true)
                            }
                            
                            else if PopUpViewController.SubmitCostResult.contains("ChargeBalanace")
                            {
                                
                                let alert = UIAlertController(title: "لا يوجد رصيد كافي", message:  "لا يتوفر لديك رصيد كافي لاتمام العملية , قم بشحن رصيدك وحاول لاحقا" , preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                                    self.removeAnimate()
                                    
                                }))
                                self.present(alert, animated: true)
                            }
                                
                                
                                
                            else if PopUpViewController.SubmitCostResult.contains("OrderNotFound"){
                                
                                let alert = UIAlertController(title: "", message: "لقد تم حذف الطلب من قبل المرسل", preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                                    self.removeAnimate()
                                    
                                }))
                                
                                self.present(alert, animated: true)
                            }
                            else {
                                
                                let alert = UIAlertController(title: "", message: PopUpViewController.SubmitCostResult, preferredStyle: .alert)
                                
                                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                                    self.removeAnimate()
                                    
                                }))
                                
                                self.present(alert, animated: true)
                            }
                          
                            
                            }
                            
                            
                            
                        }
                        
                   
                    
                    
                }
                // When UnReachable
                reachability.whenUnreachable = { reachability in
                    // this is called on a background thread, but UI updates must
                    // be on the main thread, like this:
                    DispatchQueue.main.async {
                        
                        
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
            
            
        
        
    }
    
    // remove popup
    @IBAction func cancelBtnPressed(_ sender: Any) {
        removeAnimate()
    }
    
    
    
//    // display Loading Indicator
//    func showActivityIndicator(uiView: UIView) {
//        container.frame = uiView.frame
//        container.center = uiView.center
//        container.backgroundColor = UIColor(netHex: 0xffffff).withAlphaComponent(0.3)
//
//        loadingView.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
//        loadingView.center = uiView.center
//        loadingView.backgroundColor = UIColor(netHex: 0x444444).withAlphaComponent(0.7)
//        loadingView.clipsToBounds = true
//        loadingView.layer.cornerRadius = 10
//
//        activityIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2)
//        activityIndicator.color = UIColor.white
//
//
//        loadingView.addSubview(activityIndicator)
//        container.addSubview(loadingView)
//        uiView.addSubview(container)
//        activityIndicator.startAnimating()
//    }
//
//
//    //  Hide loading indicator
//    func hideActivityIndicator(uiView: UIView) {
//        activityIndicator.stopAnimating()
//    }
    
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Configure UI
    func setUpUI()  {
        self.submitBtn.layer.borderWidth = 0.5
        self.submitBtn.layer.cornerRadius = 15
        self.submitBtn.layer.borderColor = UIColor.white.cgColor
        self.cancelBtn.layer.borderWidth = 0.5
        self.cancelBtn.layer.cornerRadius = 15
        self.cancelBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    // Show PopUp
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    // Remove PopUp
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                //self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
    
}
