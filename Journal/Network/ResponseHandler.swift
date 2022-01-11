//
//  ResponseHandler.swift
//  Animo mApps
//
//  Created by A.Abdeen on 11/30/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import UIKit
import Moya
import ObjectMapper
import Reachability

class ResponseHandler {
    
    static func showResponseError(context: UIViewController, error: Error){
        let moyaError: MoyaError? = error as? MoyaError
        let moyaResponse : Response? = moyaError?.response
        
        do {
            let serverResponse = BaseResponse(JSON: try moyaResponse!.mapJSON() as! [String : Any])
            
            Utility.showAlertNew(message: serverResponse?.message ?? "Unknown error!", context: context)
        } catch {
            Utility.showAlertNew(message: "Unknown error!", context: context)
        }
    }
    
    static func handOnError(context: UIViewController, error: Error){
        
        let reachability = try! Reachability()
        if(reachability.connection == .unavailable){
            Utility.showAlertNew(message: "من فضلك تاكد من اتصالك بالانترنت", context: context)
        }
        
        else{
            
        }
        
        let moyaError: MoyaError? = error as? MoyaError
        let moyaResponse : Response? = moyaError?.response
        
        do {
            let serverResponse = BaseResponse(JSON: try moyaResponse!.mapJSON() as! [String : Any])
            
            Utility.showAlertNew(message: serverResponse?.message ?? "Unknown error!", context: context)
        } catch {
            Utility.showAlertNew(message: "Unknown error!", context: context)
        }
    }
    
}
