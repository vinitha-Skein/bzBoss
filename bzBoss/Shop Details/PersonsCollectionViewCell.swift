//
//  PersonsCollectionViewCell.swift
//  bzBoss
//
//  Created by Vinitha on 16/08/21.
//

import UIKit
import iOSDropDown

class PersonsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var visitLabel: UILabel!
    
    @IBOutlet weak var targetValueLabel: DropDown!
    
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var personsLabel: UILabel!
    
    @IBOutlet weak var donutViewCahrt: DonutView!
    
    @IBOutlet weak var viewBackGround: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
