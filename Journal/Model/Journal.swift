//
//  Category.swift
//  TalibayatiIOS
//
//  Created by Abdeen on 2/21/21.
//

import Foundation
import ObjectMapper

struct Journal : Mappable {
    
    var id : Int?
    var title : String?
    var subtitle : String?
    var image : String?
    var topics : [Topic]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        image <- map["image"]
        topics <- map["topics"]
        
    }

}
