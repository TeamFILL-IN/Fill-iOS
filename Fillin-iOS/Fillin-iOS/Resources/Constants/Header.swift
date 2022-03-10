//
//  Header.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

extension Const {
  struct Header {
      static var tokenHeader = ["Content-Type": "application/json",
                                "token": accessToken]
      static var multiTokenHeader = ["Content-Type": "multipart/form-data",
                                "token": accessToken]
      static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
//    static var tokenHeader = ["Content-Type": "application/json",
//                              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0NjMyNjgxNCwiZXhwIjoxNjQ3NTM2NDE0LCJpc3MiOiJmaWxsaW4ifQ.BqXKeusdrBVWzt0HsIAM6wlG-VxcHw8qMEF9BSn0aEs"]
//    static var multiTokenHeader = [
//      "Content-Type": "multipart/form-data",
//      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0NjMyNjgxNCwiZXhwIjoxNjQ3NTM2NDE0LCJpc3MiOiJmaWxsaW4ifQ.BqXKeusdrBVWzt0HsIAM6wlG-VxcHw8qMEF9BSn0aEs"]
  }
}
