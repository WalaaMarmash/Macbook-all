//
//  Extention.swift
//  ToGo
//
//  Created by Fratello Software Group on 5/14/18.
//  Copyright © 2018 yara. All rights reserved.
//


import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        
    }
    
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
          //  self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
}


// Main ViewController extension
extension MainViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    ////////////// PickerView///////////////
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == LanguagePickerList{
            
            
            return  self._langugeList.count
        }
        else{
            return 1
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if pickerView == LanguagePickerList{
            
            if _langugeList.count != 0 {
                
                return _langugeList[row].Name
        }
            else{
            return "لا يوجد قيم"
            }
        }
        else{
            return ""
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == LanguagePickerList{
            if _langugeList.count != 0 {
            self.languageTextField.text = _langugeList[row].Name
            choosenLanguage = _langugeList[row].Name
            choosenLanguage_id = _langugeList[row].id
                }
            else{
                 self.languageTextField.text = "لا يوجد قيم"
                
            }
        }
        
        LanguagePickerList.isHidden = true
        
        submitBtn.isHidden = false
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    ////////////// PickerView///////////////
}



extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        ai.color = UIColor.darkGray
       
        ai.startAnimating()
        
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension Date {
    fileprivate struct AssociatedKeys {
        static var TimeZone = "timepiece_TimeZone"
    }
    
    // MARK: - Get components
    
    var year: Int {
        return components.year!
    }
    
    var month: Int {
        return components.month!
    }
    
    var weekday: Int {
        return components.weekday!
    }
    
    var day: Int {
        return components.day!
    }
    
    var hour: Int {
        return components.hour!
    }
    
    var minute: Int {
        return components.minute!
    }
    
    var second: Int {
        return components.second!
    }
    
    var timeZone: NSTimeZone {
        return objc_getAssociatedObject(self, &AssociatedKeys.TimeZone) as? NSTimeZone ?? calendar.timeZone as NSTimeZone
    }
    
    fileprivate var components: DateComponents {
        return (calendar as NSCalendar).components([.year, .month, .weekday, .day, .hour, .minute, .second], from: self)
    }
    
    fileprivate var calendar: NSCalendar {
        return (NSCalendar.autoupdatingCurrent as NSCalendar)
    }
    
    // MARK: - Initialize
    
    static func date(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date {
        let now = Date()
        return now.change(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
    
    static func date(year: Int, month: Int, day: Int) -> Date {
        return Date.date(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
    }
    
    static func today() -> Date {
        let now = Date()
        return Date.date(year: now.year, month: now.month, day: now.day)
    }
    
 
    // MARK: - Initialize by setting components
    
    /**
     Initialize a date by changing date components of the receiver.
     */
    func change(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) -> Date! {
        var components = self.components
        components.year = year ?? self.year
        components.month = month ?? self.month
        components.day = day ?? self.day
        components.hour = hour ?? self.hour
        components.minute = minute ?? self.minute
        components.second = second ?? self.second
        return calendar.date(from: components)
    }
    
    /**
     Initialize a date by changing the weekday of the receiver.
     */
    
    /**
     Initialize a date by changing the time zone of receiver.
     */
    func change(timeZone: NSTimeZone) -> Date! {
        let originalTimeZone = calendar.timeZone
        calendar.timeZone = timeZone as TimeZone
        
        let newDate = calendar.date(from: components)!
        newDate.calendar.timeZone = timeZone as TimeZone
        objc_setAssociatedObject(newDate, &AssociatedKeys.TimeZone, timeZone, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        calendar.timeZone = originalTimeZone
        
        return newDate
    }
    
    // MARK: - Initialize a date at beginning/end of each units
    
    public var beginningOfYear: Date {
        return change(month: 1, day: 1, hour: 0, minute: 0, second: 0)
    }
    
    
    
    public var beginningOfHour: Date {
        return change(minute: 0, second: 0)
    }
    
    // MARK: - Format dates
    
    func stringFromFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.calendar = Calendar.autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // MARK: - Differences
    
    func differenceWith(_ date: Date, inUnit unit: NSCalendar.Unit) -> Int {
        return (calendar.components(unit, from: self, to: date, options: []) as NSDateComponents).value(forComponent: unit)
    }
}

