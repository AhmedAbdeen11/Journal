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
    
    func loginProvider(params: [String: Any]) -> Single<Any> {
        return provider.rx
            .request(.loginProvider(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapJSON()
    }
    
    func register(params: [String: Any]) -> Completable {
        return provider.rx
            .request(.register(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func createProfile(params: [String: Any]) -> Completable {
        return provider.rx
            .request(.createProfile(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func forgotPassword(params: [String: Any]) -> Completable
    {
        return provider.rx
            .request(.forgotPassword(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func getProvinces() -> Single<String> {
        return provider.rx
            .request(.provinces)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getCurrentUser(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.myData(params: params))
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
    
    // MARK: - Product
    
    func getCategories() -> Single<String> {
        return provider.rx
            .request(.getCategories)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Product
    
    func getCategoryProducts(categoryId: Int, page: Int) -> Single<String> {
        return provider.rx
            .request(.getCategoryProducts(categoryId: categoryId, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getCategoryProductsNoAuth(categoryId: Int, page: Int, params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.getCategoryProductsNoAuth(categoryId: categoryId, page: page, params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func searchProducts(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.searchProducts(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func addProduct(images: [UIImage], params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.addProduct(images: images, params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getProduct(productId: Int) -> Single<String> {
        return provider.rx
            .request(.getProduct(productId: productId))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func deleteProduct(productId: Int) -> Single<String> {
        return provider.rx
            .request(.deleteProduct(productId: productId))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Favorite
    
    func addFavorite(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.addFavorite(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func deleteFavorite(productId: Int) -> Single<String> {
        return provider.rx
            .request(.deleteFavorite(productId: productId))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getFavoriteProducts(page: Int) -> Single<String> {
        return provider.rx
            .request(.getFavoriteProducts(page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Review
    
    func addReview(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.addReview(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Chat
    
    func createChat(params: [String: Any]) -> Single<String> {
        return provider.rx
            .request(.createChat(params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getMyChats() -> Single<String> {
        return provider.rx
            .request(.myChats)
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func getChatMessages(chatId: Int, page: Int) -> Single<String> {
        return provider.rx
            .request(.chatMessages(chatId: chatId, page: page))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    func markChatAsRead(chatId: Int) -> Completable {
        return provider.rx
            .request(.markChatAsRead(chatId: chatId))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
    func getChat(userId: Int) -> Single<String> {
        return provider.rx
            .request(.getChat(userId: userId))
            .filterSuccessfulStatusAndRedirectCodes()
            .mapString()
    }
    
    // MARK: - Message

    func sendMessage(image: UIImage?, params: [String: Any]) -> Completable {
        return provider.rx
            .request(.sendMessage(image: image, params: params))
            .filterSuccessfulStatusAndRedirectCodes()
            .asObservable()
            .ignoreElements()
    }
    
}
