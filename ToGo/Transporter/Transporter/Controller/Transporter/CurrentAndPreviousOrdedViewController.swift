//
//  CurrentAndPreviousOrdedViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/16/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class CurrentAndPreviousOrdedViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
 
    

    @IBOutlet weak var OrderSwitcher: UISegmentedControl!
    @IBOutlet weak var orderTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpOriantation()
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var returnNumber = 0
        
        switch OrderSwitcher.selectedSegmentIndex {
        case 0:
            returnNumber = 5
           break
        case 1:
           returnNumber = 6
            break
        default:
            returnNumber = 6
            break
        }
        return returnNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"orderCell", for: indexPath) as! ordersTableViewCell
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(carImageimageTapped(tapGestureRecognizer:)))
        cell.cancelOrderBtn.isUserInteractionEnabled = true
        cell.cancelOrderBtn.addGestureRecognizer(tapGestureRecognizer)
       
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    
    @objc func carImageimageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "cancelOrderSegue", sender: nil)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func SetUpOriantation()  {
        
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            self.orderTable.semanticContentAttribute = .forceLeftToRight
            
            OrderSwitcher.semanticContentAttribute = .forceRightToLeft
            
        }else{
            self.orderTable.semanticContentAttribute = .forceRightToLeft
            
            OrderSwitcher.semanticContentAttribute = .forceLeftToRight
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cancelOrderSegue"{
            
            _ = segue.destination as?
            CancelOrderPopUPViewController
        }
        
    }
}
