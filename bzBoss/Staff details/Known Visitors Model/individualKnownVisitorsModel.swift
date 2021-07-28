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
    let staffDetailsData : [individualKnownVisitorsDetailsData]?
    
    enum CodingKeys: String, CodingKey {
        
        case staffDetailsData = "staffDetailsData"
    }
}
struct individualKnownVisitorsDetailsData : Codable {
    let staff_id : Int?
    let token_id : String?
    let premise_id : Int?
    let date_time_recorded : String?
    let first_name : String?
    let last_name : String?
    let title : String?
    let photo : String?
    let created_at : String?
    let updated_at : String?
//    let staffdata : [KnownVisitorsdata]?
    
    enum CodingKeys: String, CodingKey {
        
        case staff_id = "staff_id"
        case token_id = "token_id"
        case premise_id = "premise_id"
        case date_time_recorded = "date_time_recorded"
        case first_name = "first_name"
        case last_name = "last_name"
        case title = "title"
        case photo = "photo"
        case created_at = "created_at"
        case updated_at = "updated_at"
//        case staffdata = "staffdata"
    }
    
    
    
}

struct KnownVisitorsdata : Codable
{
    let staff_log_id : Int?
    let premise_daily_data_id : Int?
    let date_time_recorded : String?
    let staff_id : Int?
    let staff_name : String?
    let number_of_appearances : Int?
    let threshold : String?
    let first_appearance_date_time : String?
    let first_appearance_image : String?
    let first_appearance_score : Int?
    let max_score_date_time : String?
    let max_score_image : String?
    let max_score : Int?
    let duration : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case staff_log_id = "staff_log_id"
        case premise_daily_data_id = "premise_daily_data_id"
        case date_time_recorded = "date_time_recorded"
        case staff_id = "staff_id"
        case staff_name = "staff_name"
        case number_of_appearances = "number_of_appearances"
        case threshold = "threshold"
        case first_appearance_date_time = "first_appearance_date_time"
        case first_appearance_image = "first_appearance_image"
        case first_appearance_score = "first_appearance_score"
        case max_score_date_time = "max_score_date_time"
        case max_score_image = "max_score_image"
        case max_score = "max_score"
        case duration = "duration"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    
}
