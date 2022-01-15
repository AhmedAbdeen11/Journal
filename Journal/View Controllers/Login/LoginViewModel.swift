//
//  LoginViewModel.swift
//  Animo mApps
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import RxSwift
import Moya
import SwiftyJSON
import SwiftKeychainWrapper

class LoginViewModel {
    
    let provider = NetworkManager()
    let context: UIViewController!
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func login(params: [String: Any]) -> Single<Any> {
        
        return .create (subscribe: { observer in
            
            self.provider.login(params: params)
                .subscribe(onSuccess: { response in
                  
                    do {
                        let json = JSON(response)
                        
                        let accessToken = json["data"]["access_token"].string
                                            
                        //Save access token to KeyChain Wrapper
                        let _: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                        
                        Global.sharedInstance.token = accessToken!
                        
                        observer(.success("Login Success..."))
                        
                    }
                    
                    
                }, onError: { error in
                    Utility.hideProgressDialog(view: self.context.view)
                    ResponseHandler.showResponseError(context: self.context, error: error)
                })
        })
        
    }
    
}
