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

class ProfileControllerViewModel {
    
    let provider = NetworkManager()
    
    func getCurrentUser(params: [String: Any]) -> Single<User> {
        
        return .create (subscribe: { observer in
            
          self.provider.getCurrentUser(params: params)
                .subscribe(onSuccess: { serverResponse in
                  
                  let serverModel = BaseResponseObject<User>(JSONString: serverResponse)  
                  
                  observer(.success((serverModel?.data)!))
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }

    
}
