//
//  PasswordViewController.swift
//  bzBoss
//
//  Created by Skeintech on 30/06/21.
//

import UIKit
import FirebaseAuth

class PasswordViewController: UIViewController {
    @IBOutlet var passwordBg_view: UIView!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var resendButton: UIButton!
    
    @IBOutlet weak var passwordTextfeild: UITextField!
    @IBOutlet var passwordresendView: UIView!
    var verificationID = String()
    var phoneNumber = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resendButton.isHidden = true
        // Do any additional setup after loading the view.
        passwordTextfeild.delegate = self
        passwordBg_view.layer.cornerRadius = 10
        passwordBg_view.layer.borderColor = UIColor.lightGray.cgColor
        passwordBg_view.layer.borderWidth = 1
        addDoneButtonOnKeyboard()
        
        
        var timeLeft = 30
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        { timer in
                        
                timeLeft -= 1
                        
                self.timerLabel.text = String(timeLeft)
                        
                if(timeLeft==0)
                {
                    self.passwordresendView.isHidden = true
                    self.resendButton.isHidden = false
                    timer.invalidate()
                }
            }
    }
    
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func resend_Clicked(_ sender: Any)
    {
        self.passwordresendView.isHidden = false
        resendButton.isHidden = true
        
        self.activityIndicator(self.view, startAnimate: true)
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil)

        { (verificationID, error) in
        if let error = error
            {
                print(error.localizedDescription)
                return
            }
            else
            {
                self.verificationID = verificationID!
                self.activityIndicator(self.view, startAnimate: false)
                self.timerON()
            }
        }

        
    }
    func timerON()
    {
        var timeLeft = 30

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true)
        { timer in
                print("timer fired!")
                        
                timeLeft -= 1
                        
                self.timerLabel.text = String(timeLeft)
                print(timeLeft)
                        
                if(timeLeft==0)
                {
                    self.passwordresendView.isHidden = true
                    self.resendButton.isHidden = false
                    timer.invalidate()
                }
            }
    }
    
     @IBAction func signin_clicked(_ sender: Any)
     {
        let otp = passwordTextfeild.text
        if (otp == "")
        {
            showAlert("Please enter the OTP")
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: passwordTextfeild.text!)
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil)
            {
                self.showAlert("Invalid OTP")
            }
            else
            {
                if #available(iOS 13.0, *)
                {
                    let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                    appDelegate.gotoHome()
                }
                else
                {
                    let storyboard = UIStoryboard(name: "Main1", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
            // Fallback on earlier versions
                }
            }
        }
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

            passwordTextfeild.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction()
        {
            passwordTextfeild.resignFirstResponder()
        }
     // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PasswordViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        passwordTextfeild.resignFirstResponder()
        return true
    }
}
