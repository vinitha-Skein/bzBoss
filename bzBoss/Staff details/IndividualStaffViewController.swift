//
//  IndividualStaffViewController.swift
//  bzBoss
//
//  Created by Skeintech on 08/07/21.
//

import UIKit

class IndividualStaffViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var staffImage: UIImageView!
    
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        staffImage.isUserInteractionEnabled = true
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeRight.direction = .right
            self.staffImage.addGestureRecognizer(swipeRight)

            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
            swipeLeft.direction = .left
            self.staffImage.addGestureRecognizer(swipeLeft)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back_clicked(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer)
    {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {

            switch swipeGesture.direction {
            case .right:
                swippedRight()
            case .left:
                swippedLeft()
            default:
                break
            }
        }
    }
    
    func swippedRight()
    {
        print("Right swiped")
    }
    
    func swippedLeft()
    {
        print("Left Swipped")
    }
    
}
