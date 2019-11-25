//
//  CancelOrderPopUPViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 8/28/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class CancelOrderPopUPViewController: UIViewController {

    @IBOutlet weak var submitBtn: RoundedBtn!
    @IBOutlet weak var cancelBtn: RoundedBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
        setUpUI()

       
    }

    @IBAction func saveBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CancelBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Configure UI
    func setUpUI()  {
        self.submitBtn.layer.borderWidth = 0.5
        self.submitBtn.layer.cornerRadius = 10
        self.submitBtn.layer.borderColor = UIColor.white.cgColor
        self.cancelBtn.layer.borderWidth = 0.5
        self.cancelBtn.layer.cornerRadius = 10
        self.cancelBtn.layer.borderColor = UIColor.white.cgColor
    }
    
    // Show PopUp
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    // Remove PopUp
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                //self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
}
