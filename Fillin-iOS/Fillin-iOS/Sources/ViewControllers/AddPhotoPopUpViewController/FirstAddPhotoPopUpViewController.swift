//
//  AddPhotoPopUpViewController.swift
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
  let trashIcon = UIImageView()
  let buttonContainerView = UIView()
  let cancelButton = UIButton()
  let continueButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    setupGestureRecognizer()
  }
}
// MARK: - Extension
extension FirstAddPhotoPopUpViewController {
  func layout() {
    self.view.backgroundColor = .backgroundCover
    layoutDimmedView()
    layoutBackgroundView()
    layoutExplainLabel()
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
      $0.backgroundColor = .darkGrey3
      $0.setBorder(borderColor: .darkGrey1, borderWidth: 1)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(256)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(300)
      }
    }
  }
  func layoutExplainLabel() {
    backgroundView.add(explainLabel) {
      $0.setupLabel(text: "사진추가를 취소할까요?\n입력하신 정보가 모두 삭제됩니다.",
                    color: .white,
                    font: .body3)
      $0.textAlignment = .center
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.backgroundView.snp.top).offset(44)
        $0.centerX.equalTo(self.backgroundView.snp.centerX)
      }
    }
  }
  func layoutTrashIcon() {
    backgroundView.add(trashIcon) {
      $0.image = UIImage(asset: Asset.icnGo)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainLabel.snp.bottom).offset(26)
        $0.centerX.equalTo(self.backgroundView.snp.centerX)
        $0.width.equalTo(90)
        $0.height.equalTo(90)
      }
    }
  }
  func layoutButtonContainerView() {
    backgroundView.add(buttonContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.height.equalTo(60)
      }
    }
  }
  func layoutCancelButton() {
    buttonContainerView.add(cancelButton) {
      $0.setupButton(title: "취소하기",
                     color: .grey3,
                     font: .subhead3,
                     backgroundColor: .darkGrey2,
                     state: .normal,
                     radius: 0)
      $0.setBorder(borderColor: .darkGrey1, borderWidth: 1)
      $0.addTarget(self, action: #selector(self.touchCancelButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.leading.bottom.equalToSuperview()
        $0.width.equalTo((UIScreen.main.bounds.width-36)*0.4)
      }
    }
  }
  func layoutContinueButton() {
    buttonContainerView.add(continueButton) {
      $0.setupButton(title: "이어서 추가하기",
                     color: .fillinBlack,
                     font: .subhead3,
                     backgroundColor: .fillinRed,
                     state: .normal,
                     radius: 0)
      $0.addTarget(self, action: #selector(self.touchContinueButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.trailing.bottom.equalToSuperview()
        $0.width.equalTo((UIScreen.main.bounds.width-36)*0.6)
      }
    }
  }
  private func setupGestureRecognizer() {
      // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
      let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(tappedDimmedView(_:)))
      dimmedBackView.addGestureRecognizer(dimmedTap)
      dimmedBackView.isUserInteractionEnabled = true
  }
  private func dismissPopUp() {
      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
          self.dimmedBackView.alpha = 0.0
          self.view.layoutIfNeeded()
          self.backgroundView.isHidden = true
      }, completion: { _ in
          if self.presentingViewController != nil {
              self.dismiss(animated: false, completion: nil)
          }
      })
  }
  @objc private func tappedDimmedView(_ tapRecognizer: UITapGestureRecognizer) {
      dismissPopUp()
  }
  @objc func touchCancelButton() {
    
  }
  @objc func touchContinueButton() {
    
  }
}
