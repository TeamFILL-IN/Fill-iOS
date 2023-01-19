//
//  UIViewController+Extension.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/19.
//

import Foundation
import UIKit

// MARK: - Extension
extension UIViewController {
  
  /// 확인+취소 UIAlertController
  func makeOKCancelAlert(title: String,
                         message: String,
                         okAction: ((UIAlertAction) -> Void)?,
                         cancelAction: ((UIAlertAction) -> Void)? = nil,
                         completion: (() -> Void)? = nil) {
    let alertViewController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
    alertViewController.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: cancelAction)
    alertViewController.addAction(cancelAction)
    
    self.present(alertViewController, animated: true, completion: completion)
  }
  
  /// 확인 UIAlertController
  func makeOKAlert(title: String,
                   message: String,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion: (() -> Void)? = nil) {
    let alertViewController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
    alertViewController.addAction(okAction)
    
    self.present(alertViewController, animated: true, completion: completion)
  }
  
  func changeRootViewController(_ viewControllerToPresent: UIViewController) {
    if let window = UIApplication.shared.windows.first {
      window.rootViewController = viewControllerToPresent
      UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
    } else {
      viewControllerToPresent.modalPresentationStyle = .overFullScreen
      self.present(viewControllerToPresent, animated: true, completion: nil)
    }
  }
}
