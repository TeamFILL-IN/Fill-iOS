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
}

extension StudioMapService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .totalStudio:
          return "/studio"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .totalStudio:
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
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .totalStudio:
          return Const.Header.tokenHeader

        }
    }
}
