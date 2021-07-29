//
//  knownVisitorsDataModel.swift
//  bzBoss
//
//  Created by Vinitha on 28/07/21.
//

import Foundation

struct knownVisitorsDataModel : Codable {
    let status_code : Int?
    let message : String?
    let Responsedata : [KnownVisitorsOnDate]?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case message = "message"
        case Responsedata = "data"
    }
}

struct KnownVisitorsOnDate : Codable {
    let known_visitors_log_id : Int?
    let premise_daily_data_id : Int?
    let known_visitors_id : Int?
    let known_visitors_name : String?
    let date_time_recorded : String?
    let appearance_date_time : String?
    let appearance_image : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case known_visitors_log_id = "known_visitors_log_id"
        case premise_daily_data_id = "premise_daily_data_id"
        case known_visitors_id = "known_visitors_id"
        case known_visitors_name = "known_visitors_name"
        case date_time_recorded = "date_time_recorded"
        case appearance_date_time = "appearance_date_time"
        case appearance_image = "appearance_image"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}

