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
                                  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOm51bGwsImlhdCI6MTY0MjYxMTIzMSwiZXhwIjoxNjQzODIwODMxLCJpc3MiOiJmaWxsaW4ifQ.LDKIuHuEEJUuFVJWYfPJnemK24YUMepTcNjahR2TVd0"]
      static var multiTokenHeader = [
        "Content-Type": "multipart/form-data",
                                "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiZW1haWwiOm51bGwsImlhdCI6MTY0MjYxMTIzMSwiZXhwIjoxNjQzODIwODMxLCJpc3MiOiJmaWxsaW4ifQ.LDKIuHuEEJUuFVJWYfPJnemK24YUMepTcNjahR2TVd0"]
    }
}
