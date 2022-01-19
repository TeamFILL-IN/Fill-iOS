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
      // 멀티파트폼에 Int로 들어온 것을 String에 담아서 보내기(Int로 보낼 수 없음)
      let studioIdData = String(studioId).data(using: .utf8) ?? Data()
      let filmIdData = String(filmId).data(using: .utf8) ?? Data()
      multiPartFormData.append(MultipartFormData(provider: .data(studioIdData), name: "studioId"))
      multiPartFormData.append(MultipartFormData(provider: .data(filmIdData), name: "filmId"))
      // UIImage를 jpegImageData로 변환
      let imageData = images.jpegData(compressionQuality: 1.0)
      // jpegData를 MultipartformData로 변환
      let imgData = MultipartFormData(provider: .data(imageData!), name: "imgs", fileName: "image.jpg", mimeType: "image/jpeg")
      multiPartFormData.append(imgData)
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
