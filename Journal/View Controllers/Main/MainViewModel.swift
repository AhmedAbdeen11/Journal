//
//  SideMenuViewModel.swift
//  TalibayatiIOS
//
//  Created by A.Abdeen on 1/3/21.
//

import RxSwift
import Moya
import SwiftyJSON
import ObjectMapper

class MainViewModel {
    
    let provider = NetworkManager()
    let context: UIViewController!
    
    init(context: UIViewController) {
        self.context = context
    }
    
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
