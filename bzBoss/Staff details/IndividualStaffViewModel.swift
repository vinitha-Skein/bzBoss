//
//  IndividualStaffViewModel.swift
//  bzBoss
//
//  Created by Skeintech on 20/07/21.
//

import Foundation
import Alamofire
class IndividualstaffDataViewModel
{
    //Properties
    var individualstaffdetails:IndividualStaffDetails?
    {
       didSet{
           self.individualstafffetchedSuccess?()
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
    var individualstafffetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?

    var errorMessageAlert:(() -> ())?
    
    
    func individualstaffDatafetch(params:Dictionary<String,Any>)
    {
        isLoading = true
        APIClient.individualStaffDetailsData(params: params){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
                    switch responseData.status_code!{
                    case 200..<300:
                            if responseData.data != nil{
                                
                                do
                                {
                                    self.individualstaffdetails = responseData.data
                                }
                                catch
                                {
                                    print(error.localizedDescription)
                                }
                            }
                            else
                            {
                                self.errorMessage = responseData.message
                                self.errorMessageAlert?()
                            }
                    case 400..<500:
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
                        self.isLoading = false
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
    }
   
    
    
}

struct individualstaffDetailsLocal : Codable{
    var Name: String!
    var Image: String!
    var arrayXString: [String]!
    var arrayYString:[Double]!
}

