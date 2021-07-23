//
//  premiseDataViewModel.swift
//  bzBoss
//
//  Created by Skeintech on 16/07/21.


import Foundation
import Alamofire
class premiseDataViewModel
{
    //Properties
    var premiseData:dataforPremise?
    {
       didSet{
           self.premiseDatafetchedSuccess?()
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
    var premiseDatafetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?

    var errorMessageAlert:(() -> ())?
    
    
    func premiseDatafetch(params:Dictionary<String,Any>)
    {
        isLoading = true
        APIClient.premiseGraphData(params: params){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
                    switch responseData.status_code ?? 400{
                    case 200..<300:
                            if responseData.data != nil{
                                
                                do
                                {
                                    self.premiseData = responseData.data
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
                        if responseData.message != nil
                        {
                        self.errorMessage = responseData.message
                        }
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
