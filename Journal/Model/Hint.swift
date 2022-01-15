//
//  Category.swift
//  TalibayatiIOS
//
//  Created by Abdeen on 2/21/21.
//

import Foundation
import ObjectMapper

struct Hint : Mappable {
    
    var id : Int?
    var title : String?
    var type : String?

    init?(){
        
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        type <- map["type"]
        
    }

}
