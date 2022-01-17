//
//  Photos.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

// MARK: - DataClass
struct Photos: Codable {
    let photos: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let studioName: String?
    let nickname: String
    let userImageURL: String
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
