//
//  YSLNoticeAlert.swift
//  YSLNoticeAlertDemo
//
//  Created by yamaguchi on 2015/07/24.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

import UIKit

private let YSLNoticeAlertColorSuccess = UIColor(red: 114 / 255.0, green: 209 / 255.0, blue: 142 / 255.0, alpha: 1.0)
private let YSLNoticeAlertColorFailure = UIColor(red: 215 / 255.0, green: 104 / 255.0, blue: 91 / 255.0, alpha: 1.0)
private let YSLNoticeAlertColorOther = UIColor(red: 89 / 255.0, green: 126 / 255.0, blue: 133 / 255.0, alpha: 1.0)
private let YSLNoticeAleartHeight : CGFloat = 80
private let YSLNoticeLabelMargin : CGFloat = 10

internal enum YSLAlertType : Int {
    case success = 0
    case failure
    case other
}

open class YSLNoticeAlert: UIView {
    
    static var titleFont : UIFont! = UIFont.boldSystemFont(ofSize: 15)
    static var subTitleFont : UIFont! = UIFont.systemFont(ofSize: 13)
    static var titleTextColor : UIColor! = UIColor.white
    static var subTitleTextColor : UIColor! = UIColor.white
    
    fileprivate var titleLabel : UILabel!
    fileprivate var subTitleLabel : UILabel!
    open var callback: (()->Void)?

    init()
    {
        super.init(frame: CGRect.zero)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.commonInit()
    }
    
    // MARK: - Public
    internal func showAlert (title: String?, subTitle: String?, alertType: YSLAlertType) {
        self.title(title, subTitle: subTitle, alertType: alertType, color: nil)
    }
    
    internal func showAlert (title: String?, subTitle: String?, alertType: YSLAlertType, completion: (()->Void)?) {
        self.title(title, subTitle: subTitle, alertType: alertType, color: nil)
        
        if (completion != nil) {
            self.callback = completion
        }
    }
    
    
    internal func showAlert (title: String?, subTitle: String?, color: UIColor) {
        self.title(title, subTitle: subTitle, alertType: YSLAlertType.other, color: color)
    }

    // MARK: - Private
    fileprivate func commonInit () {
        
        let rect = UIScreen.main.bounds
        self.isUserInteractionEnabled = true
        self.frame = CGRect(x: 0, y: -YSLNoticeAleartHeight, width: rect.size.width, height: YSLNoticeAleartHeight)
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: YSLNoticeLabelMargin, y: 30, width: rect.size.width - (YSLNoticeLabelMargin * 2), height: 20);
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = YSLNoticeAlert.titleFont
        titleLabel.textColor = YSLNoticeAlert.titleTextColor
        titleLabel.text = ""
        self.addSubview(titleLabel)
        
        subTitleLabel = UILabel()
        subTitleLabel.frame = CGRect(x: YSLNoticeLabelMargin, y: titleLabel.frame.origin.y + titleLabel.frame.size.height, width: rect.size.width - (YSLNoticeLabelMargin * 2), height: 30)
        subTitleLabel.textAlignment = NSTextAlignment.center
        subTitleLabel.font = YSLNoticeAlert.subTitleFont
        subTitleLabel.textColor = YSLNoticeAlert.subTitleTextColor
        subTitleLabel.numberOfLines = 0
        subTitleLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        subTitleLabel.text = ""
        self.addSubview(subTitleLabel)
        
        let window = UIApplication.shared.windows.first
        window!.addSubview(self)
        
        titleLabel.backgroundColor = UIColor.clear
        subTitleLabel.backgroundColor = UIColor.clear
        self.backgroundColor = YSLNoticeAlertColorOther
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YSLNoticeAlert.dissmissAlertHandler))
        self.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func title (_ title: String?, subTitle: String?, alertType: YSLAlertType, color: UIColor?) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        
        switch alertType {
        case .success:
            self.backgroundColor = YSLNoticeAlertColorSuccess
        case .failure:
            self.backgroundColor = YSLNoticeAlertColorFailure
        case .other:
            self.backgroundColor = YSLNoticeAlertColorOther
        }
        
        if color != nil {
            self.backgroundColor = color
        }
      
        if title == nil || title!.isEmpty {
            subTitleLabel.frame.origin.y = (self.frame.size.height / 2)
        }
        
        if subTitle ==  nil || subTitle!.isEmpty {
            titleLabel.frame.origin.y = (self.frame.size.height / 2)
        }
        
        let rect = UIScreen.main.bounds
        // Show Animation
        UIView.animate(withDuration: 0.25,delay: 0.0, options: UIView.AnimationOptions(),
            animations: { () -> Void in
            self.frame = CGRect(x: 0, y: 0, width: rect.size.width, height: YSLNoticeAleartHeight)
            }) {(finished) -> Void in
        }

        // Dismiss Animation
        Timer.scheduledTimer(timeInterval: 2.0,
            target: self,
            selector: #selector(YSLNoticeAlert.dissmissAlert),
            userInfo: nil,
            repeats: false)
    }
    
    @objc fileprivate func dissmissAlertHandler () {
        if ((self.callback) != nil) {
            self.callback!()
        }
        self.dissmissAlert()
    }
    
    @objc fileprivate func dissmissAlert () {
                
        if titleLabel != nil {
            let rect = UIScreen.main.bounds
            UIView.animate(withDuration: 0.25,delay: 0.0, options: UIView.AnimationOptions(),
                animations: { () -> Void in
                    self.frame = CGRect(x: 0, y: -YSLNoticeAleartHeight, width: rect.size.width, height: YSLNoticeAleartHeight)
                }) { (finished) -> Void in
                    self.titleLabel = nil
                    self.subTitleLabel = nil;
                    self.removeFromSuperview()
            }
        }
    }
}

