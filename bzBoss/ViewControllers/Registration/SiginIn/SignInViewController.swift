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
        // Do any additional setup after loading the view.
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
            userlogin()
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
    func userlogin()
    {
        //self.activityIndicator(self.view, startAnimate: true)
                IndicatorView.isHidden = false
                activityIndicator.startAnimating()
                let params = [
                  "phone_number": "eVdpYmlZYTRGcXdPS3FWRWFpcGdnZz09"]
                viewModel.loginUser(params: params)
                viewModel.loginSuccess =
                    {
                    //UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        self.FirebaseCall()
                        let alerttext = self.viewModel.signInUserData?.access_level
                        print("error \(alerttext)")

                }
        
                viewModel.loadingStatus = {
                    if self.viewModel.isLoading{
                        self.activityIndicator(self.view, startAnimate: true)
                    }
                    else
                    {
                        self.activityIndicator(self.view, startAnimate: false)
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                }
        
                viewModel.errorMessageAlert = {
                    self.showAlert(self.viewModel.errorMessage ?? "Error")
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
                                  return
                              }
                              else
                              {
                                  self.verificationID = verificationID ?? "No Value"
                                  print(self.verificationID)
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

