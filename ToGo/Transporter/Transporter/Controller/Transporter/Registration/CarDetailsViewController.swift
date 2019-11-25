//
//  CarDetailsViewController.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/16/18.
//  Copyright © 2018 yara. All rights reserved.
//

import UIKit
import ReachabilitySwift
import Kingfisher
import WWCalendarTimeSelector

class CarDetailsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate,WWCalendarTimeSelectorProtocol {
   
    
    //Outlets
    @IBOutlet weak var RegNumberTextField: CustomTextField!
    @IBOutlet weak var CarNumberTextField: CustomTextField!
    @IBOutlet weak var carColorTextField: CustomTextField!

    @IBOutlet weak var RegCarPhotoTextField: CustomTextField!
    @IBOutlet weak var CarPhototextField: CustomTextField!
    @IBOutlet weak var dayTextField: CustomTextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var DateView: UIView!
    @IBOutlet weak var CarColorPicker: UIPickerView!
    @IBOutlet weak var uiStack: UIStackView!
    
    @IBOutlet var uiLable: [UILabel]!
    @IBOutlet weak var carType: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHight: NSLayoutConstraint!
    @IBOutlet weak var uploadeCarPhoto: UIImageView!
    
    
    @IBOutlet weak var uploadeRegCarPhoto: UIImageView!
    let uploadeRegCarPhotoPicker = UIImagePickerController()
    let uploadeCarPhotoPicker = UIImagePickerController()
    
    fileprivate var multipleDates: [Date] = []
    fileprivate var singleDate: Date = Date()
    
    
    // Internet Connection
    let reachability = Reachability()!
    // ActivityIndicator
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControlller = UIRefreshControl()
    
    let View = UIView()
   // @IBOutlet weak var LoadingView: UIView!
    
    var transporterLoader = TransporterLoader()
    // Car Color
    var _CarColorModel = [CarColorModel]()
    
    // Car Photos
    var _carPhotos = [CarPhotos]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        CarPhototextField.isEnabled = false
        RegCarPhotoTextField.isEnabled = false
        
       
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackTranslucent
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action:#selector(CarDetailsViewController.doneTap(_:)))]
        
        tooBar.sizeToFit()
       // CarNumberTextField.inputAccessoryView = tooBar
        RegNumberTextField.inputAccessoryView = tooBar
        
        
        
        setUpPickerViewUI()
        //SetUpOriantation()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
        uploadeCarPhoto.isUserInteractionEnabled = true
        uploadeCarPhoto.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        uploadeRegCarPhoto.isUserInteractionEnabled = true
        uploadeRegCarPhoto.addGestureRecognizer(tapGestureRecognizer2)
        
        
        uploadeRegCarPhotoPicker.delegate = self
        uploadeCarPhotoPicker.delegate = self
        
        // Check internet connection
        //when Reachable
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                
                let sv = UIViewController.displaySpinner(onView: self.view)

                
                self.transporterLoader.GetColorPhotoCar {
                 
                    self._carPhotos = self.transporterLoader.carPhotos
                    self._CarColorModel = self.transporterLoader.carColorModel
                    
                    print(self._carPhotos.count)
//
//                    let collectionHeight = ((self._carPhotos.count)) * 90
//                    self.collectionHight.constant = CGFloat(collectionHeight)
//                    print(collectionHeight)
//                     print(self.collectionHight.constant)
//                    self.collectionView.reloadData()
//
//                    self.LoadingView.isHidden = true
//                    self.hideActivityIndicator(uiView: self.LoadingView)
//                    self.CarColorPicker.reloadAllComponents()
                   
                    
                 ///////////
                    if self._carPhotos.count % 3 == 0{
                        
                        let rowNumber = (self._carPhotos.count)/3
                        
                        
                        let collectionHeight =  rowNumber * 100
                        
                        
                        self.collectionHight.constant = CGFloat(collectionHeight)
                        print(collectionHeight)
                        print(self.collectionHight.constant)
                        self.collectionView.reloadData()
                        
                      UIViewController.removeSpinner(spinner: sv)
                        self.CarColorPicker.reloadAllComponents()
                    }else{
                        
                        
                        let rowNumber = (self._carPhotos.count)/3
                        
                        let x   = Int(rowNumber) + 1
                        
                        let collectionHeight =  x * 100
                        
                        self.collectionHight.constant = CGFloat(collectionHeight)
                        print(collectionHeight)
                        print(self.collectionHight.constant)
                        self.collectionView.reloadData()
                        
                        UIViewController.removeSpinner(spinner: sv)
                        self.CarColorPicker.reloadAllComponents()
                    }
                    ////////////
                    
                    
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

    @objc func doneTap(_: UILabel) {
        view.endEditing(true)
       
    CarNumberTextField.resignFirstResponder()
    RegCarPhotoTextField.resignFirstResponder()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return _carPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CarTypeCollectionViewCell
      
        cell.carImage.layer.cornerRadius = cell.carImage.frame.size.width / 2
        
        cell.carImage.clipsToBounds = true
        
        cell.carImage.kf.setImage(with: URL(string: image_URL + self._carPhotos[indexPath.row].PhotoUrl!))
        print("PhotoUrl\(self._carPhotos[indexPath.row].PhotoUrl!)")
        print("vehicleId\(self._carPhotos[indexPath.row].vehicleId!)")
        
//        cell.carButton.tag = indexPath.row
//
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(carImageimageTapped(tapGestureRecognizer:)))
//         cell.carButton.isUserInteractionEnabled = true
//         cell.carButton.addGestureRecognizer(tapGestureRecognizer)
//
        
        return cell
    }
   
    // set the size of collectionview cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       // let padding: CGFloat =  0
        let collectionViewSize = collectionView.frame.size.width
        return CGSize(width: collectionViewSize/4,height: collectionViewSize/4)
        
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = collectionView.cellForItem(at: indexPath) as! CarTypeCollectionViewCell
        cell.carImage.backgroundColor = UIColor(netHex: 0x29A89A).withAlphaComponent(0.5)
        TransporterLoader.CarImgId = self._carPhotos[indexPath.row].vehicleId!
        print("TransporterLoader.CarImgId\(TransporterLoader.CarImgId)")
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CarTypeCollectionViewCell
        cell.carImage.backgroundColor = UIColor.clear
    }
    
//    @objc func carImageimageTapped(tapGestureRecognizer: UITapGestureRecognizer)
//    {
//        let tappedImage = tapGestureRecognizer.view as! UIButton
//        print("you tap image number : \(tappedImage.tag)")
//
//        print(self._carPhotos[tappedImage.tag].vehicleId!)
//        TransporterLoader.CarImgId = self._carPhotos[tappedImage.tag].vehicleId!
//
//        if tappedImage.backgroundColor == UIColor.lightGray.withAlphaComponent(0.6){
//            tappedImage.backgroundColor = UIColor.clear
//        }
//        else{
//            tappedImage.backgroundColor = UIColor.lightGray.withAlphaComponent(0.6)
//
//        }
//
//
//    }


    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == CarColorPicker  {
            return _CarColorModel.count
        }
        else{
            return 2
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
       if pickerView == CarColorPicker{
            return _CarColorModel[row].Name
        }
        else{
            return ""
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if pickerView == CarColorPicker{
            self.carColorTextField.text = _CarColorModel[row].Name
            TransporterLoader.CarColorId = _CarColorModel[row].ColorId!
            CarColorPicker.isHidden = true
            
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    //textField//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    if textField == carColorTextField{
            CarColorPicker.isHidden = false
            self.view.endEditing(true)
            
        }
    else if textField == dayTextField{
        let selector = WWCalendarTimeSelector.instantiate()
        
        // 2. You can then set delegate, and any customization options
        selector.delegate = self
        selector.optionTopPanelTitle = "Awesome Calendar!"
        
        // 3. Then you simply present it from your view controller when necessary!
        self.present(selector, animated: true, completion: nil)
       // DateView.isHidden = false
       // self.view.endEditing(true)
        }
    }
    // handel return key for textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //textField//
    
    
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
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let strDate = dateFormatter.string(from: sender.date)
        dayTextField.text = strDate
    }
    
    @IBAction func donePressed(_ sender: Any) {
        DateView.isHidden = true
        dayTextField.resignFirstResponder()
        
    }
    
    
    @IBAction func dateBtnPressed(_ sender: Any) {
        
        self.view.endEditing(true)
        let selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        selector.optionTopPanelTitle = "Awesome Calendar!"
        
        // 3. Then you simply present it from your view controller when necessary!
        self.present(selector, animated: true, completion: nil)
        // DateView.isHidden = false
        // self.view.endEditing(true)
        
    }
    
    
    
    @IBAction func submitBtnPressed(_ sender: Any) {
        
        print("CarColorID:\(TransporterLoader.CarColorId)")
        print("CarImgeID:\(TransporterLoader.CarImgId)")
        
        if  TransporterLoader.CarImgCode == ""{
            
            CarPhototextField.layer.borderWidth = 1.0
            CarPhototextField.layer.borderColor = UIColor.red.cgColor
            
        }
      
       else if TransporterLoader.RegistrationImgCode == ""{
            
            RegCarPhotoTextField.layer.borderWidth = 1.0
            RegCarPhotoTextField.layer.borderColor = UIColor.red.cgColor
        }
        
          else{
            RegNumberTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            CarPhototextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            
            TransporterLoader.RegistrationNumber = RegNumberTextField.text!
            TransporterLoader.RegistrationFinshDay = dayTextField.text!
            TransporterLoader.LicenceCarNumber = CarNumberTextField.text!
            
             let sv = UIViewController.displaySpinner(onView: self.view)
            
            transporterLoader.SetCarInfo {
                
                UIViewController.removeSpinner(spinner: sv)
                if TransporterLoader.CarInfoResult == "Blocked"{
                    
                    
                    let alert = UIAlertController(title: "", message: "تم حظرك من قبل المسؤول", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
//                else if  TransporterLoader.CarInfoResult == "NotAccepted"{
//                    
//                    let alert = UIAlertController(title: "", message: "لم يتم الموافقة عليك من قبل المسؤول بعد يرجى المحاولة لاحقا", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: ar_yes, style: .default, handler: nil))
//                    self.present(alert, animated: true)
//                }
              
                else{
                    UserDefaults.standard.set(true, forKey: "CarFlagRegistration")

                    self.performSegue(withIdentifier: "workDetailsSegue", sender: nil)
                }
                //workDetailsSegue
            }
            
        }
        
        
    }
    
    
    func setUpPickerViewUI()  {
  
        self.CarColorPicker.layer.borderWidth = 0.5
        self.CarColorPicker.layer.cornerRadius = 10
        self.CarColorPicker.layer.borderColor = UIColor(netHex: 0x29A89A).cgColor
        
    }
    
    
    func SetUpOriantation()  {
        
        let lang = UserDefaults.standard.string(forKey: "lang")
        if lang == "ar"{
            for item in uiLable{
                item.semanticContentAttribute = .forceRightToLeft
                item.textAlignment = .right
            }
            RegNumberTextField.semanticContentAttribute = .forceRightToLeft
            RegNumberTextField.textAlignment = .right
            CarNumberTextField.semanticContentAttribute = .forceRightToLeft
            CarNumberTextField.textAlignment = .right
           
            carType.semanticContentAttribute = .forceRightToLeft
            uiStack.semanticContentAttribute = .forceRightToLeft
        }else{
            for item in uiLable{
                item.semanticContentAttribute = .forceLeftToRight
                item.textAlignment = .left
             }
            RegNumberTextField.semanticContentAttribute = .forceLeftToRight
            RegNumberTextField.textAlignment = .left
            CarNumberTextField.semanticContentAttribute = .forceLeftToRight
            CarNumberTextField.textAlignment = .left
            carType.semanticContentAttribute = .forceLeftToRight
            uiStack.semanticContentAttribute = .forceLeftToRight
            
        }
    }
    
    
    ///***********imageChoose************************///
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        uploadeRegCarPhotoPicker.allowsEditing = false
        uploadeRegCarPhotoPicker.sourceType = .photoLibrary
        present(uploadeRegCarPhotoPicker, animated: true, completion: nil)
        
    }
    
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        uploadeCarPhotoPicker.allowsEditing = false
        uploadeCarPhotoPicker.sourceType = .photoLibrary
        present(uploadeCarPhotoPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImge = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if picker == uploadeRegCarPhotoPicker{
            
            TransporterLoader.RegistrationImgName = "image" +  "\(Date().timeIntervalSinceReferenceDate)" + ".jpg"
            
            RegCarPhotoTextField.text = TransporterLoader.RegistrationImgName
           
            
            //ImageCode
            let imageData:NSData = UIImagePNGRepresentation(selectedImge)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            // print(strBase64)
            TransporterLoader.RegistrationImgCode = strBase64
            RegCarPhotoTextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
            
        }
            
        else{
            
            TransporterLoader.CarImgName = "image" +  "\(Date().timeIntervalSinceReferenceDate)" + ".jpg"
             CarPhototextField.text = TransporterLoader.CarImgName
            
            //ImageCode
            let imageData:NSData = UIImagePNGRepresentation(selectedImge)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            // print(strBase64)
            TransporterLoader.CarImgCode = strBase64
            CarPhototextField.layer.borderColor = UIColor(netHex:0x2FAB9B).cgColor
        }
        
        
        dismiss(animated: true, completion: nil)
    }
      ///***********imageChoose************************///
    
    
    
    // display Loading Indicator
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor(netHex: 0xffffff).withAlphaComponent(0.3)
        
        loadingView.frame = CGRect(x: 0,y: 0,width: 80,height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(netHex: 0x444444).withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0,y: 0.0,width: 40.0,height: 40.0);
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2,y: loadingView.frame.size.height / 2)
        activityIndicator.color = UIColor.white
        
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    
    //  Hide loading indicator
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "workDetailsSegue"{
            
            _ = segue.destination as?
            WorkDetailViewController
        }
        
        
        
    }
    
}
