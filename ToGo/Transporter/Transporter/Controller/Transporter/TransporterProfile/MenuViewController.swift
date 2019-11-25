 //
 //  MenuViewController.swift
 //  ToGo
 //
 //  Created by Fratello Software Group on 5/17/18.
 //  Copyright © 2018 yara. All rights reserved.
 //
 
 import UIKit
 
 class MenuViewController: UIViewController {
    
    // menu tableView
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var MenuTable: YSTreeTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMenuTable()
        // SetUpOriantation()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MenuTable.reloadData()
    }
    
    // setUp Menu Table
    func setUpMenuTable() {
        self.setUpMenuTable( MenuTable: self.MenuTable)
        self.MenuTable.treeDelegate = self
    }
    
    // Configure ui Oriantation
    func SetUpOriantation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            self.menuTableView.semanticContentAttribute = .forceLeftToRight
        }else{
            self.menuTableView.semanticContentAttribute = .forceRightToLeft
        }
    }
    
    
    func setUpMenuTable( MenuTable: YSTreeTableView){
        
        let root = YSTreeTableViewNode(nodeID: 0, nodeName: "", leftImageName: "", rightImageName: "", isExpand: true)!
        let AccountDetails = YSTreeTableViewNode(nodeID: 1, nodeName: "تفاصيل الحساب", leftImageName: "", rightImageName: "To Go picture-24", isExpand: false)!
        let ShareApp = YSTreeTableViewNode(nodeID: 2, nodeName: "شارك التطبيق", leftImageName: "", rightImageName: "To Go picture-26", isExpand: false)!
        let About = YSTreeTableViewNode(nodeID: 3, nodeName: "معلومات عن التطبيق", leftImageName: "", rightImageName: "To Go picture-27", isExpand: false)!
        let langugeSetting = YSTreeTableViewNode(nodeID: 4, nodeName: "اختيار اللغة", leftImageName: "", rightImageName: "To Go picture-39", isExpand: false)!
        
        
        let compass1 = YSTreeTableViewNode(nodeID: 11, nodeName: "بيانات شخصية", leftImageName: "", rightImageName: "", isExpand: false)!
        
        let compass2 = YSTreeTableViewNode(nodeID: 12, nodeName: "بيانات المركبة", leftImageName: "", rightImageName: "", isExpand: false)!
        
         let compass3 = YSTreeTableViewNode(nodeID: 13, nodeName: "بيانات الاعمال", leftImageName: "", rightImageName: "", isExpand: false)!
        
        let rootNodes = [root]
        root.addChildNode(childNode: AccountDetails)
        root.addChildNode(childNode: ShareApp)
        root.addChildNode(childNode: About)
        root.addChildNode(childNode: langugeSetting)
        
        
        AccountDetails.addChildNode(childNode: compass1)
        AccountDetails.addChildNode(childNode: compass2)
        AccountDetails.addChildNode(childNode: compass3)
        
        
        MenuTable.rootNodes = rootNodes
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "aboutSegue"{
            
            _ = segue.destination as?
            AboutViewController
        }
//        if segue.identifier == "personalUpdate"{
//
//            _ = segue.destination as?
//            ClinetPersonalInfoViewController
//        }
//        if segue.identifier == "workUpdate"{
//
//            _ = segue.destination as?
//            ClientWorkDetailsViewController
//
//        }
        
        
        
    }
    
 }
 
 
 extension MenuViewController:YSTreeTableViewDelegate{
    
    // Menu item Selected
    func treeCellClick(node: YSTreeTableViewNode, indexPath: IndexPath) {
        
        if node.nodeID == 3{
            self.performSegue(withIdentifier: "aboutSegue", sender: nil)
        }
        if node.nodeID == 11{
           // self.performSegue(withIdentifier: "personalUpdate", sender: nil)
            
        }
        if node.nodeID == 12{
            //self.performSegue(withIdentifier: "workUpdate", sender: nil)
            
        }
        if node.nodeID == 13{
            //self.performSegue(withIdentifier: "workUpdate", sender: nil)
            
        }
    }
 }
