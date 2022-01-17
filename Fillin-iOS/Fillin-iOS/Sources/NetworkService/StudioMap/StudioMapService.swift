//
//  StudioMapService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum StudioMapService {
    
}

extension StudioMapService: TargetType {

    var baseURL: URL {
        return URL(string: Const.URL.baseURL)!
    }
    
    var path: String {
        switch self {

        }
    }
    
    var method: Moya.Method {
        switch self {

        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {

        }
    }
    
    var headers: [String: String]? {
        switch self {

        }
    }
}
