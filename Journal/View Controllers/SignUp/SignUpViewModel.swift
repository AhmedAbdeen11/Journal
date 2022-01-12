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

class SignUpViewModel {
    
    let provider = NetworkManager()
    let context: UIViewController!
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func register(params: [String: Any]) -> Completable {
        
        return .create (subscribe: { observer in
            
            self.provider.register(params: params)
                .subscribe(onCompleted: {
                    observer(.completed)
                    
                })
        })
        
    }
    
}
