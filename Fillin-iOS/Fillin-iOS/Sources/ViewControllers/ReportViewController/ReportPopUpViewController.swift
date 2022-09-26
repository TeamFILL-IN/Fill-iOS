//
//  ReportPopUpViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/09/24.
//

import UIKit

import SnapKit
import Then

// MARK: - ReportPopUpViewController
class ReportPopUpViewController: UIViewController {
  
  // MARK: - Components
  let dimmedBackView = UIView()
  let backgroundView = UIView()
  let deleteButton = UIButton()
  let explainLabel = UILabel()
  let subexplainLabel = UILabel()
  let checkmarkIcon = UIImageView()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}
// MARK: - Extension
extension ReportPopUpViewController {
  func layout() {
    layoutDimmedView()
    layoutBackgroundView()
    layoutDeleteButton()
    layoutExplainLabel()
    layoutSubExplainLabel()
    layoutCheckmarkIcon()
  }
  func layoutDimmedView() {
    view.add(dimmedBackView) {
      $0.backgroundColor = .backgroundCover
      $0.snp.makeConstraints {
        $0.top.leading.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutBackgroundView() {
    view.add(backgroundView) {
      $0.backgroundColor = .textviewGrey
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(256)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(300)
      }
    }
  }
  func layoutDeleteButton() {
    backgroundView.add(deleteButton) {
      $0.setImage(Asset.icnClosewhite.image, for: .normal)
      $0.addTarget(self, action: #selector(self.touchDeleteButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(14)
        $0.trailing.equalToSuperview().offset(-14)
        $0.width.equalTo(24)
        $0.height.equalTo(24)
      }
    }
  }
  func layoutExplainLabel() {
    backgroundView.add(explainLabel) {
      $0.setupLabel(text: "소중한 의견이 접수되었어요!",
                    color: .white,
                    font: .body3)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backgroundView.snp.top).offset(56)
        $0.centerX.equalTo(self.backgroundView.snp.centerX)
      }
    }
  }
  func layoutSubExplainLabel() {
    backgroundView.add(subexplainLabel) {
      $0.setupLabel(text: "필린에서 최대한 빠르게  반영해둘게요!",
                    color: .grey2,
                    font: .body2)
      $0.numberOfLines = 2
      $0.textAlignment = .center
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainLabel.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCheckmarkIcon() {
    backgroundView.add(checkmarkIcon) {
      $0.image = Asset.imgFeedback.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subexplainLabel.snp.bottom).offset(41)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(88)
        $0.height.equalTo(88)
      }
    }
  }
  @objc func touchDeleteButton() {
    // 현재 올라와있는 모달을 dismiss 하고 원래VC 로 Push 하는 코드
    guard let parentVC = presentingViewController as? UINavigationController else { return }
    dismiss(animated: true) {
      parentVC.popViewController(animated: true)
    }
  }
}

