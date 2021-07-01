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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mobile_BgView.layer.cornerRadius = 8
        mobile_BgView.layer.borderWidth = 1
        mobile_BgView.layer.borderColor = UIColor.lightGray.cgColor
        numberTextFeild.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verify_Clicked(_ sender: Any)
    {
                
            if(numberTextFeild.text == "")
            {
                let alert =  UIAlertController(title: "Empty Feilds!", message: "Kindly Fill the Phone Number.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else
            {
                    //IndicatorView.isHidden = false
                    //indicatorText.text = "Please Wait While we are Sending OTP"
                    let phoneNumber = "+91" + numberTextFeild.text! ?? "8848216020"
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
//                            self.verificationID = verificationID ?? "No Value"
//                            print(self.verificationID)
//                            self.otpLabel.isHidden = false
//                            self.IndicatorView.isHidden = true
//                            self.otpTextFeild.isHidden = false
                        }
                    }
            }
    
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
    }
    @IBAction func termsandConditions_clicked(_ sender: Any)
    {
        
    }
    @IBAction func policies_Clicked(_ sender: Any)
    {
        
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
