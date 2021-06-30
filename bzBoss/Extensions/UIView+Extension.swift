//
//  UIView+Extension.swift
//  FirstPass
//
//  Created by Vinitha on 03/06/21.
//  Copyright © 2021 Sathishkumar Muthukumar. All rights reserved.
//




import Foundation
import UIKit

@IBDesignable class MyUIView: UIView {}


extension UIView {
    func commonInit(_ nibName: String) {
        guard let view = loadViewFromNib(nibName) else {
            return
        }
        view.addAsSubViewWithEqualConstraintTo(self)
    }
    
    func loadViewFromNib(_ nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func addAsSubViewWithEqualConstraintTo(_ containerView: UIView) {
        self.frame = containerView.bounds
        containerView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0.0),
            self.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0.0),
            self.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0.0),
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0.0)
        ])
    }
    
    
    
}


extension MyUIView{
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    func addBackgroundShadow(){
        
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.masksToBounds = false
        
    }
    
}
