

import Foundation
struct DataService
{
    static let productionBaseURL = ""
    static let developmentBaseURL = "https://834f2b2716be.ngrok.io/api/"
    static let Terms_Condition = "https://theadeptz.com/bzBoss/public/term/condition"
    static let Privacy_policy = "https://theadeptz.com/bzBoss/public/privecy/policy"
    static let About_us = "https://theadeptz.com/bzBoss/public/about/us"
    static var authToken = ""
}
struct UserLoginData
{
    static var userId = 0
}
enum HTTPHeaderField: String
{
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String
{
    case json = "application/json"
}


struct Colors
{
    static var labelBlack = "#757575"
    static var buttonColor = "#7980dd"
    static var textfieldColor = "#F0F0F5"
    static var backgroundWhite = "#FBFBFB"
    static var lineColor = "#e9e9e9"
    static var statusgreen = "#4bc0a6"
}




import Security

class KeyChain {

    class func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    class func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        return self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
struct Constants
{
    static var selectedMenu = 0
    static var arrayXStringValues = [String]()
}
