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
    
    func logout() -> Completable {
        
        return .create (subscribe: { observer in
            
            self.provider.logout()
                .subscribe(onCompleted: {
                    
                    observer(.completed)
                    
                }, onError: { error in
                    
                    ResponseHandler.showResponseError(context: self.context, error: error)
                    
                })
        })
        
    }

        
}
