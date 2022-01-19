//
//  AddPhotoAPI.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

public class AddPhotoAPI {
  
  static let shared = AddPhotoAPI()
  var addPhotoProvider = MoyaProvider<AddPhotoService>()
  
  public init() { }
  
  func addPhotos(studioId: Int,
                 filmId: Int,
                 img: UIImage,
                 completion: @escaping (NetworkResult<Any>) -> Void) {
    addPhotoProvider.request(.addPhotos(studioId: studioId, filmId: filmId, img: img)) { (result) in
      switch result {
      case .success(let response):
        let statusCode = response.statusCode
        let data = response.data
        print(data)
        let networkResult = self.judgeStatus(by: statusCode, data)
        completion(networkResult)
        
      case .failure(let err) :
        print(err)
      }
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
