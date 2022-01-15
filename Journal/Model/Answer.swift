//
//  Category.swift
//  TalibayatiIOS
//
//  Created by Abdeen on 2/21/21.
//

import Foundation
import ObjectMapper

struct Answer : Mappable {
    
    var id : Int = 0
    var answer : String?
    var date : String = ""

    init?(){
        
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        answer <- map["answer"]
        date <- map["date"]
        
    }

}
