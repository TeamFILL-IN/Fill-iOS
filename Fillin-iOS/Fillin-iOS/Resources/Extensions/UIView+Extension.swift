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
  func setRounded(radius: CGFloat?){
    // UIView 의 모서리가 둥근 정도를 설정
    if let cornerRadius_ = radius {
      self.layer.cornerRadius = cornerRadius_
    }  else {
      // cornerRadius 가 nil 일 경우의 default
      self.layer.cornerRadius = self.layer.frame.height / 2
    }
    
    self.layer.masksToBounds = true
  }
  
  
  func setBorder(borderColor : UIColor?,
                 borderWidth : CGFloat?) {
    
    /// UIView 의 테두리 색상 설정
    if let borderColor_ = borderColor {
      self.layer.borderColor = borderColor_.cgColor
    } else {
      /// borderColor 변수가 nil 일 경우의 default
      self.layer.borderColor = UIColor(red: 205/255,
                                       green: 209/255,
                                       blue: 208/255,
                                       alpha: 1.0).cgColor
    }
    
    /// UIView 의 테두리 두께 설정
    if let borderWidth_ = borderWidth {
      self.layer.borderWidth = borderWidth_
    } else {
      /// borderWidth 변수가 nil 일 경우의 default
      self.layer.borderWidth = 1.0
    }
  }
}
