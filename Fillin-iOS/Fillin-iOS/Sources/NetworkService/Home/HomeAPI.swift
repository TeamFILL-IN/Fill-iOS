//
//  HomeAPI.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

public class HomeAPI {

    static let shared = HomeAPI()
    var homeProvider = MoyaProvider<HomeService>(plugins: [MoyaLoggerPlugin()])

    public init() { }
    
    func latestPhotos(completion: @escaping (NetworkResult<Any>) -> Void) {
        homeProvider.request(.latestPhotos) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeLatestPhotosStatus(by: statusCode, data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeLatestPhotosStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PhotosResponse>.self, from: data)
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
