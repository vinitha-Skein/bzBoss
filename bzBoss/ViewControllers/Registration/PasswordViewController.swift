//
//  PasswordViewController.swift
//  bzBoss
//
//  Created by Skeintech on 30/06/21.
//

import UIKit

class PasswordViewController: UIViewController {
    @IBOutlet var passwordBg_view: UIView!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var resendButton: UIButton!
    
    @IBOutlet var passwordresendView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resendButton.isHidden = true
        // Do any additional setup after loading the view.
        passwordBg_view.layer.cornerRadius = 10
        passwordBg_view.layer.borderColor = UIColor.lightGray.cgColor
        passwordBg_view.layer.borderWidth = 1
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
    
    @IBAction func resend_Clicked(_ sender: Any)
    {
        self.passwordresendView.isHidden = false
        resendButton.isHidden = true
        
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
