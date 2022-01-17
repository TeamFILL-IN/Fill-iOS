//
//  MyPageService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum MyPageService {
  case userPhotos(userID : Int)
}

extension MyPageService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .userPhotos(let userID) :
          return "/photo/user/\(userID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userPhotos :
          return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .userPhotos :
          return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .userPhotos :
          return Const.Header.tokenHeader
        }
    }
}
