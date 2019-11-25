//
//  OrderDetailsViewController.swift
//  TOGOTransporter
//
//  Created by Fratello Software Group on 9/18/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class OrderDetailsViewController: UIViewController {

    //Outlets
    static var pushType = ""
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var ClientName: UILabel!
    @IBOutlet weak var ClientPhoneNum: UILabel!
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
    
    @IBOutlet weak var orderDetailsLable: UILabel!
    static var OrderDetailsResult = ""
    
    
    @IBOutlet weak var loadDetailsStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//  // Check internet connection
//        //when Reachable
//        reachability.whenReachable = { reachability in
//
//            DispatchQueue.main.async {
        
                self.LoadingView.isHidden = false
                self.showActivityIndicator(uiView: self.LoadingView)
                
                self.transporterLoader.TransporterShowDetailsOrder{
                    
                    self.LoadingView.isHidden = true
                    self.hideActivityIndicator(uiView: self.LoadingView)
                    
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
    
    
    func UpdateUI()  {
        
        if TransporterLoader._OrderDetailsResult[0].TypeLoad == "1"{
            loadDetailsStack.isHidden = true
            orderDetailsLable.isHidden = false
        }else if (TransporterLoader._OrderDetailsResult[0].TypeLoad == "2") || (TransporterLoader._OrderDetailsResult[0].TypeLoad == "3"){
           loadDetailsStack.isHidden = false
         orderDetailsLable.isHidden = true
        }
        
        
        self.orderNumber.text = "رقم الطلب :\(OrderDetailsViewController.indexNum)"
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
        self.SrcFlowrNumber.text = TransporterLoader._OrderDetailsResult[0].FloorNumbers! + ","
        
        
        // Dest
        self.DesPlace.text = TransporterLoader._OrderDetailsResult[0].NameNeighborhood! + ","
        
        self.DesStreet.text = TransporterLoader._OrderDetailsResult[0].NameStreetDes! + ","
        
        self.DesBuilding.text = TransporterLoader._OrderDetailsResult[0].NameBuildingDes! + ","
        
        self.DesFlowrNumber.text = TransporterLoader._OrderDetailsResult[0].FloorNumbersDes! + ","
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
        
        if OrderDetailsViewController.pushType == "1"{
            MasterViewController.segmentedControlIndex = 0
        }
        else{
            MasterViewController.segmentedControlIndex = 2
        }
        
        
         let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
         let initialViewController = storyboard.instantiateViewController(withIdentifier: "TransporterHomePage")
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
//         UIApplication.shared.windows.first?.rootViewController = initialViewController
//         UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        //self.navigationController?.popViewController(animated: true)
      //self.dismiss(animated: true, completion: nil)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TransporterHomePage") as! NewViewController
//        self.present(newViewController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // display Loading Indicator
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(netHex: 0xffffff).withAlphaComponent(0.3)
        
        loadingview.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        loadingview.center = uiView.center
        loadingview.backgroundColor = UIColor(netHex: 0x444444).withAlphaComponent(0.7)
        loadingview.clipsToBounds = true
        loadingview.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingview.frame.size.width / 2,y: loadingview.frame.size.height / 2)
        activityIndicator.color = UIColor.white
        
        
        loadingview.addSubview(activityIndicator)
        container.addSubview(loadingview)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    
    //  Hide loading indicator
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
    }
    
    

}
