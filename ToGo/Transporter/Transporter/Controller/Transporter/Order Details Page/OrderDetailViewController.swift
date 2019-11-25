//
//  OrderDetailViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/17/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class OrderDetailViewController:UIViewController ,UITextFieldDelegate{
    
    //Outlets
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var ClientName: UILabel!
    @IBOutlet weak var ClientPhoneNum: UILabel!
    @IBOutlet weak var DesPhoneNum: UILabel!
    
    static var OrderID: String = ""
    @IBOutlet weak var DelivaryWay: UILabel!
    @IBOutlet weak var orderDetails: UILabel!
    @IBOutlet weak var OrderSize: UILabel!
    @IBOutlet weak var orderWeight: UILabel!
    @IBOutlet weak var OrderlenghtWidth: UILabel!
    // Source Address
    @IBOutlet weak var SrcFlowrNumber: UILabel!
    @IBOutlet weak var ScrBuilding: UILabel!
    @IBOutlet weak var SrcStreet: UILabel!
    @IBOutlet weak var SrcPlace: UILabel!
    
    // Des Address
    @IBOutlet weak var DesFlowrNumber: UILabel!
    @IBOutlet weak var DesBuilding: UILabel!
    @IBOutlet weak var DesStreet: UILabel!
    @IBOutlet weak var DesPlace: UILabel!
    static var indexNum: String = ""
    
    let reachability = Reachability()!
    @IBOutlet weak var LoadingView: UIView!
    var transporterLoader = TransporterLoader()
    var container: UIView = UIView()
    var loadingview: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    let View = UIView()
    
    @IBOutlet weak var loadDetailsStack: UIStackView!
    @IBOutlet weak var loadTextlable: UILabel!
    @IBOutlet weak var loadlineView: UIView!
    
    @IBOutlet weak var topSpaceButton: NSLayoutConstraint!
    
    @IBOutlet weak var VerofictionDelivaryPopup: RoundedBtn!
    @IBOutlet weak var verifiedCodeTextField: UITextField!
    @IBOutlet weak var submitBtn: RoundedBtn!
    @IBOutlet weak var cancelBtn: RoundedBtn!
    static var CodeVerify = ""
    
    static var SendVerfiedCodeToReciverResult = ""
    static var SendVerfiedCodeConfirmFinshTrip = ""
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackTranslucent
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(OrderDetailViewController.doneTap(_:)))]
        
        tooBar.sizeToFit()
        
        verifiedCodeTextField.inputAccessoryView = tooBar
        
        
         setUpUI()
        
        //  // Check internet connection
        //        //when Reachable
        //        reachability.whenReachable = { reachability in
        //
        //            DispatchQueue.main.async {
        
         let sv = UIViewController.displaySpinner(onView: self.view)
        
        self.transporterLoader.TransporterShowDetailsOrderCurrent {
        
            
           UIViewController.removeSpinner(spinner: sv)
            
            if OrderDetailsViewController.OrderDetailsResult == "OrderNotFound"{
                let alert = UIAlertController(title: "OrderNotFound", message: "OrderNotFound", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            else{
                self.UpdateUI()
            }
       
            
        }
        // }
        //            // When UnReachable
        //            reachability.whenUnreachable = { reachability in
        //                // this is called on a background thread, but UI updates must
        //                // be on the main thread, like this:
        //                DispatchQueue.main.async {
        //
        //
        //                    let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)
        //
        //                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
        //                    alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
        //                    self.present(alert, animated: true)
        //                }
        //
        //            }
        //
        //            do {
        //                try reachability.startNotifier()
        //            } catch {
        //                print("Unable to start notifier")
        //            }
        
        // }
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func doneTap(_: UILabel) {
        view.endEditing(true)
        verifiedCodeTextField.resignFirstResponder()
    }
    func UpdateUI()  {
        
        if TransporterLoader._OrderDetailsResult[0].TypeLoad == "1"{
            loadDetailsStack.isHidden = true
            loadlineView.isHidden = true
            loadTextlable.isHidden = true
            topSpaceButton.constant = 25
            
        }else if (TransporterLoader._OrderDetailsResult[0].TypeLoad == "2") || (TransporterLoader._OrderDetailsResult[0].TypeLoad == "3"){
            loadDetailsStack.isHidden = false
            loadlineView.isHidden = false
            loadTextlable.isHidden = false
             topSpaceButton.constant = 166
        }
        
        
        self.orderNumber.text = "رقم الطلب :\(OrderDetailsViewController.indexNum )"
        self.ClientName.text = TransporterLoader._OrderDetailsResult[0].FullNameCustomer
        self.ClientPhoneNum.text = TransporterLoader._OrderDetailsResult[0].PhoneCustomer
        self.DelivaryWay.text = self.getDelivaryWayNameByID(Id: Int(TransporterLoader._OrderDetailsResult[0].deliveryWay!)!)
        self.orderDetails.text = TransporterLoader._OrderDetailsResult[0].DetailsLoad
        self.OrderSize.text = TransporterLoader._OrderDetailsResult[0].WidthLoad
        self.orderWeight.text = TransporterLoader._OrderDetailsResult[0].WeightLoad
        self.OrderlenghtWidth.text = TransporterLoader._OrderDetailsResult[0].WidthLoad!  + "," + TransporterLoader._OrderDetailsResult[0].LengthLoad!
        
        // Src Address
        
        self.SrcPlace.text = TransporterLoader._OrderDetailsResult[0].NameNeighborhood! + ","
        
        self.SrcStreet.text = TransporterLoader._OrderDetailsResult[0].NameStreet! + ","
        self.ScrBuilding.text = TransporterLoader._OrderDetailsResult[0].NameBuilding! + ","
        self.SrcFlowrNumber.text = TransporterLoader._OrderDetailsResult[0].FloorNumbers
        
        
        // Dest
        self.DesPlace.text = TransporterLoader._OrderDetailsResult[0].NameNeighborhood! + ","
        
        self.DesStreet.text = TransporterLoader._OrderDetailsResult[0].NameStreetDes! + ","
        
        self.DesBuilding.text = TransporterLoader._OrderDetailsResult[0].NameBuildingDes! + ","
        
        self.DesFlowrNumber.text = TransporterLoader._OrderDetailsResult[0].FloorNumbersDes
    }
    
    
    func getDelivaryWayNameByID(Id: Int) -> String {
        
        switch Id {
        case 1:
            return "ارسال فقط"
        case 2:
            return "ارسال وقبض المبلغ"
        case 3:
            return "استلام الطلب"
        case 4:
            return "دفع واستلام"
        default:
            return ""
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
      //  self.dismiss(animated: true, completion: nil)
        MasterViewController.segmentedControlIndex = 1
        let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterHomePage")
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func finishOrder(_ sender: UIButton) {
        
      // self.hideActivityIndicator(uiView: self.LoadingView)
       self.LoadingView.isHidden = false
       verifiedCodeTextField.text = ""
       self.VerofictionDelivaryPopup.isHidden = false
       }
    
    @IBAction func sendVerifiedCodeToReciver(_ sender: Any) {
        
       
        
//        if OrderDetailViewController.SendVerfiedCodeToReciverResult == "Message_Send"{
//
//            let alert = UIAlertController(title: "", message: "لقد قمت بارسال الرمز من قبل بنجاح", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
//
//            self.present(alert, animated: true)
//
//
//        }
//        else{
            let sv = UIViewController.displaySpinner(onView: self.view)
        
        self.transporterLoader.TransporterFinshTrip {
            
         
           UIViewController.removeSpinner(spinner: sv)
            
          
            
            if OrderDetailViewController.SendVerfiedCodeToReciverResult == "Message_Send"{
                
                let alert = UIAlertController(title: "", message: "تم ارسال الرمز بنجاح", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            else{
                let alert = UIAlertController(title: "", message: OrderDetailViewController.SendVerfiedCodeToReciverResult, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            
           
        }
            
      //  }
    }
    
    
    
    @IBAction func cancelVeifiedCodePopup(_ sender: Any) {
        self.LoadingView.isHidden = true
        self.VerofictionDelivaryPopup.isHidden = true
      
    }
    
    @IBAction func submitVerifiedCode(_ sender: Any) {
        self.LoadingView.isHidden = true
        
        if verifiedCodeTextField.text == ""{
            
            let alert = UIAlertController(title: "", message: "ادخل رمز التفعيل", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        else{
             OrderDetailViewController.CodeVerify = verifiedCodeTextField.text!
            
            let sv = UIViewController.displaySpinner(onView: self.view)

            
            self.transporterLoader.TransporterConfirmFinshTrip {
                
                UIViewController.removeSpinner(spinner: sv)

                
                if OrderDetailViewController.SendVerfiedCodeConfirmFinshTrip == "CodeError"{
                    let alert = UIAlertController(title: "", message: "رمز التفعيل خطا", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                    
                }else if OrderDetailViewController.SendVerfiedCodeConfirmFinshTrip.contains("finishedOrder")  {
                    
                    let alert = UIAlertController(title: "", message: "تم انهاء الرحلة بنجاح", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: {(alert: UIAlertAction!) in
                        
                        self.VerofictionDelivaryPopup.isHidden = true
                        AppDelegate.Transportlocation.stopUpdatingLocation()
                        
                    }))
                    
                    self.present(alert, animated: true)
                    
                    
                }
                else{
                    
                    let alert = UIAlertController(title: "", message: OrderDetailViewController.SendVerfiedCodeConfirmFinshTrip , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
                }
                
            }
        }
       
        
        
    }
    
//    // display Loading Indicator
//    func showActivityIndicator(uiView: UIView) {
//        container.frame = uiView.frame
//        container.center = uiView.center
//        container.backgroundColor = UIColor(netHex: 0xffffff).withAlphaComponent(0.3)
//
//        loadingview.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
//        loadingview.center = uiView.center
//        loadingview.backgroundColor = UIColor(netHex: 0x444444).withAlphaComponent(0.7)
//        loadingview.clipsToBounds = true
//        loadingview.layer.cornerRadius = 10
//
//        activityIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
//        activityIndicator.center = CGPoint(x: loadingview.frame.size.width / 2,y: loadingview.frame.size.height / 2)
//        activityIndicator.color = UIColor.white
//
//
//        loadingview.addSubview(activityIndicator)
//        container.addSubview(loadingview)
//        uiView.addSubview(container)
//        activityIndicator.startAnimating()
//    }
    
    
    //  Hide loading indicator
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
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
    



//    func SetUpOriantation()  {
//
//        let lang = UserDefaults.standard.string(forKey: "lang")
//        if lang == "ar"{
//
//
//            for item in uiStack{
//                item.semanticContentAttribute = .forceLeftToRight
//            }
//
//            for item in uiLable{
//                item.textAlignment = .right
//            }
//
//        }else{
//
//
//            for item in uiStack{
//                item.semanticContentAttribute = .forceRightToLeft
//            }
//
//            for item in uiLable{
//                item.textAlignment = .left
//            }
//        }
//    }
}
