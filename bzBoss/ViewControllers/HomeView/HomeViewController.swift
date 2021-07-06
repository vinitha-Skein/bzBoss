//
//  HomeViewController.swift
//  bzBoss
//
//  Created by Vinitha on 03/07/21.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    var leftMenu: SideMenuViewController = UIStoryboard(name: "Main1", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
    var rightBarButtonItem:UIBarButtonItem?

    @IBOutlet weak var companytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        companytableview.tableFooterView = MyUIView()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func RefreshListItem(_ sender: UIButton) {
    }
    
    
    @IBAction func barbuttonItem(_ sender: Any) {
        let sideMenuNavController: SideMenuNavigationController = SideMenuNavigationController.init(rootViewController: self.leftMenu)
        self.leftMenu.delegate = self
        sideMenuNavController.view.clipsToBounds = true
        sideMenuNavController.isNavigationBarHidden = true
        SideMenuManager.default.leftMenuNavigationController = sideMenuNavController
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuAnimationBackgroundColor = .black
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuAnimationFadeStrength = 0.4
        SideMenuManager.default.menuEnableSwipeGestures = false
        SideMenuManager.default.menuWidth = 280
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    func  gotoCompanyDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShopDetailsViewController") as! ShopDetailsViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableviewCell", for: indexPath) as! DashboardTableviewCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      gotoCompanyDetails()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension HomeViewController:SideMenuDelegate {
    
    func sideMenuControllerSelected(menu: SideMenuItem) {
        let sb = UIStoryboard(name: "Main1", bundle: nil)
        let sb1 = UIStoryboard(name: "Main", bundle: nil)
        
        switch menu {
          
        case .TermsandConditions:
        if let url = URL(string: DataService.Terms_Condition) {
            UIApplication.shared.open(url)
        }
            
        case .privacyPolicy:
            if let url = URL(string: DataService.Privacy_policy) {
                UIApplication.shared.open(url)
            }
        case .aboutUs:
            if let url = URL(string: DataService.About_us) {
                UIApplication.shared.open(url)
            }
        case .contactUs:
        let faqController = sb1.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        self.navigationController?.pushViewController(faqController, animated: true)
        print("AboutUs")
        case .logout:
            let alert = UIAlertController.init(title: nil, message: "Are you sure you want to logout?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "YES", style: .default, handler: { (action) in
                
                if #available(iOS 13.0, *) {
                    let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                    appDelegate.gotoOnboardingScreen()
                } else {
                    // Fallback on earlier versions
                }
            }))
            
            alert.addAction(UIAlertAction.init(title: "NO", style: .cancel, handler: { (action) in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
          
            
        default:
            print("")
        }
        
    }
    
    
}