//
//  Paging.swift
//  TalibayatiIOS
//
//  Created by A.Abdeen on 1/3/21.
//

import Foundation
import ObjectMapper

struct Paging<T: Mappable>: Mappable {
    
    var currentPage : Int = 0
    var data : [T]?
    var firstPageUrl: String?
    var from: Int?
    var lastPage: Int = 1
    var lastPageUrl: String?
    var nextPageUrl: String?
    var path: String?
    var perPage: Int?
    var prevPageUrl: String?
    var to: Int?
    var total: Int?
    
    init?() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["current_page"]
        data <- map["data"]
        firstPageUrl <- map["first_page_url"]
        from <- map["from"]
        lastPage <- map["last_page"]
        lastPageUrl <- map["last_page_url"]
        nextPageUrl <- map["next_page_url"]
        path <- map["path"]
        perPage <- map["per_page"]
        prevPageUrl <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }
    
}
