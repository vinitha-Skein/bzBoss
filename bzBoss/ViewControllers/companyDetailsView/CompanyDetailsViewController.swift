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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
