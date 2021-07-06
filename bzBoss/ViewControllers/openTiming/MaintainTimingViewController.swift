//
//  MaintainTimingViewController.swift
//  bzBoss
//
//  Created by Vinitha on 06/07/21.
//

import UIKit

class MaintainTimingViewController: UIViewController {

    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var isfrom = ""
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isfrom == "OpenedAt" {
            titleLabel.text = "OPENED AT 11:13 PM"
        } else if isfrom == "FirstCustomer" {
            titleLabel.text = "FIRST CUSTOMER 11:13 PM"
        } else if isfrom == "ClosedAt"{
            titleLabel.text = "CLOSED AT 11:13 PM"
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func companydetailsPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func imagePressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "PhotoPreview", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        vc.image = imageView.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
