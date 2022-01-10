//
//  UIView+Extension.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/10.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ view: [UIView]) {
        view.forEach { self.addSubview($0) }
    }
}
