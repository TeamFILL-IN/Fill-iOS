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
}
