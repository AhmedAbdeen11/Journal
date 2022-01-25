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

class AccountInfoViewModel {
    
    let provider = NetworkManager()
    
    func getAvatars() -> Single<[Avatar]> {
        
        return .create (subscribe: { observer in
            
          self.provider.getAvatars()
                .subscribe(onSuccess: { serverResponse in
                  
                  let serverModel = BaseResponseArray<Avatar>(JSONString: serverResponse)
                  
                  observer(.success((serverModel?.data)!))
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }
    
    
    func updateProfile(params: [String: Any]) -> Single<User> {
        
        return .create (subscribe: { observer in
            
          self.provider.updateProfile(params: params)
                .subscribe(onSuccess: { serverResponse in
                  
                  let serverModel = BaseResponseObject<User>(JSONString: serverResponse)
                  
                  observer(.success((serverModel?.data)!))
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }

    
}
