//
//  OnboardingViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/16.
//

import UIKit

import SnapKit
import Then

// MARK: - OnboardingFirstViewController
class OnboardingFirstViewController: UIViewController {
  
  // MARK: - Components
  let subexplainLabel = UILabel()
  let boldTitleLabel = UILabel()
  let onboardimage = UIImageView()
  let underbackView = UIView()
  let undercontainerView = UIView()
  let progressIndicator = UIImageView()
  let jumpButton = UIButton()
  let nextButton = UIButton()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    layout()
  }
}

// MARK: - Extension
extension OnboardingFirstViewController {
  func layout() {
    layoutSubExplainLabel()
    layoutBoldTitleLabel()
    layoutOnboardImage()
    layoutUnderBackView()
    layoutUnderContainerView()
    layoutProgressIndicator()
    layoutJumpButton()
    layoutNextButton()
  }
  func layoutSubExplainLabel() {
    view.add(subexplainLabel) {
      $0.setupLabel(text: "필름을 스캔 할 현상소 정보를 찾고 계신가요?",
                    color: .grey1,
                    font: .body2)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(64)
        $0.leading.equalToSuperview().offset(28)
      }
    }
  }
  func layoutBoldTitleLabel() {
    view.add(boldTitleLabel) {
      $0.setupLabel(text: "주변 현상소 정보를\n필린에서 찾아보세요!",
                    color: .fillinWhite,
                    font: .display1)
      $0.textAlignment = .left
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subexplainLabel.snp.bottom).offset(18)
        $0.leading.equalTo(self.subexplainLabel.snp.leading)
      }
    }
  }
  func layoutOnboardImage() {
    view.add(onboardimage) {
      $0.image = UIImage(asset: Asset.imgonboarding1frame)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.boldTitleLabel.snp.bottom).offset(67)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(375)
        $0.height.equalTo(530)
      }
    }
  }
  func layoutUnderBackView() {
    view.add(underbackView) {
      $0.backgroundColor = .fillinBlack
      $0.snp.makeConstraints {
        $0.bottom.equalToSuperview()
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(80)
      }
    }
  }
  func layoutUnderContainerView() {
    underbackView.add(undercontainerView) {
      $0.snp.makeConstraints {
        $0.bottom.equalToSuperview().offset(-44)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(31)
        $0.height.equalTo(22)
      }
    }
  }
  func layoutProgressIndicator() {
    undercontainerView.add(progressIndicator) {
      $0.image = UIImage(asset: Asset.imgOnboardingDot1)
      $0.snp.makeConstraints {
        $0.centerX.centerY.equalToSuperview()
        $0.width.equalTo(43)
        $0.height.equalTo(7)
      }
    }
  }
  func layoutJumpButton() {
    undercontainerView.add(jumpButton) {
      $0.setupButton(title: "건너뛰기",
                     color: .grey3,
                     font: .subhead3,
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.touchjumpButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalToSuperview()
      }
    }
  }
  func layoutNextButton() {
    undercontainerView.add(nextButton) {
      $0.setupButton(title: "다음",
                     color: .fillinRed,
                     font: .subhead3,
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.touchNextButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalToSuperview()
      }
    }
  }
  @objc func touchjumpButton() {
    let loginVC = LoginViewController()
    loginVC.modalPresentationStyle = .fullScreen
    self.present(loginVC, animated: true, completion: nil)
  }
  @objc func touchNextButton() {
    let onboarding2VC = OnboardingSecondViewController()
    self.navigationController?.pushViewController(onboarding2VC, animated: false)
  }
}
