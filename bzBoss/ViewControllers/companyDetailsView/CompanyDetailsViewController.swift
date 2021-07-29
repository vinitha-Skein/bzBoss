//
//  CompanyDetailsViewController.swift
//  bzBoss
//
//  Created by Vinitha on 05/07/21.
//

import UIKit

class CompanyDetailsViewController: UIViewController {

    @IBOutlet weak var companynameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var statusView: MyUIView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var companyimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imagepreviewclicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "PhotoPreview", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhotoPreviewViewController") as! PhotoPreviewViewController
        vc.image = companyimage.image
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setData()
    {
        
        let city = String(UserDefaults.standard.string(forKey: "premiseCity") ??  "")
        let state = String(UserDefaults.standard.string(forKey: "premiseState") ?? "")
        companynameLabel.text = UserDefaults.standard.string(forKey: "premiseTitle")
        
        addressLabel.text = String("\(city), \(state)")
        timeLabel.text = UserDefaults.standard.string(forKey: "premiseDate")
        statusLabel.text = UserDefaults.standard.string(forKey: "premiseStatus")
        
        if(statusLabel.text == "Open")
        {
            statusView.backgroundColor = UIColor(hexString: Colors.statusgreen)
        }
    }

}
