//
//  StudioInfoResponse.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/19.
//

import Foundation

// MARK: - StudioInfoResponse
struct StudioInfoResponse: Codable {
    let studio: StudioInfo
}

// MARK: - Studio
struct StudioInfo: Codable {
    let id: Int
    let name, address, price, time: String?
    let tel: String?
    let lati, long: Double
    let etc: String?
    let isDeleted: Bool
    let site: String?
}
