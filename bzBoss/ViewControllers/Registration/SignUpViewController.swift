//
//  SignUpViewController.swift
//  bzBoss
//
//  Created by Skeintech on 29/06/21.
//

import UIKit
import iOSDropDown

class SignUpViewController: UIViewController {

    @IBOutlet var scrollViewContainer: UIView!
    @IBOutlet var firstNameTextFeild: UITextField!
    @IBOutlet var accessLevelView: UIView!
    @IBOutlet var lastNameTextFeild: UITextField!
    @IBOutlet var lastNameView: UIView!
    
    @IBOutlet var accessLevelTextFeild: DropDown!
    @IBOutlet var sigupButton: UIButton!
    @IBOutlet var firstNameView: UIView!
    @IBOutlet var mobileTextFeild: UITextField!
    @IBOutlet var mobileView: UIView!
    @IBOutlet var container: UIView!
    var validation = Validation()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        mobileTextFeild.delegate = self
        firstNameTextFeild.delegate = self
        lastNameTextFeild.delegate = self
        accessLevelTextFeild.delegate = self
        // Do any additional setup after loading the view.
        accessLevelTextFeild.optionArray = ["Manager", "Staff", "User"]
//        accessLevelTextFeild.didSelect{(selectedText , index ,id) in
//        self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
//        }
    }
    func setupUI()
    {
        scrollViewContainer.layer.cornerRadius = 60
        container.layer.cornerRadius = 60
        mobileView.layer.borderWidth = 0.7
        mobileView.layer.borderColor = UIColor.lightGray.cgColor
        mobileView.layer.cornerRadius = 5
        firstNameView.layer.borderWidth = 0.7
        firstNameView.layer.borderColor = UIColor.lightGray.cgColor
        firstNameView.layer.cornerRadius = 5
        lastNameView.layer.borderWidth = 0.7
        lastNameView.layer.borderColor = UIColor.lightGray.cgColor
        lastNameView.layer.cornerRadius = 5
        accessLevelView.layer.borderWidth = 0.7
        accessLevelView.layer.borderColor = UIColor.lightGray.cgColor
        accessLevelView.layer.cornerRadius = 5
        sigupButton.layer.cornerRadius = 8
        
    }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signup_Clicked(_ sender: Any)
    {
        guard let firstName = firstNameTextFeild.text,let lastName = lastNameTextFeild.text,let phone = mobileTextFeild.text, let accessLevel = accessLevelTextFeild.text else
        {
            if #available(iOS 13.0, *) {
                let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                appDelegate.gotoHome()
            } else {
                // Fallback on earlier versions
            }
            return
        }
        let isValidatephone = self.validation.validaPhoneNumber(phoneNumber: phone)
        if (isValidatephone == false)
        {
            self.showAlert("Please enter valid Phone number")
            return
        }
        let isValidateFirstName = self.validation.validateName(name: firstName)
        if (isValidateFirstName == false)
        {
            self.showAlert("First name shoulud be atleast 3 chars")
            return
        }
        if (accessLevel == "")
        {
            self.showAlert("Please Select the your Access Level")
        }
        else {
            if #available(iOS 13.0, *) {
                let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                appDelegate.gotoHome()
            } else
            {
                // Fallback on earlier versions
            }
        }
        
    }
    func showAlert(_ message:String)
    {
        let alert = UIAlertController(title: "BZBoss", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
extension SignUpViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        mobileTextFeild.resignFirstResponder()
        firstNameTextFeild.resignFirstResponder()
        lastNameTextFeild.resignFirstResponder()
        accessLevelTextFeild.resignFirstResponder()
        return true
    }
}
