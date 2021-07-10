//
//  SignUpViewModel.swift
//  bzBoss
//
//  Created by Skeintech on 09/07/21.
//

import Foundation
import Alamofire
class SignUpViewModel {
    //Properties
     var signupUserData:RegisterUserData?{
        didSet{
            self.registerSuccess?()
        }
    }
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
    var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    
    //Closures for callback
    var registerSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //Signup user
    func signupUser(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.registerUser(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                if responseData.status_code == 200{
                    switch responseData.status_code!{
                    case 200..<300:
                            if responseData.data != nil{
                                let jsonData = try! JSONEncoder().encode(responseData.data)
                                let decoder = JSONDecoder()
                                
                                do
                                {
                                    self.signupUserData = responseData.data
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }else{
                                self.errorMessage = responseData.message
                                self.errorMessageAlert?()
                            }
                    case 400..<500:
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
                    }
                }else{
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
                self.error = error
                self.isLoading = false
            }
        }
        
        
        //        let headers: HTTPHeaders = [.contentType("application/json"),.accept("application/json")]
        //        AF.request("http://202.65.159.118:8094/firstpass-app/auth/login", method: .post, parameters:params,headers: headers).responseJSON(completionHandler: {response in
        //            switch response.result{
        //            case .success(let responseData):
        //                print(responseData)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        })
    }
}
