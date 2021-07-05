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
        let storyboard = UIStoryboard(name: "Main1", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompanyDetailsViewController") as! CompanyDetailsViewController
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
        
        switch menu {
            
        case .aboutUs:
//            let faqController = sb.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
//            self.navigationController?.pushViewController(faqController, animated: true)
            print("AboutUs")
  
            
        case .logout:
            print("AboutUs")
          
            
        default:
            print("")
        }
        
    }
    
    
}
