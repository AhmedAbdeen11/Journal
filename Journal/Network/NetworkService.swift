//
//  Kelkou.swift
//  Kelkou TV
//
//  Created by Mac on 8/1/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import Moya

public enum NetworkService {
    
    // MARK: - User
    
    case register(params: [String: Any])
    
    case createProfile(params: [String: Any])
    
    case login(params: [String: Any])
    
    case loginProvider(params: [String: Any])
    
    case provinces
    
    case myData(params: [String: Any])
    
    case forgotPassword(params: [String: Any])
    
    case logout
    
    // MARK: - Journal
    
    case getJournals
    
    // MARK: - Product
    
    case getCategoryProducts(categoryId: Int, page: Int)
    
    case getCategoryProductsNoAuth(categoryId: Int, page: Int, params: [String: Any])
    
    case searchProducts(params: [String: Any])
    
    case addProduct(images: [UIImage], params: [String: Any])
    
    case getProduct(productId: Int)
    
    case deleteProduct(productId: Int)
    
    // MARK: - Favorite
    
    case addFavorite(params: [String: Any])
    
    case deleteFavorite(productId: Int)
    
    case getFavoriteProducts(page: Int)
    
    // MARK: - Review
    
    case addReview(params: [String: Any])
    
    // MARK: - Chat
    
    case createChat(params: [String: Any])
    
    case markChatAsRead(chatId: Int)
    
    case myChats
    
    case getChat(userId: Int)
    
    case chatMessages(chatId: Int, page: Int)
    
    // MARK: - Messages
    
    case sendMessage(image: UIImage?, params: [String: Any])
    
}

extension NetworkService: TargetType {
    
    public var baseURL: URL { return URL(string: Global.sharedInstance.baseUrl)! }
    
    public var headers: [String: String]? {
        switch self {
            
        case .login, .loginProvider, .register, .provinces, .getCategoryProductsNoAuth:
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
            
        default: return [
                "Authorization": "Bearer \(Global.sharedInstance.token)",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept": "application/json"
            ]
            
    }

    }
    
    public var path: String {
        switch self {
        
            // MARK: - User
        
            case .register:
                return "register"
                
            case .createProfile:
                return "create-profile"
            
            case .login:
                return "login"
                
            case .loginProvider:
                return "login-provider"
                
            case .forgotPassword:
                return "forgot-password"
                
            case .provinces:
                return "province"
                
            case .myData:
                return "me"
                
            case .logout:
                return "logout"
            
            // MARK: - Journal
        
            case .getJournals:
                return "journal"
        
            // MARK: - Product
                
            case .getCategoryProducts(let categoryId, _):
                return "category/\(categoryId)/products"
                
            case .getCategoryProductsNoAuth(let categoryId, _, _):
                return "category/\(categoryId)/products/no-auth"
            
            case .searchProducts:
                return "product/search"
                
            case .getProduct(let productId):
                return "product/\(productId)"
                
            case .addProduct:
                return "product"
                
            case .deleteProduct(let productId):
                return "product/\(productId)"
                
            // MARK: - Favorite
                
            case .addFavorite:
                return "favorite"
                
            case .deleteFavorite(let productId):
                return "favorite/\(productId)"
                
            case .getFavoriteProducts:
                return "favorite"
                
            // MARK: - Review
        
            case .addReview:
                return "review"
        
            // MARK: - Chat
        
            case .createChat:
                return "chat"
            
            case .markChatAsRead(let chatId):
                return "chat/\(chatId)/read"
            
            case .myChats:
                return "chat"
            
            case .getChat(let userId):
                return "chat/\(userId)"
            
        case .chatMessages(let chatId, _):
                return "chat/\(chatId)/messages"
                
            // MARK: - Message
            
            case .sendMessage:
                return "message"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        
        case .register, .createProfile, .login, .loginProvider, .myData, .createChat, .sendMessage, .addProduct, .addReview, .addFavorite, .forgotPassword, .searchProducts, .getCategoryProductsNoAuth:
                return .post
            
            case .deleteFavorite, .deleteProduct:
                return .delete
                
            default:
                return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {

        switch self {
        
        
        case .getCategoryProducts(let categoryId, let page): do {
         
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
            
            }
        
        case .getCategoryProductsNoAuth(let categoryId, let page, let params): do {
         
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            }
        
        case .getFavoriteProducts(let page):
            do {
         
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
            
            }
        
        // MARK: - Form + one image
        
        case let .sendMessage(image: image, params: params):
            
            if image == nil {
                return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            }
            
            var formData = [Moya.MultipartFormData]()
            
            let imageData = image!.jpegData(compressionQuality: 1)
            
            formData.append(Moya.MultipartFormData(provider: .data(imageData!), name: "image", fileName: "swift_file.jpeg", mimeType: "image/jpeg"))
            
            let _ = params.map{formData.append(Moya.MultipartFormData(provider: .data("\($0.value)".data(using: .utf8)!), name: "\($0.key)"))}
            return .uploadMultipart(formData)
            
        // MARK: - Form
            
        case let .login(params: params),
             let .loginProvider(params: params),
             let .register(params: params),
             let .createProfile(params: params),
             let .forgotPassword(params: params),
             let .myData(params: params),
             let .searchProducts(params: params),
             let .createChat(params: params),
             let .addReview(params: params),
             let .addFavorite(params: params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        // MARK: - Form + list of images
        
        case let .addProduct(images: images, params: params):
            
            if images.isEmpty {
                return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            }
            
            var formData = [Moya.MultipartFormData]()
            
            for (index, image) in images.enumerated() {
                let imageData = image.jpegData(compressionQuality: 1)
                
                formData.append(Moya.MultipartFormData(provider: .data(imageData!), name: "images[\(index)]", fileName: "swift_file.jpeg", mimeType: "image/jpeg"))
                
                let _ = params.map{formData.append(Moya.MultipartFormData(provider: .data("\($0.value)".data(using: .utf8)!), name: "\($0.key)"))}
            }

            return .uploadMultipart(formData)
        
        default :
            return .requestPlain
            
        }
    }
}
