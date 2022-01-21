//
//  UILabel+Extension.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/11.
//

import Foundation
import UIKit

extension UILabel {
  func setupLabel(text: String,
                  color: UIColor,
                  font: UIFont,
                  align: NSTextAlignment? = .left) {
    self.font = font
    self.text = text
    self.textColor = color
    self.textAlignment = align ?? .left
  }
  
  func updateServerLabel(name: String, keyword: String) {
    // myLabel의 텍스트를 가지고 옵니다.
//    guard let text = self.text else { return }
//
//    // myLabel의 text로 NSMutableAttributedString 인스턴스를 만들어줍니다.
//    let attributeString = NSMutableAttributedString(string: text)
//
//    // NSMutableAttributedString에 속성을 추가합니다.
//    // 현재 추가한 속성은 "Pingu"만 빨간색으로 바꾼다! 입니다.
//    attributeString.addAttribute(.foregroundColor, value: UIColor.red, range: (text as NSString).range(of: keyword))
//
//    // myLabel에 방금 만든 속성을 적용합니다.
//    self.text.attributedText = attributeString
    self.text = name
  }
}
