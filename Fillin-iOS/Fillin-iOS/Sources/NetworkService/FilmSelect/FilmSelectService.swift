//
//  FilmSelectService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import Foundation
import Moya

enum FilmSelectService {
    case listOfFilms(styleId: Int)
}

extension FilmSelectService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {
        case .listOfFilms(let styleId):
            return "/film/\(styleId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listOfFilms:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .listOfFilms:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .listOfFilms:
            return Const.Header.tokenHeader
        }
    }
}
