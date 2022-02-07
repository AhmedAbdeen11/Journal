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

class EntriesViewModel {
    
    let provider = NetworkManager()
    let context: UIViewController!
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func myEntries() -> Single<[Entry]> {
          
          return .create (subscribe: { observer in
              
            self.provider.myEntries()
                  .subscribe(onSuccess: { serverResponse in
                    
                    let serverModel = BaseResponseArray<Entry>(JSONString: serverResponse)
                                    
                    
                    observer(.success((serverModel?.data)!))
                      
                  }, onError: { error in
                      
                      ResponseHandler.showResponseError(context: self.context, error: error)
                      
                  })
          })
          
      }
    
    func favorite(params: [String: Any]) -> Completable {
        
        return .create (subscribe: { observer in
            
            self.provider.favorite(params: params)
                .subscribe(onCompleted: {
                    observer(.completed)
                }, onError: { error in
                    Utility.hideProgressDialog(view: self.context.view)
                    ResponseHandler.showResponseError(context: self.context, error: error)
                })
        })
        
    }
 
    func deleteEntry(params: [String: Any]) -> Completable {
        
        return .create (subscribe: { observer in
            
          self.provider.deleteEntry(params: params)
                .subscribe(onCompleted: {
                  
                    observer(.completed)
                    
                }, onError: { error in
                    
                    observer(.error(error))
                    
                })
        })
        
    }
    
}
