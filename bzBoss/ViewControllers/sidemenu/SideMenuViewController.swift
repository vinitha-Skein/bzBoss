//
//  ProfileViewController.swift
//  Eatzilla_Delivery
//
//  Created by saranya selvaraj on 27/03/19.
//  Copyright © 2019 EatZilla. All rights reserved.
//

import UIKit

protocol SideMenuDelegate:class {
    func sideMenuControllerSelected(menu:SideMenuItem)
}

class SideMenuViewController: UIViewController {
    
    let viewModel:SideMenuViewModel = SideMenuViewModel()
    
    @IBOutlet weak var listView: UITableView!
    
    var selectedIndexPath:IndexPath?
    weak var delegate:SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        listView.register(UINib(nibName: "SideMenuViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuViewCellID")
        listView.delegate = self
        listView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(selectedIndexPath != nil) {
            let cell:SideMenuViewCell = listView.cellForRow(at: selectedIndexPath!) as! SideMenuViewCell
            cell.configureText(selected: false)
        }
        selectedIndexPath = nil
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SideMenuViewCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuViewCellID", for: indexPath) as! SideMenuViewCell
        cell.titleLabel.text = (viewModel.sideMenuItems[indexPath.row]).rawValue
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedIndexPath != nil) {
            let cell:SideMenuViewCell = tableView.cellForRow(at: selectedIndexPath!) as! SideMenuViewCell
            cell.configureText(selected: false)
        }
        selectedIndexPath = indexPath
        
        let cell:SideMenuViewCell = tableView.cellForRow(at: indexPath) as! SideMenuViewCell
        cell.configureText(selected: true)
        
        dismiss(animated: true, completion: nil)
        if let del = delegate {
            del.sideMenuControllerSelected(menu: viewModel.sideMenuItems[indexPath.row])
        }
        
    }
}

