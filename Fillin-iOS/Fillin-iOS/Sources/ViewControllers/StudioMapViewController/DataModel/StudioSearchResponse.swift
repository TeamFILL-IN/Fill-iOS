//
//  StudioSearchResponse.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/20.
//

import Foundation

// MARK: - StudioSearchResponse
struct StudioSearchResponse: Codable {
    let studios: [Studios]
}

// MARK: - Studios
struct Studios: Codable {
    let id: Int
    let name, address: String
}
