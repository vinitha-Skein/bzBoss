//
//  SignInViewController.swift
//  bzBoss
//
//  Created by Skeintech on 30/06/21.
//

import UIKit
import FirebaseAuth
import CryptoSwift


class SignInViewController: UIViewController
{
    @IBOutlet var mobile_BgView: UIView!
    @IBOutlet var numberTextFeild: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var IndicatorView: UIView!
    @IBOutlet weak var indicatorText: UILabel!
    var verificationID = String()
    var validation = Validation()
    var phoneNumber = String()
    let viewModel = SignInViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        mobile_BgView.layer.cornerRadius = 8
        mobile_BgView.layer.borderWidth = 1
        mobile_BgView.layer.borderColor = UIColor.lightGray.cgColor
        numberTextFeild.delegate = self
        IndicatorView.isHidden = true
        addDoneButtonOnKeyboard()
        // Do any additional setup after loading the view.
    }
    func addDoneButtonOnKeyboard()
    {
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

        numberTextFeild.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction()
        {
            numberTextFeild.resignFirstResponder()
        }
    @IBAction func back_Clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
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
        else {
            userlogin(phone: phone)
//           print(encryptData(str: phone))
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
//            vc.phoneNumber = self.phoneNumber ?? ""
//            vc.verificationID = self.verificationID ?? ""
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
          
        
    }
    @IBAction func termsandConditions_clicked(_ sender: Any)
    {
        if let url = URL(string: DataService.Terms_Condition) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func policies_Clicked(_ sender: Any)
    {
        if let url = URL(string: DataService.Privacy_policy) {
            UIApplication.shared.open(url)
        }
    }
    func userlogin(phone: String)
    {
        //self.activityIndicator(self.view, startAnimate: true)
                IndicatorView.isHidden = false
                activityIndicator.startAnimating()
                let params = [
                  "phone_number": encryptData(str: phone)]
                print(params)
                viewModel.loginUser(params: params)
                viewModel.loginSuccess =
                    {
                    //UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        self.FirebaseCall()
                        let alerttext = self.viewModel.signInUserData?.access_level
                        print("error \(alerttext)")
                }
        
                viewModel.loadingStatus =
                {
                    if self.viewModel.isLoading{
                        //self.activityIndicator(self.view, startAnimate: true)
                        self.IndicatorView.isHidden = false
                    }
                    else
                    {
                        //self.activityIndicator(self.view, startAnimate: false)
                        self.IndicatorView.isHidden = true
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                }
        
                viewModel.errorHited =
                    {
                        if self.viewModel.errorHit
                        {   print("Hit \(self.viewModel.errorMessage)")
                            self.showAlert("This Phone number Not Exist in our record")
                        }
                        else
                        {
                            
                        }
                }
        viewModel.errorMessageAlert = {
            self.showAlert("Unable to Connect to Server")
        }
    }
    func FirebaseCall()
    {
                        IndicatorView.isHidden = false
                          activityIndicator.startAnimating()
                         // indicatorText.text = "Please Wait While we are Sending OTP"
                          phoneNumber = "+91" + numberTextFeild.text!
                          Auth.auth().settings?.isAppVerificationDisabledForTesting = false
                          PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)
      
                          { (verificationID, error) in
                          if let error = error
                              {
                                  print(error.localizedDescription)
                                  self.IndicatorView.isHidden = true
                            self.showAlert("Verification Failed")
                                  return
                            
                              }
                              else
                              {
                                print(verificationID)
                                  self.verificationID = verificationID ?? "No Value"
                                  print(self.verificationID)
                                let token = String(self.viewModel.signInUserData?.token ?? "No data")
                                    UserDefaults.standard.set("Bearer \(token)", forKey: "Authorization")
                                UserDefaults.standard.set(self.viewModel.signInUserData?.user_id, forKey: "user_id")

                                  self.IndicatorView.isHidden = true
                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                                vc.phoneNumber = self.phoneNumber ?? ""
                                vc.verificationID = self.verificationID ?? ""
                                  vc.modalPresentationStyle = .fullScreen
                                  self.present(vc, animated: true, completion: nil)
                              }
                          }
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

