//
//  UserProfileDetailsViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 6/4/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class UserProfileDetailsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    //Outlets
    @IBOutlet weak var DetailTableView: UITableView!
    
    var isExpanding: Bool! = false
    var index: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    ////////////////////// User Details table/////////////////////////
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.row == index , isExpanding == true{
            return 958
        }else{
            return 62
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "userDetails", for: indexPath)
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "workDetails", for: indexPath)
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isExpanding = !isExpanding
        index = indexPath.row
        self.DetailTableView.reloadData()
    }
    
    ////////////////////// User Details table/////////////
    
    // called when back btn pressed
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
