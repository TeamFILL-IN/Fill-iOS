//
//  StudioPhotoResponse.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/19.
//

import Foundation

// MARK: - StudioPhotoResponse
struct StudioPhotoResponse: Codable {
  let photos: [PhotoStudio]
}

// MARK: - Photo
struct PhotoStudio: Codable {
  let studioName, nickname, userImageURL: String
  let photoID: Int
  let imageURL: String
  let filmID: Int
  let filmName: String
  let likeCount: Int

  enum CodingKeys: String, CodingKey {
      case studioName, nickname
      case userImageURL = "userImageUrl"
      case photoID = "photoId"
      case imageURL = "imageUrl"
      case filmID = "filmId"
      case filmName, likeCount
  }
}
