//
//  ViewJournalViewModel.swift
//  Journal
//
//  Created by Abdeen on 1/25/22.
//

import Foundation
import RxSwift

class ViewJournalViewModel {
    
    let provider = NetworkManager()
    
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
