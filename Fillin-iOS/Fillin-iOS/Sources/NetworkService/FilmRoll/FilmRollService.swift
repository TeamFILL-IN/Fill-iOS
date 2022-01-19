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
}

extension FilmRollService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .curation:
            return "/curation"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .curation:
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
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .curation:
            return Const.Header.tokenHeader
        }
    }
}
