

import Foundation
import Alamofire
class APIClient {
    @discardableResult
        private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (AFResult<T>)->Void) -> DataRequest {
            return AF.request(route)
                .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                    print(response.result)
                    if let contentType = response.response?.allHeaderFields["Authorization"] as? String {
                        UserDefaults.standard.set(contentType, forKey: "Authorization")
                    }
                    completion(response.result)
            }
        }

    
    //User Auth
//    static func registerUser(params:[String:Any],completion:@escaping(AFResult<RegisterNewUser>)->Void){
//        performRequest(route: APIRouter.registerUser(params: params),completion: completion)
//    }
//    static func loginUser(params:[String:Any],completion:@escaping(AFResult<LoginUser>)->Void){
//        performRequest(route: APIRouter.loginUser(params: params),completion: completion)
//    }
  
    
  
}
