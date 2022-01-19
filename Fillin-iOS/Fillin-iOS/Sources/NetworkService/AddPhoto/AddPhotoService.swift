//
//  AddPhotoService.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation
import Moya

enum AddPhotoService {
  case addPhotos(studioId: Int, filmId: Int, img: UIImage)
}

extension AddPhotoService: TargetType {
  
  var baseURL: URL {
    return URL(string: Const.URL.baseURL)!
  }
  
  var path: String {
    switch self {
    case .addPhotos:
      return "/photo"
      
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .addPhotos:
      return .post
      
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .addPhotos(let studioId, let filmId, let images):
      var multiPartFormData: [MultipartFormData] = []
      
      let studioIdData = String(studioId).data(using: .utf8) ?? Data()
      let filmIdData = String(filmId).data(using: .utf8) ?? Data()
      
      multiPartFormData.append(MultipartFormData(provider: .data(studioIdData), name: "studioId"))
      multiPartFormData.append(MultipartFormData(provider: .data(filmIdData), name: "filmId"))
      
      print("두비두밥")
      /// UIImage를 jpegImageData로 변환
      let imageData = images.jpegData(compressionQuality: 1.0)
      /// jpegData를 MultipartformData로 변환
      let imgData = MultipartFormData(provider: .data(imageData!), name: "imgs", fileName: "image.jpg", mimeType: "image/jpeg")
      multiPartFormData.append(imgData)
      
      print("박수")
      return .uploadMultipart(multiPartFormData)
    }
  }
  
  var headers: [String: String]? {
    switch self {
    case .addPhotos:
      return Const.Header.multiTokenHeader
    }
  }
}
