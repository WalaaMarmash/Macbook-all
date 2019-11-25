//
//  PreviousViewController.swift
//  TOGOClient
//
//  Created by Fratello Software Group on 9/23/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift

class PreviousViewController:  UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
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
     static var isPageRefreshing: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTable.tableFooterView = UIView()
        self.orderTable.allowsSelection = false
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     }
    
    
    override func viewDidAppear(_ animated: Bool) {
       
        self.statusMsg.isHidden = true
        
        PreviousViewController.Orders = []
        HistoryPageNumber = PreviousViewController.Orders.count + 1
        //        //when Reachable
        //        reachability.whenReachable = { reachability in
        //
        //            DispatchQueue.main.async {
        self.getOrders()
        //            }
        //
        //        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PreviousViewController.Orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath) as!PreviousOrdersTableViewCell
        
            if PreviousViewController.Orders.count != 0 {
        cell.OrderNumber.text = "رقم الطلب :\(indexPath.row + 1)"
        cell.date.text = PreviousViewController.Orders[indexPath.row].DateOrder
        
        cell.delivaryWay.text =  getDelivaryWayNameByID(Id: Int(PreviousViewController.Orders[indexPath.row].DeliveryWays!)!)
        
        cell.time.text = PreviousViewController.Orders[indexPath.row].TimeOrder
        
        cell.orderDetails.tag = indexPath.row
        cell.orderDetails.addTarget(self, action: #selector(ShowOrderDetails), for: .touchUpInside)
        
       // cell.cancelOrderBtn.tag = indexPath.row
     //   cell.cancelOrderBtn.addTarget(self, action: #selector(CancelOrderBtnPressed), for: .touchUpInside)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        // pagination
        
        if (orderTable.contentOffset.y >= (self.orderTable.contentSize.height) - (self.orderTable.bounds.size.height)){
            
            
            if PreviousViewController.isPageRefreshing == false{
                
                HistoryPageNumber = PreviousViewController.Orders.count + 1
                PreviousViewController.isPageRefreshing = true
                //
                //                    if AvailableOrderViewController.Orders.count > 9 {
                //
                //                        PreviousPageNumber = PreviousPageNumber +  1
                //                        CuurentPageNumber = PreviousPageNumber
                //                        PageNumber = CuurentPageNumber
                //
                //
                //                    }else{
                //                        PageNumber = PreviousPageNumber
                //
                //                    }
                
                getOrders()
                
            }
            
        }
        
        
        
    }
    
    
    
    @objc func ShowOrderDetails(sender: UIButton!) {
        
        OrderDetailsViewController.indexNum = "\(PreviousViewController.Orders[sender.tag].idOrder!)"
        OrderDetailsViewController.OrderID = PreviousViewController.Orders[sender.tag].idOrder!
        print(OrderDetailsViewController.OrderID)
        OrderDetailsViewController.pushType = "2"
        performSegue(withIdentifier: "ShowOrderDetails", sender: nil)
        
    }
    
    
    
    @objc func CancelOrderBtnPressed(sender: UIButton!) {
        
        TransporterLoader.CancelOrderId = PreviousViewController.Orders[sender.tag].idOrder!

        self.LoadingView.isHidden = false
        self.showActivityIndicator(uiView: self.LoadingView)

       self.transporterLoader.TransporterDeleteOrder {


            self.LoadingView.isHidden = true
            self.hideActivityIndicator(uiView: self.LoadingView)

            if TransporterLoader.CancelOrderResult ==  "OrderDeletedSuccess"{

                PreviousViewController.Orders.remove(at: sender.tag)
                self.orderTable.reloadData()

                let alert = UIAlertController(title: "", message: "تم حذف الطلب بنجاح", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{

                let alert = UIAlertController(title: "", message: TransporterLoader.CancelOrderResult, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
            }

        }
//
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
        
        self.transporterLoader.TransporterHistoryOrder {
       
            
            
            self.LoadingView.isHidden = true
            self.hideActivityIndicator(uiView: self.LoadingView)
            
            if PreviousViewController.Orders.count == 0{
                self.statusMsg.isHidden = false
                self.orderTable.isHidden = true
                
                
            }else{
                
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
            OrderDetailsViewController
        }
    }
    
}
