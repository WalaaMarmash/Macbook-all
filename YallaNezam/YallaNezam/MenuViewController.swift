//
//  MenuViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/19/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet var tapOutSide: UITapGestureRecognizer!
    
     var flagmenue = false
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var changePassBtn: UIButton!
    
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //   view?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
     
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareBtn(_ sender: Any) {
     
//            //if let name = NSURL(string: "https://itunes.apple.com/us/app/myapp/id1274063330?ls=1&mt=8") {
//            if let name = NSURL(string: "") {
//                let objectsToShare = [name]
//                //            let text = "http://google.com"
//                let shareViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
//                if let popoverPresentationController = shareViewController.popoverPresentationController {
//                    popoverPresentationController.sourceView = self.view
//                    popoverPresentationController.sourceRect = CGRect(x: self.view.frame.width/2, y: 0, width: 0, height: 0)
//                }
//                
//                self.present(shareViewController, animated: true, completion: nil)
//                
//                
//            }
        
    }
    
    @IBAction func tapOutside(_ sender: Any) {
        view.isHidden = true
        flagmenue = false
    }
    
    
    @IBAction func settingsBtn(_ sender: Any) {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        print("oooout")
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func changePassBtn(_ sender: Any) {
        let vc = ChangePassViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
