//
//  Category.swift
//  TalibayatiIOS
//
//  Created by Abdeen on 2/21/21.
//

import Foundation
import ObjectMapper

struct Item : Mappable {
    
    var id : Int?
    var question : String?
    var hint : String?
    var answer: Answer?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        question <- map["question"]
        hint <- map["hint"]
        answer <- map["answer"]
        
        if answer == nil {
            answer = Answer()
        }
    }

}
