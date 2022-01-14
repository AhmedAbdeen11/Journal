//
//  Category.swift
//  TalibayatiIOS
//
//  Created by Abdeen on 2/21/21.
//

import Foundation
import ObjectMapper

struct Topic : Mappable {
    
    var id : Int?
    var title : String?
    var subtitle : String?
    var quote: String?
    var quotee: String?
    var description: String?
    var image : String?
    var beforeHints : [Hint]?
    var afterHints : [Hint]?
    var questions : [Question]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        quote <- map["quote"]
        quotee <- map["quotee"]
        description <- map["description"]
        image <- map["image"]
        beforeHints <- map["before_hints"]
        afterHints <- map["after_hints"]
        questions <- map["questions"]
        
    }

}
