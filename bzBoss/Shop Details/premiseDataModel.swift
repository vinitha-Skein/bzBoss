

import Foundation
struct premiseDataModel : Codable
{
	let status_code : Int?
	let message : String?
	let data : dataforPremise?

	enum CodingKeys: String, CodingKey
    {
		case status_code = "status_code"
		case message = "message"
		case data = "data"
	}
}
struct dataforPremise : Codable {
    let premisedata : Premisedata?
    let premisedailydata : [Premisedailydata]?
    
    enum CodingKeys: String, CodingKey {
        
        case premisedata = "premisedata"
        case premisedailydata = "premisedailydata"
    }
}
struct Premisedataforgraph : Codable {
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
    }


}

struct Premisedailydata : Codable {
    let premiseDailyDataId : Int?
    let premiseId : Int?
    let date_time_recorded : String?
    let date : String?
    let opened_at : String?
    let opened_at_image : String?
    let closed_at : String?
    let knownVisitors : Int?
    let first_customer_time : String?
    let first_customer_image : String?
    let number_of_customers_min : Int?
    let number_of_customers_max : Int?
    let number_of_known_customers_min : Int?
    let number_of_known_customers_max : Int?
    let number_of_vip_customers_min : Int?
    let number_of_vip_customers_max : Int?
    let number_of_staff_min : Int?
    let number_of_staff_max : Int?
    let number_of_known_visitors_min : Int?
    let number_of_known_visitors_max : Int?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case premiseDailyDataId = "premise_daily_data_id"
        case premiseId = "premise_id"
        case date_time_recorded = "date_time_recorded"
        case date = "date"
        case opened_at = "opened_at"
        case opened_at_image = "opened_at_image"
        case closed_at = "closed_at"
        case knownVisitors = "known_visitors"
        case first_customer_time = "first_customer_time"
        case first_customer_image = "first_customer_image"
        case number_of_customers_min = "number_of_customers_min"
        case number_of_customers_max = "number_of_customers_max"
        case number_of_known_customers_min = "number_of_known_customers_min"
        case number_of_known_customers_max = "number_of_known_customers_max"
        case number_of_vip_customers_min = "number_of_vip_customers_min"
        case number_of_vip_customers_max = "number_of_vip_customers_max"
        case number_of_staff_min = "number_of_staff_min"
        case number_of_staff_max = "number_of_staff_max"
        case number_of_known_visitors_min = "number_of_known_visitors_min"
        case number_of_known_visitors_max = "number_of_known_visitors_max"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
}


struct staffDetails : Codable{
    var name: String!
    var date: String!
    var staffImage: String!
}


