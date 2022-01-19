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
                                  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoiIiwiaWF0IjoxNjQyNTk1MzM5LCJleHAiOjE2NDM4MDQ5MzksImlzcyI6ImZpbGxpbiJ9.VvyFxRHOI5oMpKubbk7Ib3JV-Q9cz9Ehwo9lkUq_3TQ"]
      static var multiTokenHeader = [
        "Content-Type": "multipart/form-data",
                                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImVtYWlsIjoiIiwiaWF0IjoxNjQyNTk1MzM5LCJleHAiOjE2NDM4MDQ5MzksImlzcyI6ImZpbGxpbiJ9.VvyFxRHOI5oMpKubbk7Ib3JV-Q9cz9Ehwo9lkUq_3TQ"]
    }
}
