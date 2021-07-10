

import Foundation
struct ShopDetailsModel : Codable
{
	let status_code : Int?
	let message : String?
	let data : ShopdetailsData?

	enum CodingKeys: String, CodingKey
    {

		case status_code = "status_code"
		case message = "message"
		case data = "data"
	}
}
struct Getcurrentstatus : Codable {
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
struct ShopdetailsData : Codable {
    let premise_daily_data_id : Int?
    let premise_id : Int?
    let date_time_recorded : String?
    let date : String?
    let opened_at : String?
    let opened_at_image : String?
    let closed_at : String?
    let known_visitors : String?
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
    let getcurrentstatus : Getcurrentstatus?
    let number_of_customersnumber : Int?
    let number_of_customers : String?
    let premisedata : Premisedata?
    let userconfigdata : Userconfigdata?
    let userpremise : Userpremise?

    enum CodingKeys: String, CodingKey {

        case premise_daily_data_id = "premise_daily_data_id"
        case premise_id = "premise_id"
        case date_time_recorded = "date_time_recorded"
        case date = "date"
        case opened_at = "opened_at"
        case opened_at_image = "opened_at_image"
        case closed_at = "closed_at"
        case known_visitors = "known_visitors"
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
        case getcurrentstatus = "getcurrentstatus"
        case number_of_customersnumber = "number_of_customersnumber"
        case number_of_customers = "number_of_customers"
        case premisedata = "premisedata"
        case userconfigdata = "userconfigdata"
        case userpremise = "userpremise"
    }
}
struct Premisedata : Codable {
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
struct Userconfigdata : Codable {
    let userconfigration_id : Int?
    let user_id : Int?
    let premise_id : Int?
    let date : String?
    let toggle : String?
    let targetstaff : String?
    let targetcust : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case userconfigration_id = "userconfigration_id"
        case user_id = "user_id"
        case premise_id = "premise_id"
        case date = "date"
        case toggle = "toggle"
        case targetstaff = "targetstaff"
        case targetcust = "targetcust"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
}
struct Userpremise : Codable {
    let user_premise_link_id : Int?
    let user_id : Int?
    let premise_id : Int?
    let opened_at : String?
    let first_customer : String?
    let customer : String?
    let staff : String?
    let closed_at : String?
    let visitors : String?
    let date_time_recorded : String?
    let active : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case user_premise_link_id = "user_premise_link_id"
        case user_id = "user_id"
        case premise_id = "premise_id"
        case opened_at = "opened_at"
        case first_customer = "first_customer"
        case customer = "customer"
        case staff = "staff"
        case closed_at = "closed_at"
        case visitors = "visitors"
        case date_time_recorded = "date_time_recorded"
        case active = "active"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

}
