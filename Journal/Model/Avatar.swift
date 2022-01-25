import Foundation
import ObjectMapper

struct Avatar : Mappable {
    
    var id : Int?
    var title : String?
    var path : String?
    var fullPath : String?
    var isSelected : Bool?

    init?() {

    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        path <- map["path"]
        fullPath <- map["full_path"]
        isSelected <- map["is_selected"]
        
    }

}
