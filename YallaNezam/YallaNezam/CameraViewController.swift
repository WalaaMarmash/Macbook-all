//
//  CameraViewController.swift
//  YallaNezam
//
//  Created by fratello software house on 12/24/18.
//  Copyright © 2018 FSH. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Alamofire
import SwiftyJSON
import GoogleMaps



class CameraViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    var imageName: String = ""
    var imageStr64: String = ""
    var photoes:[Any] = []
    var videoName : String = ""


    let myPickerController = UIImagePickerController()
    
    let locationManager = CLLocationManager()
    
    let appearance = SCLAlertView.SCLAppearance(
        showCloseButton: false
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoImg.isHidden = true
        logoImg.isHidden = true
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        myPickerController.delegate = self
        myPickerController.sourceType =  UIImagePickerController.SourceType.camera
        myPickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!


        self.present(myPickerController, animated: true, completion: nil)

        
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
      
       // print("locations = \(locValue.latitude) \(locValue.longitude)")
        longLocation = locValue.longitude
        latLocation = locValue.latitude
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if imageName != "" || videoName != "" {
          showConfirmMessage()
        }
        else {
            showMessage()
        }
        
    }


      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("hi")

        if let image_data = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {

            checkTypeUpload = "Image"
        
            videoImg.isHidden = true
            logoImg.isHidden = true
            imageView.image = image_data
            let currentDateTime1 = Date()
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyyMMddHHmmssSSS"
            formatter1.timeZone = TimeZone(secondsFromGMT: 0)
            formatter1.locale = Locale(identifier: "en_US_POSIX")
            let dateTime1 = formatter1.string(from: currentDateTime1)
            imageName = "image" + dateTime1 + ".jpg"
            
        let imageData:Data = (image_data.jpegData(compressionQuality: 0.2))!
            imageStr64 = imageData.base64EncodedString()
            photoes.append(["ImgName":imageName, "ImgCode":imageStr64])

            let dictionary = ["ComplaintPhotos" : photoes]
            photoArray = JSON(dictionary)
            print(imageName)
          }
    
    if let video_data = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
        
        checkTypeUpload = "Vedio"
            
        videoImg.isHidden = false
        logoImg.isHidden = true
        print(video_data)
        print("video_data \(video_data)")
        let pathString = video_data.relativePath
        print("pathString \(pathString)")
        
        videoName = pathString
        
        let myImage = self.imageFromVideo(url: video_data, at: 0)
        imageView.image = myImage
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            
            if mediaType == "public.movie" {
                checkTypeUpload = "Vedio"
                print("Video Selected")
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
                print(videoURL)
               // callAPIForUploadVideo(myVideoURL: videoURL)
            }
        }
        
            //showConfirmMessage()
    }//video
    

        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func callAPIForUploadVideo (myVideoURL : URL){
         print("callAPIForUploadVideo")
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmssSSS"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        let dateTime = formatter.string(from: currentDateTime)
        let videoName = "video" + dateTime + ".mp4"
        
        let parameters : Parameters = ["CheckTypeFunction":"UploadComplaints","CustomerId":UserDefaults.standard.string(forKey: "id") as! String,"CheckTypeUpload":checkTypeUpload , "FlagDetails":"", "FlagSeen":"seen" , "LatLocation": String(latLocation) , "LongLocation":String(longLocation) , "ComplaintPhotos":"" , "Description": "" ,  "InfoLocation":""]
        
         let alertWait = SCLAlertView(appearance: self.appearance)
        alertWait.showWait("يرجى الانتظار...", subTitle: "", closeButtonTitle: "", timeout: nil , colorStyle: 0x00B23D, colorTextButton: 0xFFFFFF  , circleIconImage: nil, animationStyle: .topToBottom)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            // code
            // here you can upload only mp4 video
            for (key,value) in parameters {
                multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            }
            
            multipartFormData.append(myVideoURL, withName: "myFile", fileName: videoName , mimeType: "video/mp4")
           
            // here you can upload any type of video
            //multipartFormData.append(self.selectedVideoURL!, withName: "File1")
            multipartFormData.append(("VIDEO".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "Type")
            
      //  }, to: "http://46.253.95.83/YallaNezam/YallaNezamApis/public/TestVedio.php", encodingCompletion: { (result) in
            }, to: url, encodingCompletion: { (result) in
            // code
            print(result)
            switch result {
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.validate().responseString {
               
                    response in
                    print("responseee")
                    print(response)
                    alertWait.hideView()
                    if response.result.isFailure {
                        debugPrint(response)
                    } else {
//                        let result = response.value as! NSDictionary
//                        print("reeeesult")
//                        print(result)
                        if response.result.value == "InsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "تم الارسال بنجاح", subTitle: "", alertType: .success)
                            self.viewDidLoad()
                        }
                        else if response.result.value == "NotInsertedOrder" {
                            YSLNoticeAlert().showAlert(title: "لم يتم الارسال", subTitle: "", alertType: .failure)
                        }
                        else {
                            YSLNoticeAlert().showAlert(title: "حدث خلل يرجى اعادة المحاولة", subTitle: "", alertType: .failure)
                        }
                    }
                }
            case .failure(let encodingError):
                NSLog((encodingError as NSError).localizedDescription)
            }
        })
        
        
    }

    
    
    func showConfirmMessage() {
      //  videoImg.isHidden = true
        logoImg.isHidden = true
        
        let optionMenu = UIAlertController(title: nil, message: nil , preferredStyle: .actionSheet)
        
        
        let sendPhoto = UIAlertAction(title: "ارسال مباشرة", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
           
            
            if reachability.isReachable{
                
                if checkTypeUpload == "Vedio" {
                    self.callAPIForUploadVideo(myVideoURL: videoURL)
                }
                else if checkTypeUpload == "Image" {
                    
                 
                    let alertWait = SCLAlertView(appearance: self.appearance)
                    alertWait.showWait("يرجى الانتظار...", subTitle: "", closeButtonTitle: "", timeout: nil , colorStyle: 0x00B23D, colorTextButton: 0xFFFFFF  , circleIconImage: nil, animationStyle: .topToBottom)
                    
                Alamofire.request(url, method: .post, parameters: ["CheckTypeFunction":"UploadComplaints","CustomerId":UserDefaults.standard.string(forKey: "id") as! String,"CheckTypeUpload":checkTypeUpload , "FlagDetails":"", "FlagSeen":"seen" , "LatLocation": latLocation , "LongLocation":longLocation , "ComplaintPhotos":photoArray , "Description": "" ,  "InfoLocation":""], encoding:URLEncoding.default, headers: ["ZUMO-API-VERSION":"2.0.0","Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"]).responseString {
                    response in
                    print(response)
                    alertWait.hideView()
                    
                    if response.result.value == "InsertedOrder" {
                        YSLNoticeAlert().showAlert(title: "تم الارسال بنجاح", subTitle: "", alertType: .success)
                        self.viewDidLoad()
                    }
                    else if response.result.value == "NotInsertedOrder" {
                        YSLNoticeAlert().showAlert(title: "لم يتم الارسال", subTitle: "", alertType: .failure)
                     
                    }
                    else {
                        YSLNoticeAlert().showAlert(title: "حدث خلل يرجى اعادة المحاولة", subTitle: "", alertType: .failure)
                    }
                    
                }//alamofire
                } // if checkTypeUpload
            } //reachability
            else{
                YSLNoticeAlert().showAlert(title: "تفقد اتصال الانترنت", subTitle: "", alertType: .failure)
            }
            
            
//            self.myPickerController.delegate = self
//            self.myPickerController.sourceType =  UIImagePickerController.SourceType.camera
//            self.present(self.myPickerController, animated: true, completion: nil)
         
        })
     
      let usePhoto = UIAlertAction(title: "اضافة تفاصيل" , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
          let vc = NotesViewController()
        self.navigationController?.pushViewController(vc, animated: false)
            
        })
        
    let notUsePhoto = UIAlertAction(title: "تغيير الصورة/الفيديو" , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        self.myPickerController.delegate = self
        self.myPickerController.sourceType =  UIImagePickerController.SourceType.camera
        self.present(self.myPickerController, animated: true, completion: nil)
            
        })
        
 
        optionMenu.addAction(sendPhoto)
        optionMenu.addAction(usePhoto)
        optionMenu.addAction(notUsePhoto)
        
        optionMenu.view.tintColor = UIColor.white
        optionMenu.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(hex: "00B23D")
        
        // Accessing buttons tintcolor :
        self.present(optionMenu, animated: true, completion: nil)
       
    }
 
    
    
    func showMessage() {
        videoImg.isHidden = true
        logoImg.isHidden = false
        
        let optionMenu = UIAlertController(title: nil, message: nil , preferredStyle: .actionSheet)
        
        let changePhoto = UIAlertAction(title: "التقاط صورة/ فيديو", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.myPickerController.delegate = self
            self.myPickerController.sourceType =  UIImagePickerController.SourceType.camera
            self.present(self.myPickerController, animated: true, completion: nil)
            
        })
        
        let settingInfo = UIAlertAction(title: "تفاصيل الحساب" , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let vc = SettingsViewController()
            self.navigationController?.pushViewController(vc, animated: false)
            
        })
        
//        let changePass = UIAlertAction(title: "الشكاوي السابقة" , style: .default, handler: {
//            (alert: UIAlertAction!) -> Void in
//
//        })
        
//        let shareApp = UIAlertAction(title: "انشر التطبيق" , style: .default, handler: {
//            (alert: UIAlertAction!) -> Void in
//
//            //if let name = NSURL(string: "https://itunes.apple.com/us/app/myapp/id1274063330?ls=1&mt=8") {
//            if let name = NSURL(string: "") {
//                let objectsToShare = [name]
//                //            let text = "http://google.com"
//                let shareViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: [])
//                if let popoverPresentationController = shareViewController.popoverPresentationController {
//                    popoverPresentationController.sourceView = self.view
//                    popoverPresentationController.sourceRect = CGRect(x: self.view.frame.width/2, y: 0, width: 0, height: 0)
//
//                }
//
//                self.present(shareViewController, animated: true, completion: nil)
//
//
//            }
//
//        })
        
        let logOut = UIAlertAction(title: "تسجيل الخروج" , style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: false)
           
        })
        
        
        optionMenu.addAction(changePhoto)
        optionMenu.addAction(settingInfo)
        //optionMenu.addAction(changePass)
        //optionMenu.addAction(shareApp)
        optionMenu.addAction(logOut)
        
        optionMenu.view.tintColor = UIColor.white
        optionMenu.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(hex: "00B23D")
        
        // Accessing buttons tintcolor :
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    func imageFromVideo(url: URL, at time: TimeInterval) -> UIImage? {
            let asset = AVURLAsset(url: url)
            
            let assetIG = AVAssetImageGenerator(asset: asset)
            assetIG.appliesPreferredTrackTransform = true
        assetIG.apertureMode = AVAssetImageGenerator.ApertureMode.encodedPixels
            
            let cmTime = CMTime(seconds: time, preferredTimescale: 5)
            let thumbnailImageRef: CGImage
            do {
                thumbnailImageRef = try assetIG.copyCGImage(at: cmTime, actualTime: nil)
            } catch let error {
                print("Error: \(error)")
                return nil
            }
        
            return UIImage(cgImage: thumbnailImageRef)
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


//to convert color from hex to UIColor
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
} // extintion color
