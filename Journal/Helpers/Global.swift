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
    
//    var baseUrl = "http://journal.solidbundle.com/api/v1"
    var baseUrl = "http://192.168.1.2:8000/api/v1/"
    var token: String = ""
    var tokenType: String = ""
    var userData: User?
    var selectedProvinceId = 0
    
}
