//
//  StudioResponse.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/18.
//

import Foundation

// MARK: - StudioResponse
struct StudioResponse: Codable {
    let studio: [Studio]
}

// MARK: - Studio
struct Studio: Codable {
    let id: Int
    let lati, long: Double
}

