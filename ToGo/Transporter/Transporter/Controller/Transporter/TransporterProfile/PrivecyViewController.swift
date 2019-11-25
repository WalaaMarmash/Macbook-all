//
//  PrivecyViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 8/28/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit

class PrivecyViewController: UIViewController {

    
    @IBOutlet weak var PrivecyCheckbox: UIView!
    let tickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUPCheckBox()
       
    }

    func SetUPCheckBox()  {
        tickBox.borderStyle = .square
        tickBox.checkmarkStyle = .tick
        tickBox.checkmarkSize = 0.7
        tickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        PrivecyCheckbox.addSubview(tickBox)
        tickBox.tag = 2
        tickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
    }

    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        print(sender.tag)
    }
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        if tickBox.isChecked == true{
            self.performSegue(withIdentifier: "privecySegue", sender: nil)
            
        }
        else{
            let alert = UIAlertController(title: "", message: "الرجاء الموافقة على سياسة الخصوصية", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "موافق", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "privecySegue"{
            
            _ = segue.destination as?
            UserDetailViewController
        }
    }
}
