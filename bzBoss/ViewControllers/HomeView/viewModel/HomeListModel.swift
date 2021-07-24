//
//  HomeListModel.swift
//  bzBoss
//
//  Created by Vinitha on 23/07/21.
//

import Foundation
struct HomeListModel : Codable {
    let status_code : Int?
    let message : String?
    let data : [HomeListData]?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case message = "message"
        case data = "data"
    }
}

struct HomeListData : Codable {
    let premise_id : Int?
    let token_id : String?
    let date_time_recorded : String?
    let title : String?
    let name : String?
    let sub_name : String?
    let address : String?
    let country : String?
    let state : String?
    let city : String?
    let photo : String?
    let reserved : String?
    let created_at : String?
    let updated_at : String?
    let data_availabel : String?
    let getpremisecurrentstatus : Getpremisecurrentstatus?
    
    enum CodingKeys: String, CodingKey {
        
        case premise_id = "premise_id"
        case token_id = "token_id"
        case date_time_recorded = "date_time_recorded"
        case title = "title"
        case name = "name"
        case sub_name = "sub_name"
        case address = "address"
        case country = "country"
        case state = "state"
        case city = "city"
        case photo = "photo"
        case reserved = "reserved"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case data_availabel = "data_availabel"
        case getpremisecurrentstatus = "getpremisecurrentstatus"
    }
}


struct Getpremisecurrentstatus : Codable {
    let premise_current_status_id : Int?
    let premise_id : Int?
    let date_time_recorded : String?
    let status : String?
    let last_updated : String?
    let image_filename : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case premise_current_status_id = "premise_current_status_id"
        case premise_id = "premise_id"
        case date_time_recorded = "date_time_recorded"
        case status = "status"
        case last_updated = "last_updated"
        case image_filename = "image_filename"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}
