//
//  FirstAddPhotoPopUpViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/14.
//

import UIKit

import SnapKit
import Then

// MARK: - FirstAddPhotoPopUpViewController
class FirstAddPhotoPopUpViewController: UIViewController {
  
  // MARK: - Components
  let dimmedBackView = UIView()
  let backgroundView = UIView()
  let explainLabel = UILabel()
  let subExplainLabel = UILabel()
  let trashIcon = UIImageView()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let continueButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
  }
}
// MARK: - Extension
extension FirstAddPhotoPopUpViewController {
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutDimmedView()
    layoutBackgroundView()
    layoutExplainLabel()
    layoutSubExplainLabel()
    layoutTrashIcon()
    layoutButtonContainerView()
    layoutCancelButton()
    layoutContinueButton()
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
      $0.backgroundColor = .darkGrey2
      $0.setBorder(borderColor: .darkGrey2, borderWidth: 1)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(237)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(338)
      }
    }
  }
  func layoutExplainLabel() {
    backgroundView.add(explainLabel) {
      $0.setupLabel(text: "사진추가를 취소하고 나갈까요?",
                    color: .white,
                    font: .body3)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backgroundView.snp.top).offset(56)
        $0.centerX.equalTo(self.backgroundView.snp.centerX)
      }
    }
  }
  func layoutSubExplainLabel() {
    backgroundView.add(subExplainLabel) {
      $0.setupLabel(text: "지금까지 입력된 정보들이\n저장되지 않고 모두 사라져요.",
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
  func layoutTrashIcon() {
    backgroundView.add(trashIcon) {
      $0.image = UIImage(asset: Asset.imgtrashRed)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.subExplainLabel.snp.bottom).offset(24)
        $0.centerX.equalTo(self.backgroundView.snp.centerX)
        $0.width.equalTo(59)
        $0.height.equalTo(78)
      }
    }
  }
  func layoutButtonContainerView() {
    backgroundView.add(buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.height.equalTo(64)
      }
    }
  }
  func layoutCancelButton() {
    buttonContainerView.add(cancelButton) {
      $0.setupButton(title: "나가기",
                     color: .grey2,
                     font: .body3,
                     backgroundColor: .darkGrey2,
                     state: .normal,
                     radius: 0)
      $0.setBorder(borderColor: .darkGrey1, borderWidth: 1)
      $0.addTarget(self, action: #selector(self.touchCancelButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.leading.bottom.equalToSuperview()
        $0.trailing.equalTo(self.buttonContainerView.snp.centerX)
      }
    }
  }
  func layoutContinueButton() {
    buttonContainerView.add(continueButton) {
      $0.setupButton(title: "이어서 추가하기",
                     color: .fillinWhite,
                     font: .body3,
                     backgroundColor: .clear,
                     state: .normal,
                     radius: 0)
      $0.setBorder(borderColor: .darkGrey1, borderWidth: 1)
      $0.addTarget(self, action: #selector(self.touchContinueButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.trailing.bottom.equalToSuperview()
        $0.leading.equalTo(self.buttonContainerView.snp.centerX)
      }
    }
  }
  @objc func touchCancelButton() {
    // 현재 올라와있는 모달을 dismiss 하고 Pop
    guard let parentVC = presentingViewController as? UINavigationController else { return }
    dismiss(animated: true) {
      parentVC.popViewController(animated: true)
    }
  }
  @objc func touchContinueButton() {
    // 정보를 그대로 놔두고 dismiss
    self.dismiss(animated: true, completion: nil)
  }
}
