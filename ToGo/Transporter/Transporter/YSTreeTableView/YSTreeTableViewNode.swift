//
//  YSTreeTableViewNode.swift
//  YSTreeTableView
//
//  Created by yaoshuai on 2017/1/10.
//  Copyright © 2017年 ys. All rights reserved.
//

import UIKit

/// node type
class YSTreeTableViewNode: NSObject {
    
    ///  - nil
    var parentNode:YSTreeTableViewNode?{
        didSet{
            if let parentN = parentNode, !parentN.subNodes.contains(self) {
                parentN.subNodes.append(self)
            }
        }
    }
    
    
    var subNodes:[YSTreeTableViewNode] = [YSTreeTableViewNode](){
        didSet{
            for childNode in subNodes{
                childNode.parentNode = self
            }
        }
    }
    
    /// nodeID
    var nodeID:UInt = 0
    
    /// nodeName
    var nodeName:String = ""
    
    /// leftImageName
    var leftImageName:String = ""
    
    /// rightImageName
    var rightImageName:String = ""
    
    /// isExpand
    var isExpand:Bool = false
    
    ///
    var depth:Int{
        if let parentN = parentNode{
            return parentN.depth + 1
        }
        return 0
    }
    
    ///
    private override init(){
        super.init()
    }
    
    ///
    ///
    /// - Parameters:
    ///   - parentNodeID: 父节点ID(>=-1，-1表示根节点)
    ///   - nodeID: 本节点ID(>=0)
    ///   - nodeName: 本节点名称(!="")
    ///   - leftImageName: 左侧图标
    ///   - rightImageName: 右侧图标
    ///   - isExpand: 本节点是否处于展开状态
    convenience init?(nodeID:UInt,nodeName:String,leftImageName:String,rightImageName:String,isExpand:Bool){
        
        self.init()
        
        
        self.nodeID = nodeID
        self.nodeName = nodeName
        self.leftImageName = leftImageName
        self.rightImageName = rightImageName
        self.isExpand = isExpand
        
    }
    
    ///
    ///
    /// - Parameter childNode:
    func addChildNode(childNode:YSTreeTableViewNode){
        childNode.parentNode = self
    }
}
