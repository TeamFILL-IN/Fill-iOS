//
//  FlimSelectAPI.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import Foundation
import Moya

public class FlimSelectAPI {

    static let shared = FlimSelectAPI()
    var flimSelectAPIProvider = MoyaProvider<FilmSelectService>(plugins: [MoyaLoggerPlugin()])

    public init() { }
    
    func listOfFilms(styleId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        flimSelectAPIProvider.request(.listOfFilms(styleId: styleId)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgelistOfFilmsStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgelistOfFilmsStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<FilmResponse>.self, from: data)
        else {
            return .pathErr
        }

        switch statusCode {
        case 200:
            return .success(decodedData.data ?? "None-Data")
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<String>.self, from: data)
        else { return .pathErr }
        
        switch statusCode {
        case 200:
            return .success(decodedData.message)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
