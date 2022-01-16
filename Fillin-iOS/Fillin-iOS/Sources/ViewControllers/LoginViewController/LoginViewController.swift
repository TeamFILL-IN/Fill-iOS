//
//  LoginViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/16.
//

import UIKit

import SnapKit
import Then

// MARK: - LoginViewController
class LoginViewController: UIViewController {
  
  // MARK: - Components
  let fillinLogoIcon = UIImageView()
  let fillinexplainengLabel = UILabel()
  let fillinexplainkorLabel = UILabel()
  let appleloginBar = UIImageView()
  let appleloginIcon = UIButton()
  let appleloginexplainLabel = UILabel()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    layout()
  }
}
// MARK: - Extension
extension LoginViewController {
  func layout() {
    layoutFillinLogoIcon()
    layoutFillinExplainEngLabel()
    layoutFillinExplainKorLabel()
    layoutAppleLoginBar()
    layoutAppleLoginIcon()
    layoutAppleLoginExplainLabel()
  }
  func layoutFillinLogoIcon() {
    view.add(fillinLogoIcon) {
      $0.image = UIImage(asset: Asset.loginLogo)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(60)
        $0.leading.equalToSuperview().offset(30)
        $0.width.equalTo(57)
        $0.height.equalTo(50)
      }
    }
  }
  func layoutFillinExplainEngLabel() {
    view.add(fillinexplainengLabel) {
      $0.setupLabel(text: "Fill-in your Feel\nFill-in your film-",
                    color: .fillinWhite,
                    font: .engHead)
      $0.textAlignment = .left
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.fillinLogoIcon.snp.bottom).offset(40)
        $0.leading.equalTo(self.fillinLogoIcon.snp.leading)
      }
    }
  }
  func layoutFillinExplainKorLabel() {
    view.add(fillinexplainkorLabel) {
      $0.setupLabel(text: "필린에서 소중한 추억을\nFILL-IN 해보세요",
                    color: .fillinWhite,
                    font: .display)
      $0.textAlignment = .left
      $0.numberOfLines = 2
      /// FILL-IN만 굵은 글씨로 변경하기
      let attributedStr = NSMutableAttributedString(string: self.fillinexplainkorLabel.text ?? "")
      attributedStr.addAttribute(.font, value: UIFont.engbigHead2, range: (self.fillinexplainkorLabel.text! as NSString).range(of: "FILL-IN"))
      self.fillinexplainkorLabel.attributedText = attributedStr
      $0.snp.makeConstraints {
        $0.top.equalTo(self.fillinexplainengLabel.snp.bottom).offset(100)
        $0.leading.equalTo(self.fillinLogoIcon.snp.leading)
      }
    }
  }
  func layoutAppleLoginBar() {
    view.add(appleloginBar) {
      $0.image = UIImage(asset: Asset.btnlogin)
      $0.snp.makeConstraints {
        $0.bottom.equalToSuperview().offset(-90)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(30)

      }
    }
  }
  func layoutAppleLoginIcon() {
    appleloginBar.add(appleloginIcon) {
      $0.setImage(UIImage(asset: Asset.appleLogo), for: .normal)
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalToSuperview().offset(76)
        $0.width.equalTo(24)
        $0.height.equalTo(24)
      }
    }
  }
  func layoutAppleLoginExplainLabel() {
    appleloginBar.add(appleloginexplainLabel) {
      $0.setupLabel(text: "Apple로 시작하기",
                    color: .fillinBlack,
                    font: .subhead3)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalTo(self.appleloginIcon.snp.trailing).offset(16)
      }
    }
  }
}
