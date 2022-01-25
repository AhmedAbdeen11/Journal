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

class ChangePasswordViewModel {
    
    let provider = NetworkManager()
    
    func changePassword(params: [String: Any]) -> Completable {
        
        return .create (subscribe: { observer in
            
          self.provider.changePassword(params: params)
            .subscribe(onCompleted: {
                    
                  observer(.completed)
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }

    
}
