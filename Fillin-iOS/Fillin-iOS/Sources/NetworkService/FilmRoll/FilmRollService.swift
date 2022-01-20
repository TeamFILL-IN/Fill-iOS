//
//  FilmRollService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum FilmRollService {
    case curation
    case filmStylePhotos(styleId: Int)
}

extension FilmRollService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .curation:
            return "/curation"
        case .filmStylePhotos:
            return "/photo/style"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .curation, .filmStylePhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .curation:
            return .requestPlain
        case .filmStylePhotos(let styleId):
            return .requestParameters(parameters: ["styleId": styleId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .curation, .filmStylePhotos:
            return Const.Header.tokenHeader
        }
    }
}
