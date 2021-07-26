//
//  contactUSModel.swift
//  bzBoss
//
//  Created by Vinitha on 24/07/21.
//

import Foundation

struct contactUSModel : Codable {
    let status_code : Int?
    let message : String?
    let data : ContactUsData?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case message = "message"
        case data = "data"
    }
}
struct ContactUsData : Codable {
    let all : String?
    
    enum CodingKeys: String, CodingKey {
        
        case all = "all"
    }
}
