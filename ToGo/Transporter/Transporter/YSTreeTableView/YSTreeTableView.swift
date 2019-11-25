  //
//  YSTreeTableView.swift
//  YSTreeTableView
//
//  Created by yaoshuai on 2017/1/10.
//  Copyright © 2017年 ys. All rights reserved.
//

import UIKit

private let YSTreeTableViewNodeCellID:String = "YSTreeTableViewNodeCellID"
private let YSTreeTableViewContentCellID:String = "YSTreeTableViewContentCellID"

private var YSTreeTableViewNodeCellHeight:CGFloat = 80
private var YSTreeTableViewContentCellHeight:CGFloat = 80



protocol YSTreeTableViewDelegate:NSObjectProtocol {
    
    func treeCellClick(node:YSTreeTableViewNode,indexPath:IndexPath)
}


class YSTreeTableView: UITableView {
    
    var treeDelegate:YSTreeTableViewDelegate?
    
    
    var rootNodes:[YSTreeTableViewNode] = [YSTreeTableViewNode](){
        didSet{
            getExpandNodeArray()
            reloadData()
        }
    }
    
    
    fileprivate var tempNodeArray:[YSTreeTableViewNode] = [YSTreeTableViewNode]()
    
    
    fileprivate var insertIndexPaths:[IndexPath] = [IndexPath]()
    private var insertRow = 0
    
    
    fileprivate var deleteIndexPaths:[IndexPath] = [IndexPath]()
    
    override init(frame:CGRect, style: UITableViewStyle){
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    // Setup menu table
    private func setupTableView(){
        dataSource = self
        delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            YSTreeTableViewNodeCellHeight = 50
            YSTreeTableViewContentCellHeight = 50
        }
        else{
            YSTreeTableViewNodeCellHeight = 70
            YSTreeTableViewContentCellHeight = 70
        }
        
        
        
        
//        let lan: String = UserDefaults.standard.string(forKey: "Language")!
//
//        switch lan {
//        case MainNewsViewController.arabic:
        
            self.semanticContentAttribute = .forceRightToLeft
            
//            break
//
//        case MainNewsViewController.english:
//            self.semanticContentAttribute = .forceLeftToRight
//            break
//
//        case MainNewsViewController.france:
//            self.semanticContentAttribute = .forceLeftToRight
//            break
//        default:
//            break
        
      //  }
        
//        if UIView.appearance().semanticContentAttribute == .forceRightToLeft , lan ==  MainNewsViewController.english{
//            
//            
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            
//            
//        }
//
//        if UIView.appearance().semanticContentAttribute == .forceLeftToRight , lan ==  MainNewsViewController.arabic{
//            
//            
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            
//            
//        }
          
        self.separatorStyle = .none
        register(YSTreeTableViewNodeCell.self, forCellReuseIdentifier: YSTreeTableViewNodeCellID)
        register(YSTreeTableViewContentCell.self, forCellReuseIdentifier: YSTreeTableViewContentCellID)
    }
    
    
    
    ///
    /// - Parameters:
    ///   - node:
    private func addExpandNodeToArray(node:YSTreeTableViewNode) -> Void{
        tempNodeArray.append(node)
        
        if node.isExpand{ // check if the node expanded
            for childNode in node.subNodes{
                addExpandNodeToArray(node: childNode)
            }
        }
    }
    
    
    private func getExpandNodeArray() -> (){
        for rootNode in rootNodes{
            if rootNode.parentNode == nil{ // root node
                addExpandNodeToArray(node: rootNode)
            }
        }
    }
    
    
    ///
    /// - Parameter node:
    /// - Returns: true；false
    fileprivate func isLeafNode(node:YSTreeTableViewNode) -> Bool{
        return node.subNodes.count == 0
    }
    
    
    
    ///
    /// - Parameter node:
    fileprivate func insertChildNode(node:YSTreeTableViewNode){
        node.isExpand = true
        if node.subNodes.count == 0{
            return
        }
        
        insertRow = tempNodeArray.index(of: node)! + 1
        
        for childNode in node.subNodes{
            let childRow = insertRow
            let childIndexPath = IndexPath(row: childRow, section: 0)
            insertIndexPaths.append(childIndexPath)
            
            tempNodeArray.insert(childNode, at: childRow)
            
            insertRow += 1
            if childNode.isExpand{
                insertChildNode(node: childNode)
            }
        }
    }
    
    
    ///
    /// - Parameter node:
    fileprivate func getDeleteIndexPaths(node:YSTreeTableViewNode){
        if node.isExpand{ // check if the node expanded
            
            for childNode in node.subNodes{
                let childRow = tempNodeArray.index(of: childNode)!
                let childIndexPath = IndexPath(row: childRow, section: 0)
                deleteIndexPaths.append(childIndexPath)
                
                if childNode.isExpand{
                    getDeleteIndexPaths(node: childNode)
                }
            }
        }
    }
    
    
    ///
    /// - Parameter node:
    fileprivate func deleteChildNode(node:YSTreeTableViewNode){
        getDeleteIndexPaths(node: node)
        
        node.isExpand = false
        
        for _ in deleteIndexPaths{
            tempNodeArray.remove(at: deleteIndexPaths.first!.row)
        }
    }
}


extension YSTreeTableView:UITableViewDataSource,UITableViewDelegate{
    
    
    
    // MARK: - cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempNodeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node = tempNodeArray[indexPath.row]
        
        
        if isLeafNode(node: node){ // cell
            let cell:YSTreeTableViewNodeCell = tableView.dequeueReusableCell(withIdentifier: YSTreeTableViewNodeCellID, for: indexPath) as! YSTreeTableViewNodeCell
            
            cell.node = node
          //cell.selectionStyle = .none
            switch node.nodeID {
                

               
//            case 1:
//                let View = UIView()
//                let imageName = "icons8-Collapse Arrow-50"
//                let image = UIImage(named: imageName)
//                let imageView = UIImageView(image: image!)
//                imageView.frame = CGRect(x: -5, y: -8, width: 15, height: 15)
//                View.addSubview(imageView)
//                cell.accessoryView = View
//                break
//

            default:
                break
            }
            
            return cell
        }
            
        else{ // cell
            let cell:YSTreeTableViewContentCell = tableView.dequeueReusableCell(withIdentifier: YSTreeTableViewContentCellID, for: indexPath) as! YSTreeTableViewContentCell
            cell.node = node
           // cell.selectionStyle = .none
            
            switch node.nodeID {
                
//
            case 1:
                let View = UIView()
                let imageName = "icons8-Collapse Arrow-50"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                imageView.frame = CGRect(x: -5, y: -8, width: 15, height: 15)
                View.addSubview(imageView)
                cell.accessoryView = View
                break



            default:
                break
            }
            
            
            return cell
        }
    }
    
    
    
    // MARK: -
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let node = tempNodeArray[indexPath.row]
        
        if node.nodeID == 0{
            return 0
        }
        
        if isLeafNode(node: node){ // cell
            return YSTreeTableViewContentCellHeight
        } else{ // cell
            return YSTreeTableViewNodeCellHeight
        }
    }
    
    // MARK:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  MenuViewController.index = indexPath.row
        let index = IndexPath(item: 1, section: 0)
        let cell = tableView.cellForRow(at: index)
        
        
        
      
        
        let node = tempNodeArray[indexPath.row]
        treeDelegate?.treeCellClick(node: node, indexPath: indexPath)
        
      
        
        if node.nodeID == 1{
            
            
            
            let compassindex = IndexPath(item: 1, section: 0)
            let compassCell = tableView.cellForRow(at: compassindex)
            
            if node.isExpand{
                
           
                let View = UIView()
                let imageName = "icons8-Collapse Arrow-50"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)

                imageView.frame = CGRect(x: -5, y: -8, width: 15, height: 15)
                View.addSubview(imageView)

                compassCell?.accessoryView = View
            }
                
            else{
                UIView.animate(withDuration: 0.25 , animations: {
                    compassCell?.accessoryView?.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                })

            }
            
            
            
        }
        
        
        
        if isLeafNode(node: node){ // cell
            return
        } else{ // cell
            if node.isExpand{
                deleteIndexPaths = [IndexPath]()
                deleteChildNode(node: node)
                deleteRows(at: deleteIndexPaths, with: .top)
            }
            else{
                insertIndexPaths = [IndexPath]()
                insertChildNode(node: node)
                insertRows(at: insertIndexPaths, with: .top)
            }
        }
    }
    
    
}
