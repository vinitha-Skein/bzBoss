//
//  HomeViewModel.swift
//  bzBoss
//
//  Created by Vinitha on 23/07/21.
//

import Foundation
import Alamofire
class HomeListViewModel {
    //Properties
    var HomeList:HomeListModel?
    {
        didSet{
            self.HomeListfetchedSuccess?()
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
    var HomeListfetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    
    var errorMessageAlert:(() -> ())?
    
    
    func getShopLists()
    {
        isLoading = true
        APIClient.getHomeListShops(){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
                switch responseData.status_code!{
                case 200..<300:
                    if responseData.data != nil{
                        
                        do
                                {
                                    self.HomeList = responseData
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
