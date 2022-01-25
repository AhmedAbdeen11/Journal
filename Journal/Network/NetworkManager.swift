//
//  NetworkAdapter.swift
//  Kelkou TV
//
//  Created by Mac on 8/1/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import RxSwift
import Moya

class NetworkManager: NSObject {
        
    let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    // MARK: - User
    
    func login(params: [String: Any]) -> Single<Any> {
        return provider.rx
            .request(.login(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
    }
    
    func register(params: [String: Any]) -> Single<Any> {
        return provider.rx
            .request(.register(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
    }
    
    func forgotPassword(params: [String: Any]) -> Completable
    {
        return provider.rx
            .request(.forgotPassword(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func getCurrentUser(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.myData(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func changePassword(params: [String: Any]) -> Completable {
        return provider.rx
            .request(.changePassword(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func updateProfile(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.updateProfile(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func logout() -> Completable {
        return provider.rx
            .request(.logout)
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    // MARK: - Journal
    
    func getJournals() -> Single<String> {
        return provider.rx
            .request(.getJournals)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Answer
    
    func saveAnswers(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.saveAnswers(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Entry
    
    func myEntries() -> Single<String> {
        return provider.rx
            .request(.myEntries)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func favorite(params: [String: Any]) -> Completable {
        return provider.rx
            .request(.favorite(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    // MARK: - Avatar
    
    func getAvatars() -> Single<String> {
        return provider.rx
            .request(.getAvatars)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
}
