//
//  StudioMapService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum StudioMapService {
  case totalStudio
  case infoStudio(studioID: Int)
  case photoStudio(studioID: Int)
}

extension StudioMapService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .totalStudio:
          return "/studio"
        case .infoStudio(let studioID):
          return "/studio/detail/\(studioID)"
        case .photoStudio(let studioID):
          return "/photo/studio/\(studioID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .totalStudio:
          return .get
        case .infoStudio:
          return .get
        case .photoStudio:
          return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .totalStudio:
          return .requestPlain
        case .infoStudio:
          return .requestPlain
        case .photoStudio:
          return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .totalStudio:
          return Const.Header.tokenHeader
        case .infoStudio:
          return Const.Header.tokenHeader
        case .photoStudio:
          return Const.Header.tokenHeader
        }
    }
}
