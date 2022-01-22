//
//  RegisterViewModel.swift
//  TalibayatiIOS
//
//  Created by A.Abdeen on 1/2/21.
//

import Foundation

import RxSwift
import Moya
import SwiftyJSON
import SwiftKeychainWrapper

class SignUpViewModel {
    
    let provider = NetworkManager()
 
    func register(params: [String: Any]) -> Single<Any> {
        
        return .create (subscribe: { observer in
            
            self.provider.register(params: params)
                .subscribe(onSuccess: { response in
                    
                    do {
                        let json = JSON(response)
                        
                        let accessToken = json["data"]["access_token"].string
                                            
                        //Save access token to KeyChain Wrapper
                        let _: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                        
                        Global.sharedInstance.token = accessToken!
                        
                        observer(.success("Register Success..."))
                        
                    }
                    
                    
                }, onError: { error in
                    observer(.error(error))
                })
        })
        
    }
    
}
