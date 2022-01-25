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
    
    case login(params: [String: Any])
    
    case myData(params: [String: Any])
    
    case forgotPassword(params: [String: Any])
    
    case updateProfile(params: [String: Any])
    
    case changePassword(params: [String: Any])
    
    case logout
    
    case deleteAccount
    
    // MARK: - Journal
    
    case getJournals
    
    // MARK: - Answer
    
    case saveAnswers(params: [String: Any])
    
    // MARK: - Entry
    
    case myEntries
    
    case favorite(params: [String: Any])
    
    case deleteEntry(params: [String: Any])
    
    // MARK: - Avatar
    
    case getAvatars
    
    // MARK: - User Journal
    
    case addUserJournal(params: [String: Any])
    
}

extension NetworkService: TargetType {
    
    public var baseURL: URL { return URL(string: Global.sharedInstance.baseUrl)! }
    
    public var headers: [String: String]? {
        switch self {
            
        case .login, .register:
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
            
        default: return [
                "Authorization": "Bearer \(Global.sharedInstance.token)",
                "Content-Type": "application/x-www-form-urlencoded",
                "Accept": "application/json",
                "date": Date().string(format: "yyyy-MM-dd")
            ]
            
    }

    }
    
    public var path: String {
        switch self {
        
            // MARK: - User
        
            case .register:
                return "register"
            
            case .login:
                return "login"
             
            case .forgotPassword:
                return "forgot-password"
             
            case .myData:
                return "me"
            
            case .changePassword:
                return "change-password"
                
            case .updateProfile:
                return "update-profile"
                
            case .logout:
                return "logout"
                
            case .deleteAccount:
                return "delete-account"
            
            // MARK: - Journal
        
            case .getJournals:
                return "journal"
                
            // MARK: - Answer
        
            case .saveAnswers:
                return "answer/save"
                
            // MARK: - Entry
        
            case .myEntries:
                return "entry"
                
            case .favorite:
                return "entry/favorite"
                
            case .deleteEntry:
                return "entry/delete"
        
            // MARK: - Avatar
        
            case .getAvatars:
                return "avatar"
                
            // MARK: - User Journal
            
            case .addUserJournal:
                return "user-journal"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        
        case .register, .login, .myData, .forgotPassword,
             .changePassword, .updateProfile, .saveAnswers
             , .favorite, .addUserJournal, .deleteEntry:
                return .post
                
            default:
                return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {

        switch self {
        
        
        
        // MARK: - Form + one image
        
      
        // MARK: - Form
            
        case let .login(params: params),
             let .register(params: params),
             let .forgotPassword(params: params),
             let .changePassword(params: params),
             let .updateProfile(params: params),
             let .myData(params: params),
             let .saveAnswers(params: params),
             let .favorite(params: params),
             let .addUserJournal(params: params),
             let .deleteEntry(params: params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        // MARK: - Form + list of images
        
        default :
            return .requestPlain
            
        }
    }
}
