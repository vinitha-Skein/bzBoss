//
//  ContactUsViewController.swift
//  bzBoss
//
//  Created by Skeintech on 06/07/21.
//

import UIKit
import iOSDropDown


class ContactUsViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var emailTextFeild: UITextField!
    @IBOutlet weak var phoneTextFeild: UITextField!
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var categoryFeild: DropDown!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var nameView: UIView!
    var validation = Validation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setupUI()
    {
        messageView.layer.borderWidth = 0.5
        messageView.layer.borderColor = UIColor.black.cgColor
        messageView.layer.cornerRadius = 5
        categoryView.layer.borderWidth = 0.5
        categoryView.layer.borderColor = UIColor.black.cgColor
        categoryView.layer.cornerRadius = 5
        emailView.layer.borderWidth = 0.5
        emailView.layer.borderColor = UIColor.black.cgColor
        emailView.layer.cornerRadius = 5
        phoneView.layer.borderWidth = 0.5
        phoneView.layer.borderColor = UIColor.black.cgColor
        phoneView.layer.cornerRadius = 5
        nameView.layer.borderWidth = 0.5
        nameView.layer.borderColor = UIColor.black.cgColor
        nameView.layer.cornerRadius = 5

        
        
        categoryFeild.optionArray = ["Business enquiry", "Support request", "Terms & Conditions/Privacy policy"]
//        accessLevelTextFeild.didSelect{(selectedText , index ,id) in
//        self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
//        }

    }
    
    @IBAction func backnbuttonpressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func send_clicked(_ sender: Any)
    {
        validate()
    }
    func validate()
   {
    guard let name = nameTextFeild.text,let phone = phoneTextFeild.text, let category = categoryFeild.text,let email = emailTextFeild.text,let message = messageTextView.text else
    {
        return
    }
    let isValidatephone = self.validation.validaPhoneNumber(phoneNumber: phone)
    if (isValidatephone == false)
    {
        self.showAlert("Please enter valid Phone number")
        return
    }
    let isValidateFirstName = self.validation.validateName(name: name)
    if (isValidateFirstName == false)
    {
        self.showAlert("First name shoulud be atleast 3 chars")
        return
    }
    let isValidateEmail = self.validation.validateEmailId(emailID: email)
    if (isValidateEmail == false)
    {
        self.showAlert("First name shoulud be atleast 3 chars")
        return
    }
    if (category == "")
    {
        self.showAlert("Please Select the your Category")
    }
    if (message == "")
    {
        self.showAlert("Please fill the Message Feild")
    }
   }
    func showAlert(_ message:String)
    {
        let alert = UIAlertController(title: "BZBoss", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
