//
//  TimingCollectionViewCell.swift
//  bzBoss
//
//  Created by Vinitha on 15/08/21.
//

import UIKit
import BEMAnalogClock

class TimingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewBAckground: Mybutton!
    @IBOutlet weak var clock: BEMAnalogClockView!
    
    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
