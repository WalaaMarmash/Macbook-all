//
//  CheckCostPopupViewController.swift
//  Transporter
//
//  Created by Fratello Software Group on 12/23/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class CheckCostPopupViewController : UIViewController {
    
    @IBOutlet weak var updateCost: RoundedBtn!
    @IBOutlet weak var cancelOrder: RoundedBtn!
    
    @IBOutlet weak var costMessage: UILabel!
    
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
    static var CostDelivery: String = ""
    static var DeleteSubmitCostResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
        setUpUI()
        
        costMessage.text = "لقد قمت بادخال سعر وقيمته " + CheckCostPopupViewController.CostDelivery +  "شيكل هل تود تعديل السعر او الغاءه"
        
    }
    
    
    
    func tapped(gestureRecognizer: UITapGestureRecognizer) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateCostBtnPressed(_ sender: Any) {
        
        //updateCost
        self.performSegue(withIdentifier: "updateCost", sender: nil)
        
        
    }
    
    // remove popup
    @IBAction func cancelBtnPressed(_ sender: Any) {
      
        TransporterLoader.TypeAction = "DeleteCost"
        
        transporterLoader.TransporterEditPriceTrip {
       
            if CheckCostPopupViewController.DeleteSubmitCostResult .contains("deleteOrder") {
                
                
                let alert = UIAlertController(title: "", message: "تم الغاء السعر الذي قمت بادخاله بنجاح", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                    self.removeAnimate()
                    
                }))
                
                self.present(alert, animated: true)
                
                
            }
            
            else{
                
                let alert = UIAlertController(title: "", message: CheckCostPopupViewController.DeleteSubmitCostResult , preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                    self.removeAnimate()
                    
                }))
                
                self.present(alert, animated: true)
            }
            
        }
        
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
        self.updateCost.layer.borderWidth = 0.5
        self.updateCost.layer.cornerRadius = 15
        self.updateCost.layer.borderColor = UIColor.white.cgColor
        self.cancelOrder.layer.borderWidth = 0.5
        self.cancelOrder.layer.cornerRadius = 15
        self.cancelOrder.layer.borderColor = UIColor.white.cgColor
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateCost"{
            
            _ = segue.destination as?
            updateDelivaryCostViewController
        }
        
    }
}


extension CheckCostPopupViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.superview!.superclass! .isSubclass(of: UIButton.self) {
            return false
        }
        return true
    }
}
