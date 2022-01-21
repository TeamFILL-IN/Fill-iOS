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
                              "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0Mjc2Mzk5MiwiZXhwIjoxNjQzOTczNTkyLCJpc3MiOiJmaWxsaW4ifQ.uC2WmNdGkWd_HUiGyFo7WLIW0EB9xHuLBuCRmKzI4xY"]
    static var multiTokenHeader = [
      "Content-Type": "multipart/form-data",
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwiZW1haWwiOm51bGwsImlhdCI6MTY0Mjc2Mzk5MiwiZXhwIjoxNjQzOTczNTkyLCJpc3MiOiJmaWxsaW4ifQ.uC2WmNdGkWd_HUiGyFo7WLIW0EB9xHuLBuCRmKzI4xY"]
    
    static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
  }
}
