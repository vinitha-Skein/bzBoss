//
//  Extension.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 17/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift


extension UIView{
    func createBorderForView(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func createCircle(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}
extension UIButton{
    func createBorderForButton(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
extension UITextField{
    func createBorderForTextfield(cornerRadius:CGFloat,borderWidth:CGFloat,borderColor:UIColor){
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        addPaddingAndBorder(to: self)
    }
    func addPaddingAndBorder(to textfield: UITextField) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 2.0))
        textfield.leftView = leftView
        textfield.leftViewMode = .always
    }
    
    func addRightView(imageName:String){
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
        
    }
}
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}





protocol OTPDelegate: class {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
}

class OTPTextField: UITextField {
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
    func underlined(){
        let border = CALayer()
        let width = CGFloat(5.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
class OTPStackView: UIStackView {
    
    //Customise the OTPField here
    let numberOfFields = 6
    var textFieldsCollection: [OTPTextField] = []
    weak var delegate: OTPDelegate?
    var showsWarningColor = false
    
    //Colors
    let inactiveFieldBorderColor = UIColor.black//UIColor(white: 1, alpha: 0.3)
    let textBackgroundColor = UIColor(white: 1, alpha: 0.5)
    let activeFieldBorderColor = UIColor.lightGray
    var remainingStrStack: [String] = []
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    //Customisation and setting stackView
    private final func setupStackView() {
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    //Adding each OTPfield to stack view
    private final func addOTPFields() {
        for index in 0..<numberOfFields{
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    //Customisation and setting OTPTextFields
    private final func setupTextField(_ textField: OTPTextField){
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(textField)
        textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 40).isActive = true
        textField.backgroundColor = textBackgroundColor
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.font = UIFont(name: "Kefa", size: 40)
        textField.textColor = .black
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        //        textField.textContentType = .oneTimeCode
        
        textField.underlined()
    }
    
    //checks if all the OTPfields are filled
    private final func checkForValidity(){
        for fields in textFieldsCollection{
            if (fields.text == ""){
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    //gives the OTP text
    final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    //set isWarningColor true for using it as a warning color
    final func setAllFieldColor(isWarningColor: Bool = false, color: UIColor){
        for textField in textFieldsCollection{
            textField.layer.borderColor = color.cgColor
        }
        showsWarningColor = isWarningColor
    }
    
    //autofill textfield starting from first
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForValidity()
        remainingStrStack = []
    }
    
}

//MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if showsWarningColor {
            setAllFieldColor(color: inactiveFieldBorderColor)
            showsWarningColor = false
        }
        textField.layer.borderColor = activeFieldBorderColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
    }
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}



enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}


extension UIViewController
{
    func encryptData(str: String) -> String
    {
       let datatoEncode = str
       var encrptedValue = String()
        do
        {
//
            let keyval = "12345678901234561234567890123456"
            let ivVal = "1234567890123456"
            let ivarray = Array(ivVal.utf8)
            
            
            let key1 = Array(keyval.utf8)
            let aes = try AES(key: key1, blockMode: CBC(iv: ivarray), padding: .pkcs5)
     

            let inputData = datatoEncode
            var arraySlice = Array(inputData.utf8)
            var datamain = inputData.data(using: .utf8)!
            let encryptedBytes = try aes.encrypt([UInt8](datamain))
            let encryptedData = Data(encryptedBytes)
            //print(encryptedData)
            let encval = encryptedData.base64EncodedString()
            //print("Encrypted Value: \(encval)")
            //print(encval)
           // print(encodeString(str: encval))
            encrptedValue = encodeString(str: encval)
        }
        catch
        {
            print("Went in catch")
        }
        
        return encrptedValue
    }
    
    func encodeString(str:String) -> String
    {
        let EncodeStr = str

        let utf8str = EncodeStr.data(using: .utf8)

        let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))

        return String(base64Encoded!)
    }
    
    func decodeString(str:String) -> String
    {
        let decodeStr = str

        guard let base64Decoded = Data(base64Encoded: decodeStr, options: Data.Base64DecodingOptions(rawValue: 0))
                .map({ String(data: $0, encoding: .utf8) }) else { return <#default value#> }
        
        return base64Decoded!
    }
    
    func rightToLeftTransition() -> CATransition{
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    func leftToRightTransition() -> CATransition{
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transition
    }
    func showAlert(_ message:String){
        let alert = UIAlertController(title: "BzBoss", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @discardableResult
    func activityIndicator(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.white
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.style =
            UIActivityIndicatorView.Style.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        return activityIndicatorView
    }
    func getAppointmentDateTime(date:String,format:String,requiredFormat:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateData = formatter.date(from: date)!
        formatter.dateFormat = requiredFormat
        return formatter.string(from: dateData)
    }
    func getAppointmentTime(date:String,format:String,requiredFormat:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateData = formatter.date(from: date)!
        formatter.dateFormat = requiredFormat
        return formatter.string(from: dateData)
    }
}

extension UITableViewCell{
    func getAppointmentDateTime(date:String,format:String,requiredFormat:String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateData = formatter.date(from: date)!
        formatter.dateFormat = requiredFormat
        return formatter.string(from: dateData)
    }
}
