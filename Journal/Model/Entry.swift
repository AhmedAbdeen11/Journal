import Foundation
import ObjectMapper

struct Entry : Mappable {
    
    var id : Int?
    var date : String?
    var month: String?
    var dayMonth: String?
    var dayMonthYear: String?
    var time: String?
    var isFavorite: Bool?
    var entrableId: Int?
    var entrableType: String?
    var topic: Topic?
    var journal: UserJournal?

    init?() {

    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        date <- map["date"]
        month <- map["month"]
        dayMonth <- map["day_month"]
        dayMonthYear <- map["day_month_year"]
        time <- map["time"]
        isFavorite <- map["is_favorite"]
        entrableId <- map["entrable_id"]
        entrableType <- map["entrable_type"]
        topic <- map["topic"]
        journal <- map["journal"]
        
    }

}
