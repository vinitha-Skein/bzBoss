//
//  individualKnownVisitorsModel.swift
//  bzBoss
//
//  Created by Vinitha on 28/07/21.
//

import Foundation
struct individualKnownVisitorsModel : Codable
{
    let status_code : Int?
    let message : String?
    let data : individualKnownVisitorsDetails?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case message = "message"
        case data = "data"
    }
    
}
struct individualKnownVisitorsDetails : Codable {
let knownVisitorsData : [individualKnownVisitorsDetailsData]?

enum CodingKeys: String, CodingKey {
    
    case knownVisitorsData = "knownVisitorsData"
}

}


struct individualKnownVisitorsDetailsData : Codable
{
    let known_visitors_id : Int?
    let token_id : String?
    let premise_id : Int?
    let date_time_recorded : String?
    let first_name : String?
    let last_name : String?
    let photo : String?
    let created_at : String?
    let updated_at : String?
    let knownvisitorsdata : [Knownvisitorsdata]?
    
    enum CodingKeys: String, CodingKey {
        
        case known_visitors_id = "known_visitors_id"
        case token_id = "token_id"
        case premise_id = "premise_id"
        case date_time_recorded = "date_time_recorded"
        case first_name = "first_name"
        case last_name = "last_name"
        case photo = "photo"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case knownvisitorsdata = "knownvisitorsdata"
    }
}


struct Knownvisitorsdata : Codable
{
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

