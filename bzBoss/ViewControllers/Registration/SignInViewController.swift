//
//  SignInViewController.swift
//  bzBoss
//
//  Created by Skeintech on 30/06/21.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet var mobile_BgView: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mobile_BgView.layer.cornerRadius = 8
        mobile_BgView.layer.borderWidth = 1
        mobile_BgView.layer.borderColor = UIColor.lightGray.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func verify_Clicked(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    @IBAction func termsandConditions_clicked(_ sender: Any)
    {
        
    }
    @IBAction func policies_Clicked(_ sender: Any)
    {
        
    }
}
