//
//  ProfileViewModel.swift
//  Eatzilla_Delivery
//
//  Created by saranya selvaraj on 27/03/19.
//  Copyright © 2019 EatZilla. All rights reserved.
//

import UIKit

enum SideMenuItem:String {
   
    case home = "Home"
    case privacyPolicy = "Privacy Policy"
    case TermsandConditions = "Terms and Condition"
    case aboutUs = "About Us"
    case contactUs = "Contact Us"
    case logout = "Logout"

}

class SideMenuViewModel: NSObject {

    var sideMenuItems:[SideMenuItem] = [.home, .privacyPolicy, .TermsandConditions , .aboutUs, .contactUs,.logout]
    

}
