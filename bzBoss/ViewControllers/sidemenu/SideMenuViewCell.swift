//
//  SideMenuViewCell.swift
//  Eatzilla_Delivery
//
//  Created by saranya selvaraj on 27/03/19.
//  Copyright © 2019 EatZilla. All rights reserved.
//

import UIKit

class SideMenuViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configureText(selected: false)
    }
    
    func configureText(selected:Bool) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
