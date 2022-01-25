import Foundation
import ObjectMapper

struct ServerError : Mappable {
    
    var name : [String]?
    var email : [String]?
    var password: [String]?
    var currentPassword: [String]?
    var newPassword: [String]?

    init?() {

    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        name <- map["name"]
        email <- map["email"]
        password <- map["password"]
        currentPassword <- map["current_password"]
        newPassword <- map["new_password"]
        
    }

}
