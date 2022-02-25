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
                              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0NDA4MDI4NywiZXhwIjoxNjQ1Mjg5ODg3LCJpc3MiOiJmaWxsaW4ifQ.2nXlLuXzsOdrQaVDaSldfEC86XOzTn9E4Zn5grzNifA"]
    static var multiTokenHeader = [
      "Content-Type": "multipart/form-data",
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0NDA4MDI4NywiZXhwIjoxNjQ1Mjg5ODg3LCJpc3MiOiJmaWxsaW4ifQ.2nXlLuXzsOdrQaVDaSldfEC86XOzTn9E4Zn5grzNifA"]
    
    static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
  }
}
