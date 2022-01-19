//
//  CurationResponse.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import Foundation
// MARK: - CurationResponse
struct CurationResponse: Codable {
    let curation: Curation
    let photos: [Photo]
}

// MARK: - Curation
struct Curation: Codable {
    let id: Int
    let title, photoList: String
}
