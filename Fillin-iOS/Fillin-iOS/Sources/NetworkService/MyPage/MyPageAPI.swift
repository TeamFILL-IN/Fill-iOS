//
//  MyPageAPI.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

public class MyPageAPI {
  
  static let shared = MyPageAPI()
  var mypageProvider = MoyaProvider<MyPageService>()
  
  public init() { }
  
  func userPhotos(userID: Int, completion: @escaping(NetworkResult<Any>) -> Void) {
    mypageProvider.request(.userPhotos(userID: userID)) { (result) in
      switch result {
      case .success(let response):
          let statusCode = response.statusCode
          let data = response.data
          
          let networkResult = self.judgeUserPhotosStatus(by: statusCode, data)
          completion(networkResult)
          
      case .failure(let err):
          print(err)
      }
    }
  }
  private func judgeUserPhotosStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {

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
