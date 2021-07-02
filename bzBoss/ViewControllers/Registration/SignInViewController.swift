//
//  SignInViewController.swift
//  bzBoss
//
//  Created by Skeintech on 30/06/21.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet var mobile_BgView: UIView!
    @IBOutlet var numberTextFeild: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var IndicatorView: UIView!
    @IBOutlet weak var indicatorText: UILabel!
    var verificationID = String()
    var validation = Validation()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        mobile_BgView.layer.cornerRadius = 8
        mobile_BgView.layer.borderWidth = 1
        mobile_BgView.layer.borderColor = UIColor.lightGray.cgColor
        numberTextFeild.delegate = self
        IndicatorView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verify_Clicked(_ sender: Any)
    {
        guard let phone = numberTextFeild.text
        else{return}
        let isValidatephone = self.validation.validaPhoneNumber(phoneNumber: phone)
        if (isValidatephone == false)
        {
            self.showAlert("Please enter valid Phone number")
            return
        }
        else
            {
                    IndicatorView.isHidden = false
                    activityIndicator.startAnimating()
                    //indicatorText.text = "Please Wait While we are Sending OTP"
                    let phoneNumber = "+91" + numberTextFeild.text!
                    Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
            
                    { (verificationID, error) in
                    if let error = error
                        {
                            print(error.localizedDescription)
                            return
                        }
                        else
                        {
                            self.verificationID = verificationID ?? "No Value"
                            print(self.verificationID)
                            self.IndicatorView.isHidden = true
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
            }
    
        
    }
    @IBAction func termsandConditions_clicked(_ sender: Any)
    {
        
    }
    @IBAction func policies_Clicked(_ sender: Any)
    {
        
    }
    func showAlert(_ message:String)
    {
        let alert = UIAlertController(title: "BZBoss", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension SignInViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        numberTextFeild.resignFirstResponder()
        return true
    }
}
