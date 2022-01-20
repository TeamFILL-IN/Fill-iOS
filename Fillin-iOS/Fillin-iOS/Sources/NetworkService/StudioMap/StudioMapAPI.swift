//
//  StudioMapAPI.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

public class StudioMapAPI {
  
  static let shared = StudioMapAPI()
  var studioMapProvider = MoyaProvider<StudioMapService>()
  
  public init() { }
  
  // 1. 전체 스튜디오 조회
  func totalStudio(completion: @escaping (NetworkResult<Any>) -> Void) {
    studioMapProvider.request(.totalStudio) { (result) in
      switch result {
      case .success(let response):
        let statusCode = response.statusCode
        let data = response.data
        
        let networkResult = self.judgeTotalStudioStatus(by: statusCode, data)
        completion(networkResult)
        
      case .failure(let err):
        print(err)
      }
    }
  }
  
  private func judgeTotalStudioStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(GenericResponse<StudioResponse>.self, from: data)
    else { return .pathErr }
    
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
  
  // 2. 특정 스튜디오 상세 정보 조회
  func infoStudio(studioID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    studioMapProvider.request(.infoStudio(studioID: studioID)) { (result) in
      switch result {
      case .success(let response):
        let statusCode = response.statusCode
        let data = response.data
        
        let networkResult = self.judgeinfoStudioStatus(by: statusCode, data)
        completion(networkResult)
        
      case .failure(let err):
        print(err)
      }
    }
  }
  
  private func judgeinfoStudioStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(GenericResponse<StudioInfoResponse>.self, from: data)
    else { return .pathErr }
    
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
  
  // 3. 특정 스튜디오 사진 조회
  func photoStudio(studioID: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
    studioMapProvider.request(.photoStudio(studioID: studioID)) { (result) in
      switch result {
      case .success(let response):
        let statusCode = response.statusCode
        let data = response.data
        
        let networkResult = self.judgephotoStudioStatus(by: statusCode, data)
        completion(networkResult)
        
      case .failure(let err):
        print(err)
      }
    }
  }
  
  private func judgephotoStudioStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(GenericResponse<PhotosResponse>.self, from: data)
    else { return .pathErr }
    
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
  
  // 4. 스튜디오 검색
  func searchStudio(keyword: String, completion: @escaping (NetworkResult<Any>) -> Void) {
    studioMapProvider.request(.searchStudio(keyword: keyword)) { (result) in
      switch result {
      case .success(let response):
        let statusCode = response.statusCode
        let data = response.data
        
        let networkResult = self.judgeSearchStudioStatus(by: statusCode, data)
        completion(networkResult)
        
      case .failure(let err):
        print(err)
      }
    }
  }
  
  private func judgeSearchStudioStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(GenericResponse<StudioSearchResponse>.self, from: data)
    else { return .pathErr }
    
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
}
