import Foundation
import ObjectMapper

struct User : Mappable {
    
    var id : Int?
    var name : String?
    var loginType: String! = "email"
    var email : String?
    var avatar : String?
    var dayStreak : Int?
    var totalDays : Int?
    var totalEntries : Int?

    init?() {

    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        name <- map["name"]
        loginType <- map["login_type"]
        email <- map["email"]
        avatar <- map["avatar"]
        dayStreak <- map["day_streak"]
        totalDays <- map["total_days"]
        totalEntries <- map["total_entries"]
        
    }

}
