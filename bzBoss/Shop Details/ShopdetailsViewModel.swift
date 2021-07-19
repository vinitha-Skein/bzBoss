
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
    var shopdetailsData:ShopdetailsData?
    {
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
    var userConfigUpdated: Bool = false{
        didSet{self.userConfigstatus?()}
    }
    
    //Closures for callback
    var shopdetailsfetchedSuccess:(() -> ())?
    var loadingStatus:(() -> ())?
    var userConfigstatus:(() -> ())?

    var errorMessageAlert:(() -> ())?
    
    
    func shopDetail(params:Dictionary<String,Any>)
    {
        isLoading = true
        APIClient.shopDetails(params: params){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
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
    func userConfig(params:Dictionary<String,Any>)
    {
        isLoading = true
        self.userConfigUpdated = false
        APIClient.userConfig(params: params){ result in
            switch result
            {
            case .success(let responseData):
                self.isLoading = false
                    switch responseData.status_code ?? 501{
                    case 200..<300:
                        self.isLoading = false
                        self.userConfigUpdated = true
                    case 400..<500:
                        self.errorMessage = responseData.message
                        self.errorMessageAlert?()
                        self.isLoading = false
                    case 501:
                self.userConfigUpdated = false
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
