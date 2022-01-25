//
//  UserJournal.swift
//  Journal
//
//  Created by Abdeen on 1/25/22.
//

import Foundation
import ObjectMapper

struct UserJournal : Mappable {
    
    var id : Int?
    var title : String?
    var text : String?

    init?(){
        
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        text <- map["text"]
        
    }

}
