//
//  likedStudios.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2023/01/19.
//

import Foundation

struct LikedStudiosResponse: Codable {
  let likedStudios: [LikedStudio]
}

// MARK: - Studio
struct LikedStudio: Codable {
  let id: Int
  let name, address: String
}
