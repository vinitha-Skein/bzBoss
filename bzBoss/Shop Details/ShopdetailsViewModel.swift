
import Foundation
import Alamofire
class ShopdetailsViewModel
{
    //Properties
     var getcurrentStatus:Getcurrentstatus?{
        didSet{
            self.shopdetailsfetchedSuccess?()
        }
    }
    var shopdetailsData:ShopdetailsData?{
       didSet{
           self.shopdetailsfetchedSuccess?()
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
    var shopdetailsfetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var errorMessageAlert:(() -> ())?
    
    
    //Login user
    func shopDetail(params:Dictionary<String,Any>)
    {
        isLoading = true
        APIClient.shopDetails(params: params){ result in
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
                                    self.shopdetailsData = responseData.data
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
        
}
}
