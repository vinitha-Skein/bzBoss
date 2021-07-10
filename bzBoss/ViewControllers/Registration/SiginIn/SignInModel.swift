/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct userSignIn : Codable
{
	let status_code : Int?
	let message : String?
	let data : SignInData?

	enum CodingKeys: String, CodingKey
    {

		case status_code = "status_code"
		case message = "message"
		case data = "data"
	}

}
struct SignInData : Codable
{
    let user_id : Int?
    let first_name : String?
    let last_name : String?
    let phone_number : String?
    let token_id : String?
    let access_level : String?
    let logged_in_status : String?
    let active : String?
    let reserved : String?
    let device_token : String?
    let is_block : String?
    let is_admin : String?
    let is_delete : String?
    let device_type : String?
    let user_type : String?
    let login_count : Int?
    let last_login_time : String?
    let created_at : String?
    let updated_at : String?
    let time_zone : String?
    let token : String?
    let all : String?

    enum CodingKeys: String, CodingKey {

        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case phone_number = "phone_number"
        case token_id = "token_id"
        case access_level = "access_level"
        case logged_in_status = "logged_in_status"
        case active = "active"
        case reserved = "reserved"
        case device_token = "device_token"
        case is_block = "is_block"
        case is_admin = "is_admin"
        case is_delete = "is_delete"
        case device_type = "device_type"
        case user_type = "user_type"
        case login_count = "login_count"
        case last_login_time = "last_login_time"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case time_zone = "time_zone"
        case token = "token"
        case all = "all"
    }

    

}

