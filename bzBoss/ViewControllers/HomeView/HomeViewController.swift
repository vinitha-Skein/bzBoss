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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarItems()
        // Do any additional setup after loading the view.
    }
    func configureNavBarItems() {
        let leftMenu: UIBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "sidemenu"), style: .plain, target: self, action: #selector(HomeViewController.showLeftMenu(_:)))
        leftMenu.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.23, green: 0.64, blue: 0.91, alpha: 1.00)
        self.navigationItem.leftBarButtonItem = leftMenu
    }

    @objc func showLeftMenu(_ sender:UIBarButtonItem) {
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
