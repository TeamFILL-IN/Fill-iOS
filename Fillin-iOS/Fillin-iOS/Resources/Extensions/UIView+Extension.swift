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
  @discardableResult
  func add<T: UIView>(_ subview: T,
                      then closure: ((T) -> Void)? = nil) -> T {
    addSubview(subview)
    closure?(subview)
    return subview
  }
  
  @discardableResult
  func adds<T: UIView>(_ subviews: [T],
                       then closure: (([T]) -> Void)? = nil) -> [T] {
    subviews.forEach { addSubview($0) }
    closure?(subviews)
    return subviews
  }
  
}
