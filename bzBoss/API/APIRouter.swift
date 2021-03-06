
import Foundation
import Alamofire

enum APIRouter : URLRequestConvertible {
    //Auth
    case registerUser(params:[String:Any])
    case loginUser(params:[String:Any])
    case shopDetails(params:[String:Any])
    case userConfig(params:[String:Any])
    case premisedata(params:[String:Any])
    case staffdetails(params:[String:Any])
    case individualstaffdetails(params:[String:Any])
    case contactUs(params:[String:Any])
    case knownVisitors(params:[String:Any])
    case individualKnownVisitorsdetails(params:[String:Any])
    case listShops

    // MARK: - HTTPMethod
    private var method : HTTPMethod{
        switch self{
        case .registerUser,.loginUser,.shopDetails,.userConfig,.premisedata,.staffdetails,.individualstaffdetails,.contactUs,.knownVisitors,.individualKnownVisitorsdetails:
            return .post
//        case .editFamilyMember,.editInsurance:
//            return .put
//        case .deleteFamilyMember,.deleteInsurance:
//            return .delete
//        case .setPassword:
//            return .patch
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .registerUser:
            return "user/register"
        case .loginUser:
            return "user/login"
        case .shopDetails:
            return "user/premise"
        case .userConfig:
            return "user/userconfig"
        case .premisedata:
            return "user/premise/graph"
        case .staffdetails:
            return "user/staff"
        case .individualstaffdetails:
            return "user/staff/details"
        case .listShops:
            return "user/home/data"
        case .knownVisitors:
            return "user/knownvisitors"
        case .individualKnownVisitorsdetails:
            return "user/knownvisitors/details"
        case .contactUs:
            return "contact/us"
            
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters?
    {
        switch self
        {
        
        case .registerUser(let params):
            return params
        case .loginUser(let params):
            return params
        case .shopDetails(let params):
            return params
        case .userConfig(let params):
            return params
        case .premisedata(let params):
            return params
        case .staffdetails(let params):
            return params
        case .individualstaffdetails(let params):
            return params
        case .contactUs(let params):
            return params
        case .knownVisitors(let params):
            return params
        case .individualKnownVisitorsdetails(let params):
            return params
        case .listShops:
            return nil
        }
    }
    func asURLRequest() throws -> URLRequest
    {
        let url = try DataService.developmentBaseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 20
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch path {
        case "auth/register":
        break//"No auth token needed
        case "auth/login":
        break//"No auth token needed
        default:
            urlRequest.setValue(UserDefaults.standard.string(forKey: "Authorization"), forHTTPHeaderField: "Authorization")
            print(urlRequest)
        }
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
