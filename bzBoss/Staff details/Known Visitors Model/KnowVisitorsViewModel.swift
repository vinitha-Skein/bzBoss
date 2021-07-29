//
//  KnowVisitorsViewModel.swift
//  bzBoss
//
//  Created by Vinitha on 27/07/21.
//

import Foundation
import Alamofire
class KnownVisitorsViewModel
{
    //Properties
    var KnownVisitorsData:[KnownVisitorsOnDate]?
    {
        didSet{
            self.KnownVisitorsDatafetchedSuccess?()
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
    var KnownVisitorsDatafetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    
    var errorMessageAlert:(() -> ())?
    
    
    func premiseDatafetch(params:Dictionary<String,Any>)
    {
        isLoading = true
        APIClient.KnownVisitorsDataOnDate(params: params){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
                switch responseData.status_code!{
                case 200..<300:
                    if responseData.Responsedata != nil{
                        
                        do
                                {
                                    self.KnownVisitorsData = responseData.Responsedata
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
