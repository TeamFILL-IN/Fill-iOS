//
//  LoginResponse.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/21.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let type, email: String
    let nickname: String?
    let accessToken, refreshToken: String
}
