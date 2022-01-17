//
//  NetworkResult.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/17.
//

import Foundation

enum NetworkResult<T> {
  case success(T)                    // 서버 통신 성공
  case requestErr(T)            // 요청 에러 발생
  case pathErr                        // 경로 에러
  case serverErr                    // 서버의 내부적 에러
  case networkFail                // 네트워크 연결 실패
}
