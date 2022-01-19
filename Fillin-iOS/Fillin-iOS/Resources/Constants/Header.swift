//
//  Header.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

extension Const {
    struct Header {
//        static var tokenHeader = ["Content-Type": "application/json",
//                                  "token": accessToken]
        static var tokenHeader = ["Content-Type": "application/json",
                                  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJ0cGduczc3MDhAbmF2ZXIuY29tIiwiaWF0IjoxNjQyNjA4MDc5LCJleHAiOjE2NDM4MTc2NzksImlzcyI6ImZpbGxpbiJ9.ALonKj3zCrdoJtdYxdbPJe0-npZIKH3aBW6KSIuk-NI"]
      static var multiTokenHeader = [
        "Content-Type": "multipart/form-data",
                                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOiJ0cGduczc3MDhAbmF2ZXIuY29tIiwiaWF0IjoxNjQyNjA4MDc5LCJleHAiOjE2NDM4MTc2NzksImlzcyI6ImZpbGxpbiJ9.ALonKj3zCrdoJtdYxdbPJe0-npZIKH3aBW6KSIuk-NI"]
    }
}
