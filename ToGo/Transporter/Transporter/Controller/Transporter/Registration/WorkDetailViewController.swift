//
//  WorkDetailViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/17/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import CZPicker
import ReachabilitySwift
import GoogleMaps
import SwiftyJSON
import WWCalendarTimeSelector

 class WorkDetailViewController: UIViewController,UITextFieldDelegate,WWCalendarTimeSelectorProtocol {

    @IBOutlet weak var checkbox: UIView!
    @IBOutlet weak var WeekDayCheckbox: UIView!
    @IBOutlet weak var weekDayStack: UIStackView!
   // @IBOutlet weak var detailTextField: UITextView!
    
    @IBOutlet weak var allDayToTextField: UITextField!
    @IBOutlet weak var allDayFromTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet var uiLable: [UILabel]!
    @IBOutlet var uiStack: [UIStackView]!
    @IBOutlet weak var verticalSpace: NSLayoutConstraint!
    @IBOutlet weak var MapView: GMSMapView!
    
    @IBOutlet var fromTextField: [UITextField]!
    var textFieldIndex: Int! = 0
    
    let tickBox3 = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let tickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

    // Internet Connection
    let reachability = Reachability()!
    // ActivityIndicator
  
    
    
    var fruits = [String]()
    var fruitImages = [UIImage]()
    var pickerWithImage: CZPickerView?
    
    var transporterLoader = TransporterLoader()
    var _PlaceList = [PlaceListResultModel]()
    var _TransporterResult = [WorkTranspoterModel]()
  
    var choosenTimeWork:NSMutableDictionary = NSMutableDictionary()
    var dictionaryPlaceList = [String : [AnyObject]]()
    var dictionaryTimeWork = [String : [AnyObject]]()
    var DateStr: [String]!
   
    @IBOutlet weak var DateView: CustomPopupView!
    @IBOutlet weak var datePicker: UIDatePicker!
   @IBOutlet weak var showMap: UIImageView!
    
    //week day CheckBox
    @IBOutlet weak var satrdayCheckBox: UIView!
    @IBOutlet weak var sundayCheckBox: UIView!
    @IBOutlet weak var mondayCheckBox: UIView!
    @IBOutlet weak var theusdayCheckBox: UIView!
    @IBOutlet weak var wednsdayCheckBox: UIView!
    @IBOutlet weak var thidsdayCheckBox: UIView!
    @IBOutlet weak var fridayCheckBox: UIView!
    let satrdaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let sundaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let mondaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let theusdaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let wednsdaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let thidsdaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let fridaytickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        self.datePicker.locale = Locale(identifier: "en_GB")
        datePicker.datePickerMode = UIDatePickerMode.time
        DateStr = []
        setUpUI()
        verticalSpace.constant = 5
       // SetUpOriantation()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMapTapped(tapGestureRecognizer:)))
        showMap.isUserInteractionEnabled = true
        showMap.addGestureRecognizer(tapGestureRecognizer)
        
        dictionaryPlaceList["TransportrCity"] = []
        dictionaryTimeWork["TransportrTime"] = []
        
        // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {

                 let sv = UIViewController.displaySpinner(onView: self.view)
                self.transporterLoader.GetCityRegion{

                    self._PlaceList = self.transporterLoader.placeList

                    UIViewController.removeSpinner(spinner: sv)

                }

            }


        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {


                let alert = UIAlertController(title: ar_error_title, message: ar_error_message, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: ar_no, style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }

        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }


        

    }
  
    @objc func showMapTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "showMapView", sender: nil)
        
    }
    

    
    
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textField//
    
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeStyle = DateFormatter.Style.long
//
//        print(sender.date)
//
//        let strDate = dateFormatter.string(from: sender.date)
//        let TimeStr = strDate.dropLast().dropLast().dropLast().dropLast().dropLast()
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        let strDate = dateFormatter.string(from: sender.date)
        print(strDate)
        
        
            if textFieldIndex == 15{
                allDayFromTextField.text = String(strDate)
            }else if  textFieldIndex == 16{
                allDayToTextField.text = String(strDate)
            }else{
            fromTextField[textFieldIndex].text = String(strDate)
        }
   }
    
      @IBAction func submitBtnClicked(_ sender: Any) {
        
      
        
        print(MapViewController._PlaceList.count)
        if MapViewController._PlaceList.count == 0{
            let alert = UIAlertController(title: "", message: "الرجاء اختيار المدن ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                     self.present(alert, animated: true)
        }
            
            
        else if tickBox3.isChecked{
            print("كل الايام")
            if (allDayFromTextField.text == "" && allDayToTextField.text != "") || (allDayFromTextField.text != "" && allDayToTextField.text == ""){
                let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            else{
              
                    CreatechoosenTimeArray(allTimeFlag : "1")
                    TransporterLoader.choosenPlaceList = self.dictionaryPlaceList
                
                let sv = UIViewController.displaySpinner(onView: self.view)
                
                    transporterLoader.SetWorkTranspoterParameter{
                       UIViewController.removeSpinner(spinner: sv)
                        
                        self._TransporterResult = TransporterLoader._WorkTranspoterResult
                        var statusCity = ""
                        var statusWork = ""
                        
                        for item in (TransporterLoader._WorkTranspoterResult){
                            
                            print("item.StatusCity\(String(describing: item.StatusCity!))")
                            print("StatusWork\(String(describing: item.StatusWork!))")
                            
                            statusCity = String(describing: item.StatusCity!)
                            statusWork = String(describing: item.StatusWork!)
                        }
                        
                        if statusCity == "4" || statusWork == "4"{
                            let alert = UIAlertController(title: "", message: "اعد المحاولة مرة اخرى", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                       
                            
                        else{
                            print("next page")
                            self.performSegue(withIdentifier: "BusnissInfoSegue", sender: nil)
                            UserDefaults.standard.set(true, forKey: "Transporter_susess_registration")
                            print("next to home page ")
                        }
                        
                        
                }
               
            }
            
        }
            
            
        else if tickBox.isChecked {
              print("ايام الاسبوع")
            if satrdaytickBox.isChecked{
                
                
                if (fromTextField[0].text == "" && fromTextField[1].text != "") || (fromTextField[0].text != "" && fromTextField[1].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if sundaytickBox.isChecked{
                if (fromTextField[2].text == "" && fromTextField[3].text != "") || (fromTextField[2].text != "" && fromTextField[3].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if mondaytickBox.isChecked{
                if (fromTextField[4].text == "" && fromTextField[5].text != "") || (fromTextField[4].text != "" && fromTextField[5].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if theusdaytickBox.isChecked{
                if (fromTextField[6].text == "" && fromTextField[7].text != "") || (fromTextField[6].text != "" && fromTextField[7].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if wednsdaytickBox.isChecked{
                if (fromTextField[8].text == "" && fromTextField[9].text != "") || (fromTextField[8].text != "" && fromTextField[9].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if thidsdaytickBox.isChecked{
                if (fromTextField[10].text == "" && fromTextField[11].text != "") || (fromTextField[10].text != "" && fromTextField[11].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            if fridaytickBox.isChecked{
                if (fromTextField[12].text == "" && fromTextField[13].text != "") || (fromTextField[12].text != "" && fromTextField[13].text == ""){
                    let alert = UIAlertController(title: "", message: "الرجاء التاكد من البيانات المدخلة", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
            
            else{
                CreatechoosenTimeArray(allTimeFlag : "0")
                TransporterLoader.choosenPlaceList = self.dictionaryPlaceList
                
                
                 let sv = UIViewController.displaySpinner(onView: self.view)
                transporterLoader.SetWorkTranspoterParameter{
                    
                   UIViewController.removeSpinner(spinner: sv)
                    
                    self._TransporterResult = TransporterLoader._WorkTranspoterResult
                    
                    var statusCity = ""
                    var statusWork = ""
                 
                    for item in (TransporterLoader._WorkTranspoterResult){
                        
                        print("item.StatusCity\(String(describing: item.StatusCity!))")
                        print("StatusWork\(String(describing: item.StatusWork!))")
                        
                        statusCity = String(describing: item.StatusCity!)
                        statusWork = String(describing: item.StatusWork!)
                    }
                    
                    if statusCity == "4" || statusWork == "4"{
                        let alert = UIAlertController(title: "", message: "اعد المحاولة مرة اخرى", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                   
                    else{
                      
                    self.performSegue(withIdentifier: "BusnissInfoSegue", sender: nil)
                    UserDefaults.standard.set(true, forKey: "Transporter_susess_registration")
                    print("next to home page ")
                    }
                }
            }
            
            
            
          
            
            
        }
        
        
        
   }
    
  //  2018-10-23T10:50:35‏

    func CreatechoosenTimeArray(allTimeFlag: String)  {

        let AllTimeFlag =  allTimeFlag
        let AllTimeStart = "2018-10-23T" + allDayFromTextField.text!
        let AllTimeFinish = "2018-10-23T" + allDayToTextField.text!
        let SatTimeStart =  "2018-10-23T" + fromTextField[0].text!
        let SatTimeFinish =   "2018-10-23T" + fromTextField[1].text!
        let SunTimeStart =  "2018-10-23T" + fromTextField[2].text!
        let SunTimeFinish =  "2018-10-23T" + fromTextField[3].text!
        let MonTimeStart =  "2018-10-23T" + fromTextField[4].text!
        let MonTimeFinish = "2018-10-23T" + fromTextField[5].text!
        let TueTimeStart =  "2018-10-23T" + fromTextField[6].text!
        let TueTimeFinish = "2018-10-23T" + fromTextField[7].text!
        let WenTimeStart = "2018-10-23T" + fromTextField[8].text!
        let WenTimeFinish =  "2018-10-23T" + fromTextField[9].text!
        let ThuTimeStart = "2018-10-23T" + fromTextField[10].text!
        let ThuTimeFinish = "2018-10-23T" + fromTextField[11].text!

        let FriTimeStart = "2018-10-23T" + fromTextField[12].text!
        let FriTimeFinish =  "2018-10-23T" + fromTextField[13].text!

   
        let dict = ["AllTimeFlag": AllTimeFlag, "AllTimeStart": AllTimeStart, "AllTimeFinish": AllTimeFinish, "SatTimeStart": SatTimeStart,"SatTimeFinish": SatTimeFinish, "SunTimeStart": SunTimeStart,"SunTimeFinish": SunTimeFinish,"MonTimeStart": MonTimeStart, "MonTimeFinish": MonTimeFinish, "TueTimeStart": TueTimeStart, "TueTimeFinish": TueTimeFinish , "WenTimeStart": WenTimeStart, "WenTimeFinish": WenTimeFinish,"ThuTimeStart": ThuTimeStart, "ThuTimeFinish": ThuTimeFinish,"FriTimeStart": FriTimeStart, "FriTimeFinish" : FriTimeFinish  ]

        
        var _ : NSError?
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        print(jsonData)
        
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        
       print(jsonString)
        
        let WorkTimeJson = "{\"TransportrTime\": [\(jsonString)]\r\n}"
        print(WorkTimeJson)
        TransporterLoader.jsonStringWorkTime = WorkTimeJson
//        
//        dictionaryTimeWork["TransportrTime"]?.append(jsonString as AnyObject)
//       
//        print(dictionaryTimeWork)
//       
//        TransporterLoader.choosenTimeWork = self.dictionaryTimeWork
//        print(TransporterLoader.choosenTimeWork)

        

    }
 
 func textFieldDidBeginEditing(_ textField: UITextField) {

    if textField == detailTextField{
        let picker = CZPickerView(headerTitle: "Places", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true

        picker?.show()
        
        self.view.endEditing(true)
    }
    else{
        print(textField.tag)
        textFieldIndex = textField.tag
        
        let selector = WWCalendarTimeSelector.instantiate()
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(false)
        selector.optionStyles.showTime(true)
        // 2. You can then set delegate, and any customization options
        selector.delegate = self
        selector.optionTopPanelTitle = "Awesome Calendar!"
        
        // 3. Then you simply present it from your view controller when necessary!
        self.present(selector, animated: true, completion: nil)
        
        
        
       // DateView.isHidden = false
        
        self.view.endEditing(true)
        
    }
    
    }
    
    //// date////
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
      //  print("Selected \n\(date.minute)\n---")
        
        print("\(date)")
        
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        
        let myStringafd = formatter.string(from: yourDate!)
        
        print(myStringafd)
        
        let date1 = formatter.date(from: myStringafd)
        formatter.dateFormat = "HH:mm"
        formatter.locale  = Locale(identifier: "en_GB")
        let Date24 = formatter.string(from: date1!)
        print("24 hour formatted Date:",Date24)
        
        
        if textFieldIndex == 15{
            allDayFromTextField.text = "\(date.hour):\(date.minute)"
        }else if  textFieldIndex == 16{
            allDayToTextField.text = "\(date.hour):\(date.minute)"
        }else{
            fromTextField[textFieldIndex].text = "\(date.hour):\(date.minute)"
            
        }
       
    }
    
    
    
   
    
    //// date////
    
    
    
    
    @IBAction func donePressed(_ sender: Any) {
        DateView.isHidden = true
        //dayTextField.resignFirstResponder()
        
    }
    
    @IBAction func ClearBtnPressed(_ sender: UIButton) {
        
        if fromTextField[textFieldIndex].text != ""{
        fromTextField[textFieldIndex].text = ""
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setUpUI()  {
//        self.detailTextField.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
//        self.detailTextField.layer.borderWidth = 1
//        self.detailTextField.layer.cornerRadius = 10
        
        // all day chekbox
        //let tickBox3 = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tickBox3.borderStyle = .circle
        tickBox3.checkmarkStyle = .tick
        tickBox3.checkmarkSize = 0.7
        tickBox3.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox3.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox3.checkmarkColor = UIColor(netHex: 0x52AE9D)
        checkbox.addSubview(tickBox3)
        tickBox3.tag = 0
        tickBox3.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        
        
        // week day chekbox
       // let tickBox = Checkbox(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tickBox.borderStyle = .circle
        tickBox.checkmarkStyle = .tick
        tickBox.checkmarkSize = 0.7
        tickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        tickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        WeekDayCheckbox.addSubview(tickBox)
        tickBox.tag = 1
        tickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        
        
        
        // satrday  chekbox
        satrdaytickBox.borderStyle = .square
        satrdaytickBox.checkmarkStyle = .tick
        satrdaytickBox.checkmarkSize = 0.7
        satrdaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        satrdaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        satrdaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        satrdayCheckBox.addSubview(satrdaytickBox)
        satrdaytickBox.tag = 2
        satrdaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
//        // sunday  chekbox
        sundaytickBox.borderStyle = .square
        sundaytickBox.checkmarkStyle = .tick
        sundaytickBox.checkmarkSize = 0.7
        sundaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        sundaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        sundaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        sundayCheckBox.addSubview(sundaytickBox)
        sundaytickBox.tag = 3
        sundaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
//        // Monday  chekbox
        mondaytickBox.borderStyle = .square
        mondaytickBox.checkmarkStyle = .tick
        mondaytickBox.checkmarkSize = 0.7
        mondaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        mondaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        mondaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        mondayCheckBox.addSubview(mondaytickBox)
        mondaytickBox.tag = 4
        mondaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)

        // theu  chekbox
        theusdaytickBox.borderStyle = .square
        theusdaytickBox.checkmarkStyle = .tick
        theusdaytickBox.checkmarkSize = 0.7
        theusdaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        theusdaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        theusdaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        theusdayCheckBox.addSubview(theusdaytickBox)
        theusdaytickBox.tag = 5
        theusdaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        // wen  chekbox
        wednsdaytickBox.borderStyle = .square
        wednsdaytickBox.checkmarkStyle = .tick
        wednsdaytickBox.checkmarkSize = 0.7
        wednsdaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        wednsdaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        wednsdaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        wednsdayCheckBox.addSubview(wednsdaytickBox)
        wednsdaytickBox.tag = 6
        wednsdaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        // thi  chekbox
        thidsdaytickBox.borderStyle = .square
        thidsdaytickBox.checkmarkStyle = .tick
        thidsdaytickBox.checkmarkSize = 0.7
        thidsdaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        thidsdaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        thidsdaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        thidsdayCheckBox.addSubview(thidsdaytickBox)
        thidsdaytickBox.tag = 7
        thidsdaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        // fri  chekbox
        fridaytickBox.borderStyle = .square
        fridaytickBox.checkmarkStyle = .tick
        fridaytickBox.checkmarkSize = 0.7
        fridaytickBox.checkedBorderColor = UIColor(netHex: 0x52AE9D)
        fridaytickBox.uncheckedBorderColor = UIColor(netHex: 0x52AE9D)
        fridaytickBox.checkmarkColor = UIColor(netHex: 0x52AE9D)
        fridayCheckBox.addSubview(fridaytickBox)
        fridaytickBox.tag = 8
        fridaytickBox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
//
        
        
 }
    
    
 
 @objc func checkboxValueChanged(sender: Checkbox) {
    print("checkbox value change: \(sender.isChecked)")
    print(sender.tag)
    // all day
    if sender.tag == 1{
        
        if sender.isChecked{
            if tickBox.isChecked == true{
              tickBox3.isChecked = false
            }
            
            weekDayStack.isHidden = false
            verticalSpace.constant =  194
           
        }
           
        else{
           // tickBox.isChecked = false
             weekDayStack.isHidden = true
             verticalSpace.constant =  5
            
        }
    }
        
    else{
        if sender.isChecked{
            if tickBox3.isChecked == true{
                tickBox.isChecked = false
                weekDayStack.isHidden = true
                verticalSpace.constant =  5
            }
        }
    }
    
    
    
}
    
    
    func SetUpOriantation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            for item in uiLable{
                item.semanticContentAttribute = .forceRightToLeft
                item.textAlignment = .right
                
            }
            for item in uiStack{
                item.semanticContentAttribute = .forceLeftToRight
                
                
            }
            
        }else{
            for item in uiLable{
                item.semanticContentAttribute = .forceLeftToRight
                item.textAlignment = .left
            }
            for item in uiStack{
                item.semanticContentAttribute = .forceRightToLeft
                
            }
        }
        
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMapView"{
            
            _ = segue.destination as?
            MapViewController
        }
        
        
        if segue.identifier == "BusnissInfoSegue"{
            
            _ = segue.destination as?
            PaymentTypeViewController
        }
        
    }
    
}



extension WorkDetailViewController: CZPickerViewDelegate, CZPickerViewDataSource {

    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return self._PlaceList.count
    }
    
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return self._PlaceList[row].Name
    }
    
    
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
       // print(fruits[row])
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        
//        for  i in 0...1{
//         dictionaryPlaceList["IdCity"]?.append(self._PlaceList[i].IdCity!)
//
//        }
        
        if self.detailTextField.text != "" {
            self.detailTextField.text = ""
            MapViewController._PlaceList = []
        }
        
        
        for row in rows {

            if let row = row as? Int {

                print("row\(row)")
                
                let item = ["IdCity": self._PlaceList[row].IdCity!]
                
                dictionaryPlaceList["TransportrCity"]?.append(item as AnyObject)
                MapViewController._PlaceList.append(self._PlaceList[row])
                
            }

        }
        
        for item in MapViewController._PlaceList{
            
            self.detailTextField.text?.append(item.Name! + ",")
        }
        
       
        
       
    }
    
    
     func czpickerView(pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [AnyObject]!) {
//        for row in rows {
////            if let row = row as? Int {
////                print(self._PlaceList[row].Name!)
////            }
//        }
    }

}
