//
//  UserService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum UserService {
    case login(loginRequest: LoginRequest)
}

extension UserService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let loginRequest):
            return .requestJSONEncodable(loginRequest)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .login:
          return Const.Header.loginHeader
        }
    }
}
