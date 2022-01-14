//
//  UIButton+Extension.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/11.
//

import Foundation
import UIKit

extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 3,
            right: -imageTitlePadding
        )
    }
  func setupButton(title: String,
                   color: UIColor,
                   font: UIFont,
                   backgroundColor: UIColor,
                   state: UIControl.State,
                   radius: CGFloat) {
    self.setTitle(title, for: state)
    self.setTitleColor(color, for: state)
    self.titleLabel?.font = font
    self.backgroundColor = backgroundColor
    self.setRounded(radius: radius)
  }
}
