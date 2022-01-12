//
//  Global.swift
//  Animo mApps
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Foundation

class Global {
    
    static let sharedInstance = Global()
    
//    var baseUrl = "http://talibayati.com/api/v1/ar"
    var baseUrl = "http://192.168.1.8:8000/api/v1/"
    var token: String = ""
    var tokenType: String = ""
    var userData: User?
    var currentLanguage = "ar"
    var selectedProvinceId = 0
    
}
