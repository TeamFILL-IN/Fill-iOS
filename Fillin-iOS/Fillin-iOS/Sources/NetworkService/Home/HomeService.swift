//
//  HomeService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum HomeService {
    case latestPhotos
}

extension HomeService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .latestPhotos:
            return "/photo/latest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .latestPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .latestPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .latestPhotos:
            return Const.Header.tokenHeader
        }
    }
}
