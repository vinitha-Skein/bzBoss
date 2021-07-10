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
    
     @IBAction func signin_clicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            appDelegate.gotoHome()
        } else
        {
            let storyboard = UIStoryboard(name: "Main1", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            // Fallback on earlier versions
        }
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
