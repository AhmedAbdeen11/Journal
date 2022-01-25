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

class AddJournalViewModel {
    
    let provider = NetworkManager()
    
    func addUserJournal(params: [String: Any]) -> Completable {
        
        return .create (subscribe: { observer in
            
          self.provider.addUserJournal(params: params)
                .subscribe(onCompleted: {
                  
                    observer(.completed)
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }
    
}
