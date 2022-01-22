import Foundation
import ObjectMapper

struct BaseResponse: Mappable {
    
    var code : Int?
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        
    }
    
}

struct BaseResponseObject<T: Mappable>: Mappable {
    
    var code : Int?
    var message : String?
    var data : T?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

struct BaseResponseArray<T: Mappable>: Mappable {
    
    var code : Int?
    var message : String?
    var data : [T]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

struct BaseErrorResponseObject<T: Mappable>: Mappable {
    
    var code : Int?
    var message : String?
    var errors : T?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]
        errors <- map["errors"]
    }
    
}
