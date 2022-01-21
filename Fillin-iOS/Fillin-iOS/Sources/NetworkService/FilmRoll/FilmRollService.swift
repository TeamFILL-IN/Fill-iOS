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
    case filmIdPhotos(filmId: Int)
}

extension FilmRollService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .curation:
            return "/curation"
        case .filmStylePhotos(let styleId):
            return "/photo/style/\(styleId)"
        case .filmIdPhotos(let filmId):
            return "/photo/film/\(filmId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .curation, .filmStylePhotos, .filmIdPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .curation, .filmStylePhotos, .filmIdPhotos:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .curation, .filmStylePhotos, .filmIdPhotos:
            return Const.Header.tokenHeader
        }
    }
}
