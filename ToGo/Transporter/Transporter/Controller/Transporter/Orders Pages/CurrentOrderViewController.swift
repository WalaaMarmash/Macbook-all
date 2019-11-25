//
//  CurrentOrderViewController.swift
//  TOGOClient
//
//  Created by Fratello Software Group on 9/23/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class CurrentOrderViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var statusMsg: UILabel!
    @IBOutlet weak var LoadingView: UIView!
    
     let reachability = Reachability()!
    var transporterLoader = TransporterLoader()
    var container: UIView = UIView()
    var loadingview: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    let View = UIView()
    static var Orders = [OrdersModel]()
    
    @IBOutlet weak var deductionWorningPopup: RoundedBtn!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
          self.orderTable.allowsSelection = false
        orderTable.tableFooterView = UIView()


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.statusMsg.isHidden = true
        //        //when Reachable
        //        reachability.whenReachable = { reachability in
        //
        //            DispatchQueue.main.async {
        self.getOrders()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentOrderViewController.Orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath) as!CurrentOrdersTableViewCell
        
        cell.OrderNumber.text = "رقم الطلب :\(CurrentOrderViewController.Orders[indexPath.row].idOrder!)"
        cell.date.text = CurrentOrderViewController.Orders[indexPath.row].DateOrder
        
        cell.delivaryWay.text =  getDelivaryWayNameByID(Id: Int(CurrentOrderViewController.Orders[indexPath.row].DeliveryWays!)!)
        
        cell.time.text = CurrentOrderViewController.Orders[indexPath.row].TimeOrder
       
        cell.orderDetails.tag = indexPath.row
        cell.orderDetails.addTarget(self, action: #selector(ShowOrderDetails), for: .touchUpInside)
        
        cell.cancelOrderBtn.tag = indexPath.row
        cell.cancelOrderBtn.addTarget(self, action: #selector(CancelOrderBtnPressed), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    
    
    
    @objc func ShowOrderDetails(sender: UIButton!) {
        
         OrderDetailViewController.indexNum = "\(CurrentOrderViewController.Orders[sender.tag].idOrder!)"
        
       OrderDetailViewController.OrderID = CurrentOrderViewController.Orders[sender.tag].idOrder!
//        print(sender.tag)
         performSegue(withIdentifier: "ShowOrderDetails", sender: nil)
        
    }
    
  
    
    @IBAction func confirmCancelOrder(_ sender: UIButton) {
        
        cancelOrder(index: sender.tag)
        
    }
    
    @IBAction func removeCancelOrderPopup(_ sender: Any) {
        self.deductionWorningPopup.isHidden = true
    }
    
    
    func cancelOrder(index: Int) {
        
        TransporterLoader.CancelOrderId = CurrentOrderViewController.Orders[index].idOrder!
        
        self.LoadingView.isHidden = false
        self.showActivityIndicator(uiView: self.LoadingView)
        
        self.transporterLoader.TransporterDeleteOrder {
            
            
            
            self.LoadingView.isHidden = true
            self.hideActivityIndicator(uiView: self.LoadingView)
            
            if TransporterLoader.CancelOrderResult.contains("OrderDeletedSuccess"){
                
                CurrentOrderViewController.Orders.remove(at: index)
                self.orderTable.reloadData()
                
                let alert = UIAlertController(title: "", message: "تم حذف الطلب بنجاح", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
                self.deductionWorningPopup.isHidden = true
            }else{
                
                let alert = UIAlertController(title: "", message: TransporterLoader.CancelOrderResult, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
                self.deductionWorningPopup.isHidden = true
            }
            
        }
    }
    
    
    
    @objc func CancelOrderBtnPressed(sender: UIButton!) {
        
       self.deductionWorningPopup.isHidden = false
    }
    
    
    
    
    func SetUpOriantation()  {
        
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            self.orderTable.semanticContentAttribute = .forceLeftToRight
            
           
            
        }else{
            self.orderTable.semanticContentAttribute = .forceRightToLeft
            
           
            
        }
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
    
    
    func getOrders()  {
        
        self.LoadingView.isHidden = false
        self.showActivityIndicator(uiView: self.LoadingView)
        
        self.transporterLoader.TransporterOrderCurrent {
        
            
            self.LoadingView.isHidden = true
            self.hideActivityIndicator(uiView: self.LoadingView)
            
            if CurrentOrderViewController.Orders.count == 0{
                self.statusMsg.isHidden = false
                self.orderTable.isHidden = true
               
                
            }else{
                AppDelegate.Transportlocation.startUpdatingLocation()
                self.statusMsg.isHidden = true
                self.orderTable.isHidden = false
                self.orderTable.reloadData()
            }
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        if segue.identifier == "ShowOrderDetails"{
            
            _ = segue.destination as?
            OrderDetailViewController
        }
    }
    
}
