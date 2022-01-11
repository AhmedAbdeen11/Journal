import Foundation
import ObjectMapper

struct User : Mappable {
    
    var id : Int?
    var name : String?
    var loginType: String! = "email"
    var hasProfile: Bool! = false
    var isBlocked: Bool! = false
    var email : String?
    var phone : String?
    var image : String?
    var type : String?
    var typeFormatted : String?
    var province : String?

    init?() {

    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        loginType <- map["login_type"]
        hasProfile <- map["has_profile"]
        isBlocked <- map["is_blocked"]
        email <- map["email"]
        phone <- map["phone"]
        image <- map["image"]
        type <- map["type"]
        typeFormatted <- map["type_formatted"]
        province <- map["province"]
        
    }

}
