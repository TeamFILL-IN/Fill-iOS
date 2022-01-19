//
//  FilmResponse.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import Foundation

// MARK: - FilmResponse
struct FilmResponse: Codable {
    let films: [Film]
}

// MARK: - Film
struct Film: Codable {
    let id: Int
    let name: String
    let styleID: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case styleID = "styleId"
    }
}
