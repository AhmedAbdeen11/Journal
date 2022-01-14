import RxSwift
import Moya
import SwiftyJSON

class JournalPageViewModel {
    
    let provider = NetworkManager()
    let context: UIViewController!
    
    init(context: UIViewController) {
        self.context = context
    }
    
    func getJournals() -> Single<[Journal]> {
          
          return .create (subscribe: { observer in
              
            self.provider.getJournals()
                  .subscribe(onSuccess: { serverResponse in
                    
                    let serverModel = BaseResponseArray<Journal>(JSONString: serverResponse)
                                    
                    
                    observer(.success((serverModel?.data)!))
    
                      
                  }, onError: { error in
                      
                      ResponseHandler.showResponseError(context: self.context, error: error)
                      
                  })
          })
          
      }
    
}
