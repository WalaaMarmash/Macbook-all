//
//  TransporterAccountViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift
import NotificationCenter
import WWCalendarTimeSelector


class TransporterAccountViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,WWCalendarTimeSelectorProtocol {
    
    // Constraints
    @IBOutlet weak var constraintContentHeight: NSLayoutConstraint!    //Outlets
    //textField
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var IDPlaceTextField: CustomTextField!
    @IBOutlet weak var IDNumber: CustomTextField!
    @IBOutlet weak var DriverLicenseNumber: CustomTextField!
    @IBOutlet weak var DriverLicenseType: CustomTextField!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var accountName: CustomTextField!
    @IBOutlet weak var photoImageTextField: CustomTextField!
    @IBOutlet weak var licencePhotoTextField: CustomTextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dayTextField: CustomTextField!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet var uiLable: [UILabel]!
    @IBOutlet weak var licensePicker: UIPickerView!
    @IBOutlet weak var iDPlacePicker: UIPickerView!
    let PersonalimagePicker = UIImagePickerController()
    let LincenceimagePicker = UIImagePickerController()
    @IBOutlet weak var uploadPersonalimage: UIImageView!
    @IBOutlet weak var uploadLincenceimage: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var IdPlaceTableView: UITableView!
    @IBOutlet weak var IdTypePlaceTableView: UITableView!
    
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat!
    
    
    // Internet Connection
    let reachability = Reachability()!
    var transporterLoader = TransporterLoader()
    var _IDPlaceList = [idPlaceModel]()
    var _IDPlaceTypeList = [idPlaceTypeModel]()
    
    static var PlaceId = ""
    static var LicenseId = ""
    
    fileprivate var multipleDates: [Date] = []
    fileprivate var singleDate: Date = Date()
   
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        IdPlaceTableView.isHidden = true
//        IdPlaceTableView.tableFooterView = UIView()
//        IdPlaceTableView.layer.cornerRadius = 10
//        IdTypePlaceTableView.isHidden = true
//        IdTypePlaceTableView.tableFooterView = UIView()
//        IdTypePlaceTableView.layer.cornerRadius = 10
//        // setup datePicker
//
//       nameTextField.returnKeyType = .done
//
//       datePicker.datePickerMode = UIDatePickerMode.date
//
//
//        let tooBar: UIToolbar = UIToolbar()
//        tooBar.barStyle = UIBarStyle.blackTranslucent
//        tooBar.items=[
//            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
//            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(TransporterAccountViewController.doneTap(_:)))]
//
//        tooBar.sizeToFit()
//        IDNumber.inputAccessoryView = tooBar
//        DriverLicenseNumber.inputAccessoryView = tooBar
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//
//
//        //setUpOrintation()
//        photoImageTextField.isEnabled = false
//        licencePhotoTextField.isEnabled = false
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        uploadPersonalimage.isUserInteractionEnabled = true
//        uploadPersonalimage.addGestureRecognizer(tapGestureRecognizer)
//
//        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
//        uploadLincenceimage.isUserInteractionEnabled = true
//        uploadLincenceimage.addGestureRecognizer(tapGestureRecognizer2)
//
//
//        PersonalimagePicker.delegate = self
//        LincenceimagePicker.delegate = self
//
//        // Check internet connection
//        //when Reachable
//        reachability.whenReachable = { reachability in
//            DispatchQueue.main.async {
//
//                let sv = UIViewController.displaySpinner(onView: self.view)
//
//                self.transporterLoader.GetIdPlaceLicence {
//
//                  self._IDPlaceList = self.transporterLoader.IdPlaceModel
//                 self._IDPlaceTypeList = self.transporterLoader.IdPlaceTypeModel
//
////                    if TransporterLoader.GetIdPlaceResult == "NotAccepted"{
////
////                        let alert = UIAlertController(title: "", message: "مشكلة في الاتصال حاول لاحقا", preferredStyle: .alert)
////                        alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
////                        self.present(alert, animated: true)
////
////                    }else if TransporterLoader.GetIdPlaceResult == "Blocked"{
////
////                    }else{
//                    UIViewController.removeSpinner(spinner: sv)
//                    self.IdPlaceTableView.reloadData()
//                    self.IdTypePlaceTableView.reloadData()
//
//                    self.iDPlacePicker.reloadAllComponents()
//                    self.licensePicker.reloadAllComponents()
//                }
//                }
//
//            }
//            // When UnReachable
//            self.reachability.whenUnreachable = { reachability in
//                // this is called on a background thread, but UI updates must
//                // be on the main thread, like this:
//                DispatchQueue.main.async {
//
//
//                }
//
//            }
//
//            do {
//                try reachability.startNotifier()
//            } catch {
//                print("Unable to start notifier")
//            }
     
 }
    
   
    override func viewWillAppear(_ animated: Bool) {
        IdPlaceTableView.isHidden = true
        IdPlaceTableView.tableFooterView = UIView()
        IdPlaceTableView.layer.cornerRadius = 10
        IdTypePlaceTableView.isHidden = true
        IdTypePlaceTableView.tableFooterView = UIView()
        IdTypePlaceTableView.layer.cornerRadius = 10
        // setup datePicker
        
        nameTextField.returnKeyType = .done
        
        datePicker.datePickerMode = UIDatePickerMode.date
        
        
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackTranslucent
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(TransporterAccountViewController.doneTap(_:)))]
        
        tooBar.sizeToFit()
        IDNumber.inputAccessoryView = tooBar
        DriverLicenseNumber.inputAccessoryView = tooBar
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        //setUpOrintation()
        photoImageTextField.isEnabled = false
        licencePhotoTextField.isEnabled = false
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        uploadPersonalimage.isUserInteractionEnabled = true
        uploadPersonalimage.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        uploadLincenceimage.isUserInteractionEnabled = true
        uploadLincenceimage.addGestureRecognizer(tapGestureRecognizer2)
        
        
        PersonalimagePicker.delegate = self
        LincenceimagePicker.delegate = self
        
        // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                let sv = UIViewController.displaySpinner(onView: self.view)
                
                self.transporterLoader.GetIdPlaceLicence {
                    
                    self._IDPlaceList = self.transporterLoader.IdPlaceModel
                    self._IDPlaceTypeList = self.transporterLoader.IdPlaceTypeModel
                    
                    //                    if TransporterLoader.GetIdPlaceResult == "NotAccepted"{
                    //
                    //                        let alert = UIAlertController(title: "", message: "مشكلة في الاتصال حاول لاحقا", preferredStyle: .alert)
                    //                        alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    //                        self.present(alert, animated: true)
                    //
                    //                    }else if TransporterLoader.GetIdPlaceResult == "Blocked"{
                    //
                    //                    }else{
                    UIViewController.removeSpinner(spinner: sv)
                    self.IdPlaceTableView.reloadData()
                    self.IdTypePlaceTableView.reloadData()
                    
                    self.iDPlacePicker.reloadAllComponents()
                    self.licensePicker.reloadAllComponents()
                }
            }
            
        }
        // When UnReachable
        self.reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                
                
            }
            
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
  
    
    @objc func keyboardWillAppear() {
        //Do something here
        print("keyboardWillAppear")
        
    }
    
    @objc func keyboardWillDisappear() {
        //Do something here
        print("keyboardWillDisappear")
    }
    
    @objc func doneTap(_: UILabel) {
        view.endEditing(true)
        IDNumber.resignFirstResponder()
        DriverLicenseNumber.resignFirstResponder()
    }
    
    
      ///***********imageChoose************************///
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        PersonalimagePicker.allowsEditing = false
        PersonalimagePicker.sourceType = .photoLibrary
        present(PersonalimagePicker, animated: true, completion: nil)
        
    }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        LincenceimagePicker.allowsEditing = false
        LincenceimagePicker.sourceType = .photoLibrary
        present(LincenceimagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImge = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        
        let widthInPixels = selectedImge.size.width * selectedImge.scale
        let heightInPixels = selectedImge.size.height * selectedImge.scale
        
        if widthInPixels > 1600 , heightInPixels > 1200{
            print("largeImage")
        }
     
        if picker == PersonalimagePicker{
            
            TransporterLoader.PersonalImgName = "image" +  "\(Date().timeIntervalSinceReferenceDate)" + ".jpg"
            
            photoImageTextField.text = TransporterLoader.PersonalImgName
            
            //ImageCode
            let imageData:NSData = UIImagePNGRepresentation(selectedImge)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            // print(strBase64)
            TransporterLoader.PersonalImgCode = strBase64
            photoImageTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
        }
        
        else{
            
            TransporterLoader.LicenceImgName = "image" +  "\(Date().timeIntervalSinceReferenceDate)" + ".jpg"
            
             licencePhotoTextField.text = TransporterLoader.LicenceImgName
            //ImageCode
            let imageData:NSData = UIImagePNGRepresentation(selectedImge)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            // print(strBase64)
            TransporterLoader.LicenceImgCode = strBase64
            licencePhotoTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
        }
        
       
        dismiss(animated: true, completion: nil)
    }
      ///***********imageChoose************************///
   
    
    
    //// date////
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print("Selected \n\(date)\n---")
        self.dayTextField.text = "\(date)"
      //   "dd/MM/yyyy"
//        singleDate = date
//        dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, dates: [Date]) {
        print("Selected Multiple Dates \n\(dates)\n---")
        if let date = dates.first {
            
            
//            singleDate = date
//            dateLabel.text = date.stringFromFormat("d' 'MMMM' 'yyyy', 'h':'mma")
        }
        else {
           // dateLabel.text = "No Date Selected"
        }
        multipleDates = dates
    }
    
     //// date////
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       if pickerView == iDPlacePicker  {
            return self._IDPlaceList.count
        }else if pickerView == licensePicker  {
            return self._IDPlaceTypeList.count
        }
        else{
            return 2
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if pickerView == iDPlacePicker{
            return _IDPlaceList[row].NamePlace
        }else if pickerView == licensePicker{
            return  _IDPlaceTypeList[row].TypeName
        }
        else{
            return ""
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
      if pickerView == iDPlacePicker{
        
        if _IDPlaceList.count != 0 {
            self.IDPlaceTextField.text = _IDPlaceList[row].NamePlace
           TransporterAccountViewController.PlaceId = _IDPlaceList[row].IdPlace!
            iDPlacePicker.isHidden = true
        }else{
            iDPlacePicker.isHidden = true
            
        }
        }
      else if pickerView == licensePicker{
        if _IDPlaceTypeList.count != 0  {
            
            self.DriverLicenseType.text = _IDPlaceTypeList[row].TypeName
        TransporterAccountViewController.LicenseId = _IDPlaceTypeList[row].IdTypeLicence!
            licensePicker.isHidden = true
        }else{
            licensePicker.isHidden = true
            
            
            
        }
        
        }
       
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    //textField//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
       
        
        if textField == IDPlaceTextField{
            
            
            if IdPlaceTableView.isHidden {
                animate(toogle: true, type: 1)
            } else {
                animate(toogle: false, type: 1)
            }
            
             view.endEditing(true)
           // iDPlacePicker.isHidden = false
          
            
        }else if textField == DriverLicenseType{
           // licensePicker.isHidden = false
            
            if IdTypePlaceTableView.isHidden {
                animate(toogle: true, type: 2)
            } else {
                animate(toogle: false, type: 2)
            }
            
            self.view.endEditing(true)
        }
        
        else if textField == dayTextField{
            
           //  self.view.endEditing(true)
            
            
//
//            let selector = WWCalendarTimeSelector.instantiate()
//
//            // 2. You can then set delegate, and any customization options
//            selector.delegate = self
//            selector.optionTopPanelTitle = "Awesome Calendar!"
//
//            // 3. Then you simply present it from your view controller when necessary!
//
//            self.present(selector, animated: true, completion: nil)

            
            
        }
           
      
        else if textField == emailTextField{
        activeField = textField
      //  mainScrollView.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
    }
        
        
//         else if textField == accountName {
//             activeField = textField
//             mainScrollView.setContentOffset(CGPoint(x: 0, y: 400), animated: true)
//        }
    }
    
    
   
    
    
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        
       if textField == emailTextField {
        //mainScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.view.endEditing(true)
        }
        textField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField)
        self.view.endEditing(true)
        if textField == nameTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    
    //textField//
    
    
    @IBAction func dateBtnPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        
        
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        // 2. You can then set delegate, and any customization options
        selector.delegate = self
        selector.optionTopPanelTitle = "Awesome Calendar!"
        
        // 3. Then you simply present it from your view controller when necessary!
        
        self.present(selector, animated: true, completion: nil)

        
    }
    
    
    
    func animate(toogle: Bool, type: Int) {
        
        if type == 1{
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.IdPlaceTableView.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.IdPlaceTableView.isHidden = true
                }
                
            }
        }
        else{
            if toogle {
                UIView.animate(withDuration: 0.3) {
                    self.IdTypePlaceTableView.isHidden = false
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.IdTypePlaceTableView.isHidden = true
                }

            }
            
        }
    }
    
    
   
    func WWCalendarTimeSelectorDone(selector: WWCalendarTimeSelector, date: NSDate) {
        print(date)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        let strDate = dateFormatter.string(from: sender.date)
        dayTextField.text = strDate
    }
    
    @IBAction func donePressed(_ sender: Any) {
        dateView.isHidden = true
        dayTextField.resignFirstResponder()
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    //Post transporter info via api
    @IBAction func submitBtnPressed(_ sender: Any) {
        
       
       let name =  nameTextField.text
       let date =  dayTextField.text
       let idPlace =  TransporterAccountViewController.PlaceId
       let iDNumber = IDNumber.text
       let LincenceNumber = DriverLicenseNumber.text
       let LincenceType  =  DriverLicenseType.text
       let email = emailTextField.text
       let AccountName = accountName.text
       let PersonalImageCode = TransporterLoader.PersonalImgCode
       let LicenceImageCode = TransporterLoader.LicenceImgCode
        
        if name == "" {
            
           nameTextField.layer.borderWidth = 1.0
           nameTextField.layer.borderColor = UIColor.red.cgColor
            
        }
        
        else if email == ""  {
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        else if PersonalImageCode == "" {
            photoImageTextField.layer.borderWidth = 1.0
            photoImageTextField.layer.borderColor = UIColor.red.cgColor
        }
        
         else if LicenceImageCode == "" {
            licencePhotoTextField.layer.borderWidth = 1.0
            licencePhotoTextField.layer.borderColor = UIColor.red.cgColor
        }
            
           
            
        
//        else if isValidEmail(testStr: email!){
//
//            let alert = UIAlertController(title: "", message: "البيانات المدخلة غير صحيحة", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
//            self.present(alert, animated: true)
//        }
        
        else{
            
            nameTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            emailTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            photoImageTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            licencePhotoTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor

            TransporterLoader.FullName = name!
            TransporterLoader.date = date!
            TransporterLoader.Email = email!
            TransporterLoader.IDPlace = idPlace
            TransporterLoader.IDNumber = iDNumber!
            TransporterLoader.LicenceType = LincenceType!
            TransporterLoader.LicenceNumber = LincenceNumber!
            TransporterLoader.AccountName = AccountName!

           print(TransporterAccountViewController.PlaceId)

            let sv = UIViewController.displaySpinner(onView: self.view)
            
            transporterLoader.SetTransporterInfo {
                UIViewController.removeSpinner(spinner: sv)
                print(TransporterLoader.TransporterinfoResult)

//
                 if  TransporterLoader.TransporterinfoResult == "Blocked"{


                    let alert = UIAlertController(title: "", message: "تم حظرك من قبل المسؤول", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }

                 else if   TransporterLoader.TransporterinfoResult == "NotAccepted"{

                    let alert = UIAlertController(title: "", message: "لم يتم الموافقة عليك من  قبل المسؤول", preferredStyle: .alert)
                                   alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                                   self.present(alert, animated: true)
                }
                 else {
                 UserDefaults.standard.set(true, forKey: "PersonalInfoRegistration")
                self.performSegue(withIdentifier: "carDetailSegue", sender: nil)
                }
            }

      }
        
        
        
    }
    
    
  
    func setUpOrintation()  {
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            for item in uiLable{
                item.semanticContentAttribute = .forceRightToLeft
                item.textAlignment = .right
            }
            nameTextField.semanticContentAttribute = .forceRightToLeft
            nameTextField.textAlignment = .right
            IDNumber.semanticContentAttribute = .forceRightToLeft
            IDNumber.textAlignment = .right
            accountName.semanticContentAttribute = .forceRightToLeft
            accountName.textAlignment = .right
            DriverLicenseNumber.textAlignment = .right
        }else{
            for item in uiLable{
                item.semanticContentAttribute = .forceLeftToRight
                item.textAlignment = .left
            }
            nameTextField.semanticContentAttribute = .forceLeftToRight
            nameTextField.textAlignment = .left
            IDNumber.semanticContentAttribute = .forceLeftToRight
            IDNumber.textAlignment = .left
            accountName.semanticContentAttribute = .forceLeftToRight
            accountName.textAlignment = .left
            DriverLicenseNumber.textAlignment = .left
        }
    }
    
        
       
        
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "carDetailSegue"{
            
            _ = segue.destination as?
            CarDetailsViewController
        }
        
        
        
    }

}




extension TransporterAccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(_IDPlaceList.count)
        if tableView == IdPlaceTableView{
            return _IDPlaceList.count
        }else{
            
             return _IDPlaceTypeList.count
        }
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView == IdPlaceTableView{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = _IDPlaceList[indexPath.row].NamePlace
        return cell
    }
    else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = _IDPlaceTypeList[indexPath.row].TypeName
        return cell
    }
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if tableView == IdPlaceTableView{
        self.IDPlaceTextField.text = "\(String(describing: _IDPlaceList[indexPath.row].NamePlace!))"
         TransporterAccountViewController.PlaceId = _IDPlaceList[indexPath.row].IdPlace!
         IdPlaceTableView.reloadData()
          animate(toogle: false, type: 1)
    }
    else{
         self.DriverLicenseType.text = "\(_IDPlaceTypeList[indexPath.row].TypeName!)"
        TransporterAccountViewController.LicenseId = _IDPlaceTypeList[indexPath.row].IdTypeLicence!
         animate(toogle: false, type: 2)
    }
}


}
