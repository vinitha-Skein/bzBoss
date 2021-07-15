//
//  SignUpViewController.swift
//  bzBoss
//
//  Created by Skeintech on 29/06/21.
//

import UIKit
import iOSDropDown
import FirebaseAuth
import FirebaseMessaging
import FirebaseInstanceID



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
    let viewModel = SignUpViewModel()
    var phoneNumber = String()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        mobileTextFeild.delegate = self
        firstNameTextFeild.delegate = self
        lastNameTextFeild.delegate = self
        accessLevelTextFeild.delegate = self
        // Do any additional setup after loading the view.
        accessLevelTextFeild.optionArray = ["Manager", "Staff", "Other"]
//        accessLevelTextFeild.didSelect{(selectedText , index ,id) in
//        self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
//        }
//        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//            if let refreshedToken = InstanceID.instanceID().token() {
//                print("InstanceID token: \(refreshedToken)")
//            }
//        }
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            InstanceID.instanceID().instanceID(handler: { (result, error) in
                if let error = error {
                    print("Error fetching remote instange ID: \(error)")
                } else if let result = result {
                    print("Remote instance ID token: \(result.token)")
                }
            })
        }
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
        else
        {
            userRegister()
            self.activityIndicator(self.view, startAnimate: true)
            let params = ["first_name":encryptData(str: firstName),
                          "last_name":encryptData(str: lastName),
                          "access_level":encryptData(str: accessLevel),
                          "phone_number": encryptData(str: phone),
                          "device_type":encryptData(str: "iOS"),
                          "device_token":"",
                          "time_zone":encryptData(str: "Asia/Calcutta"),
                          "type":""
                        ]
                    viewModel.signupUser(params: params)
                    viewModel.registerSuccess =
                        {
                        //UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            self.FirebaseCall()
                            let alerttext = self.viewModel.signupUserData?.first_name
                            print("error \(alerttext)")

                    }
            
                    viewModel.loadingStatus = {
                        if self.viewModel.isLoading
                        {
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
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func userRegister()
    {
   
    }
    func FirebaseCall()
    {
                         // indicatorText.text = "Please Wait While we are Sending OTP"
        phoneNumber = "+91" + mobileTextFeild.text!
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
                                print("Firebase Triggered")
                                  let verificationID = verificationID ?? "No Value"
                                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                  let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                                vc.phoneNumber = self.phoneNumber ?? ""
                                vc.verificationID = verificationID ?? ""
                                  vc.modalPresentationStyle = .fullScreen
                                  self.present(vc, animated: true, completion: nil)
                                let token = String(self.viewModel.signupUserData?.token ?? "No data")
                                UserDefaults.standard.set("Bearer \(token)", forKey: "Authorization")

                              }
                          }
    }
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



/*
if #available(iOS 13.0, *) {
    let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
    appDelegate.gotoHome()
}
else
{
    // Fallback on earlier versions
}
*/
