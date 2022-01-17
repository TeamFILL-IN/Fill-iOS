//
//  Const.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import Foundation
struct Const {
    static let accessToken: String = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? ""
}
