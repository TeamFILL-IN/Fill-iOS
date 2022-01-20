//
//  LoginRequest.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/21.
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Codable {
    let token, social, idKey: String
}
