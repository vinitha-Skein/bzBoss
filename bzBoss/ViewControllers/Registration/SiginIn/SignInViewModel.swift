//
//  LoginViewModel.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 02/11/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class SignInViewModel {
    //Properties
     var signInUserData:SignInData?{
        didSet{
            self.loginSuccess?()
        }
    }
    var error:Error?{
        didSet{self.errorMessageAlert?()}
    }
   public var errorMessage:String?
    
    var isLoading: Bool = false{
        didSet{self.loadingStatus?()}
    }
    var errorHit: Bool = false{
        didSet{self.errorHited?()}
    }

    
    //Closures for callback
    var loginSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    var errorHited:(() -> ())?

    
    
    //Login user
    func loginUser(params:Dictionary<String,Any>){
        isLoading = true
        APIClient.loginUser(params: params){ result in
            switch result {
            case .success(let responseData):
                self.isLoading = false
                    switch responseData.status_code!{
                    case 200..<300:
                            if responseData.data != nil
                            {
                                let jsonData = try! JSONEncoder().encode(responseData.data)
                                let decoder = JSONDecoder()
                                
                                do
                                {
                                    self.signInUserData = responseData.data
                                }
                                catch {
                                    print(error.localizedDescription)
                                }
                            }else
                            {
                                self.errorHit = true
                                self.isLoading = false
                                self.errorMessage = responseData.data?.all
                                self.errorMessageAlert?()
                            }
                    case 400..<500:
                        self.isLoading = false
                        self.errorHit = true
                        self.errorMessage = responseData.data?.all
                        self.errorMessageAlert?()
                    default:
                        print("Unknown Error")
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
