//
//  Header.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

extension Const {
  struct Header {
//      static var tokenHeader = ["Content-Type": "application/json",
//                                "token": accessToken]
//      static var multiTokenHeader = ["Content-Type": "multipart/form-data",
//                                "token": accessToken]
//      static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
    static var tokenHeader = ["Content-Type": "application/json",
                              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDEsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJpYXQiOjE2NjE2ODI2NDYsImV4cCI6MTY2Mjg5MjI0NiwiaXNzIjoiZmlsbGluIn0.eMdMGx1snCx2RkbV-_aVP7or8wYyG0Gc4M5beH-Vthk"]
    static var multiTokenHeader = [
      "Content-Type": "multipart/form-data",
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDEsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJpYXQiOjE2NjE2ODI2NDYsImV4cCI6MTY2Mjg5MjI0NiwiaXNzIjoiZmlsbGluIn0.eMdMGx1snCx2RkbV-_aVP7or8wYyG0Gc4M5beH-Vthk"]
  }
}
