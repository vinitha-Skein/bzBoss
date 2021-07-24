//
//  DashboardTableviewCell.swift
//  bzBoss
//
//  Created by Vinitha on 05/07/21.
//

import UIKit

class DashboardTableviewCell: UITableViewCell {

    @IBOutlet weak var ShopNameLabel: UILabel!
    
    @IBOutlet weak var shopAddressLabel: UILabel!
    
    @IBOutlet weak var statusView: MyUIView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var ShopImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
