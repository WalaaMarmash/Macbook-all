//
//  AvailableOrderViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/16/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class AvailableOrderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var orderTable: UITableView!
    var transporterLoader = TransporterLoader()
    
    
    @IBOutlet weak var mainscrollView: UIScrollView!
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    let View = UIView()
    //@IBOutlet weak var LoadingView: UIView!
    @IBOutlet weak var statusMsg: UILabel!
    @IBOutlet weak var PricePopup: RoundedBtn!
    @IBOutlet weak var PriceTextField: UITextField!
    static var Orders = [OrdersModel]()
    var refreshTimer: Timer!
    static var GetOrderResult: String = ""
    static var isPageRefreshing: Bool?
    static var submitCostStatus: String = ""
    
    var PageSize = 10
     var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderTable.allowsSelection = false
        orderTable.tableFooterView = UIView()
        
        self.orderTable.refreshControl = refreshControlller
        self.SetUpRefreshControlller()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       // timer = Timer.scheduledTimer(timeInterval: 30, target: self,   selector: (#selector(handler)), userInfo: nil, repeats: true)
        AvailableOrderViewController.Orders = []
        PageNumber = AvailableOrderViewController.Orders.count + 1
        getOrders()
    }
    
    
    
    
    func SetUpRefreshControlller()  {
        let attributes : [String : Any] = [NSFontAttributeName : UIFont (name: "beIN-ArabicNormal", size: 12)!]
        self.refreshControlller.addTarget(self, action: #selector(AvailableOrderViewController.didRefreshList), for: .valueChanged)
        self.refreshControlller.tintColor = UIColor(netHex:0x2FAB9B)
        self.refreshControlller.attributedTitle = NSAttributedString(string: "تحديث قائمة الطلبات", attributes: attributes)
    }
    
    
    
    
    func didRefreshList(){
        
        AvailableOrderViewController.Orders = []
        print("AvailableOrderViewController.Orders.count\(AvailableOrderViewController.Orders.count)")
        PageNumber = AvailableOrderViewController.Orders.count + 1
        getOrders()
        self.refreshControlller.endRefreshing()
    }
    
    
    @objc func getOrders()  {
        //let reachability = Reachability()!
        self.statusMsg.isHidden = true
        // Check internet connection
        //when Reachable
        //        reachability.whenReachable = { reachability in
        //
        //            DispatchQueue.main.async {
        //
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        
        self.transporterLoader.TransporterGetOrder{
            
            //AvailableOrderViewController.isPageRefreshing = false
            
            UIViewController.removeSpinner(spinner: sv)
            
            if  AvailableOrderViewController.GetOrderResult == "NotAccepted"
                || AvailableOrderViewController.GetOrderResult == "NotActiveNow" {
                
                let alert = UIAlertController(title: "", message: "لم يتم الموافقة من قبل المسؤول ", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
                
            else if AvailableOrderViewController.GetOrderResult == "NotAccepted"{
                
                let alert = UIAlertController(title: "تحذير", message: "لقد تم الدخول لحسابك من جهاز اخر قم بالاغلاق وحاول لاحقا", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "اغلاق", style: .default, handler: {(alert: UIAlertAction!) in
                    
                    
                    UserDefaults.standard.set(false, forKey: "Transporter_susess_registration")
                     
                    exit(0)
                    
                }))
                self.present(alert, animated: true)
                
            }
            
            
            
            else{
                
                
                
                if AvailableOrderViewController.Orders.count == 0{
                    
                    
                    self.statusMsg.isHidden = false
                    self.orderTable.isHidden = true
                    // self.LoadingView.isHidden = false
                    
                }else{
                    
                    print("AvailableOrderViewController.Orders.count\(AvailableOrderViewController.Orders.count)")
                    
                    self.statusMsg.isHidden = true
                    self.orderTable.isHidden = false
                    self.orderTable.reloadData()
                }
            }
        }
        
    }
    
    
    
    //        // When UnReachable
    //        reachability.whenUnreachable = { reachability in
    //            // this is called on a background thread, but UI updates must
    //            // be on the main thread, like this:
    //            DispatchQueue.main.async {
    //
    //
    //                let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)
    //
    //                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
    //                alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
    //                self.present(alert, animated: true)
    //            }
    //
    //        }
    //
    //        do {
    //            try reachability.startNotifier()
    //        } catch {
    //            print("Unable to start notifier")
    //        }
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        ClearData()
    }
    
    ////////////// //////////// order table  ///////// ///////// ///////// ////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AvailableOrderViewController.Orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"orderCell", for: indexPath) as! AvailableOrderTableViewCell
        print("AvailableOrderViewController.Orders.count\(AvailableOrderViewController.Orders.count)")
        print("indexPath.row\(indexPath.row)")
        

       
        
        if AvailableOrderViewController.Orders.count != 0 {
            
            
          if let orderId = AvailableOrderViewController.Orders[indexPath.row].idOrder{
            
            cell.orderNumber.text = "رقم الطلب :\(orderId)"
            
            }
            
            
            if let delivaryWay = AvailableOrderViewController.Orders[indexPath.row].DeliveryWays {
                
                cell.delivaryWay.text =  getDelivaryWayNameByID(Id: Int(delivaryWay)!)
            }
            
            cell.fromPlace.text =  AvailableOrderViewController.Orders[indexPath.row].FromCity
            cell.toPlace.text = AvailableOrderViewController.Orders[indexPath.row].ToCity
            cell.time.text = AvailableOrderViewController.Orders[indexPath.row].TimeOrder
            cell.date.text = AvailableOrderViewController.Orders[indexPath.row].DateOrder
            cell.submitOfferCostBtn.addTarget(self, action: #selector(submitOfferCostBtnPressed), for: .touchUpInside)
            cell.submitOfferCostBtn.tag = indexPath.row
            cell.orderDetailBtn.tag = indexPath.row
            cell.orderDetailBtn.addTarget(self, action: #selector(ShowOrderDetails), for: .touchUpInside)
            cell.cancelBtn.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(CancelOrderBtnPressed), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 203
    }
    
    ///////////// //////// ///////////// order table  ///////// ///////// ///////// /////////
    
    @objc func submitOfferCostBtnPressed(sender: UIButton!) {
        
        PopUpViewController.OrderID = AvailableOrderViewController.Orders[sender.tag].idOrder!
       
        
        transporterLoader.CheckPriceTrip {
            
            if AvailableOrderViewController.submitCostStatus == "CostNotSend"{
                self.performSegue(withIdentifier: "submitCostSegue", sender: nil)
                
            }
            else{
                self.performSegue(withIdentifier: "checkCostStatus", sender: nil)
            }
        }

        
        
    }
    
    
    @objc func CancelOrderBtnPressed(sender: UIButton!) {
        
        AvailableOrderViewController.Orders.remove(at: sender.tag)
        self.orderTable.reloadData()
        let alert = UIAlertController(title: "", message: "تم اخفاء الطلب بنجاح", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
        self.present(alert, animated: true)
        
        
        
    }
    
    @objc func ShowOrderDetails(sender: UIButton!) {
        
        OrderDetailsViewController.indexNum = "\(OrderDetailsViewController.OrderID)"
        OrderDetailsViewController.OrderID = AvailableOrderViewController.Orders[sender.tag].idOrder!
        print(sender.tag)
        OrderDetailsViewController.pushType = "1"
        performSegue(withIdentifier: "showOrderDetails", sender: nil)
        
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
    
    
    func ClearData()  {
        TransporterLoader.availableOrderFromPlace = []
        TransporterLoader.availableToPlace = []
        TransporterLoader.availableOrderID = []
        
    }
    
    
    func SetUpOriantation()  {
        
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            self.orderTable.semanticContentAttribute = .forceLeftToRight
            
            
            
        }else{
            self.orderTable.semanticContentAttribute = .forceRightToLeft
            
            
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        // pagination
        
        if (orderTable.contentOffset.y >= (self.orderTable.contentSize.height) - (self.orderTable.bounds.size.height))  {


           
            if AvailableOrderViewController.isPageRefreshing == false{

                PageNumber = AvailableOrderViewController.Orders.count + 1

                AvailableOrderViewController.isPageRefreshing = true


                getOrders()


            }
//
        }
        
        
        
    }
    
    
    //back btn pressed
    @IBAction func backBtnPressed(_ sender: Any) {
        // TransporterHomePage
        //        let storyboard = UIStoryboard(name: "BidEngin", bundle: nil)
        //        let initialViewController = storyboard.instantiateViewController(withIdentifier: "AvailableOrder")
        //        UIApplication.shared.windows.first?.rootViewController = initialViewController
        //        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        self.dismiss(animated: true, completion: nil)
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "submitCostSegue"{
            
            _ = segue.destination as?
            PopUpViewController
        }
        
        if segue.identifier == "showOrderDetails"{
            
            _ = segue.destination as?
            OrderDetailsViewController
        }
        
        //checkCostStatus
        if segue.identifier == "checkCostStatus"{
            
            _ = segue.destination as?
            CheckCostPopupViewController
        }
        
        
    }
    
}


