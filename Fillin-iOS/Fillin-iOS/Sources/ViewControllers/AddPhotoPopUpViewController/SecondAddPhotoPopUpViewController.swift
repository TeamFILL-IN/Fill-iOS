//
//  SecondAddPhotoPopUpViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/14.
//

import UIKit

import SnapKit
import Then

// MARK: - SecondAddPhotoPopUpViewController
class SecondAddPhotoPopUpViewController: UIViewController {
  
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
    setupGestureRecognizer()
  }
}
// MARK: - Extension
extension SecondAddPhotoPopUpViewController {
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
  func layoutDeleteButton() {
    backgroundView.add(deleteButton) {
      $0.setImage(UIImage(asset: Asset.icnGo), for: .normal)
      $0.addTarget(self, action: #selector(self.touchDeleteButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(14)
        $0.trailing.equalToSuperview().offset(14)
      }
    }
  }
  func layoutExplainLabel() {
    backgroundView.add(explainLabel) {
      $0.setupLabel(text: "사진 추가를 완료했어요!",
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
      $0.setupLabel(text: "마이페이지에서 내가 올린 사진들을\n확인할 수 있어요.",
                    color: .grey2,
                    font: .body2)
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainLabel.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
      }
    }
  }
  func layoutCheckmarkIcon() {
    backgroundView.add(checkmarkIcon) {
      $0.image = UIImage(asset: Asset.icnGo)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.explainLabel.snp.bottom).offset(41)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(71)
        $0.height.equalTo(71)
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
  @objc func touchDeleteButton() {
    /// pop 되면서 FilmRoll뷰로 Push 되도록 하는 코드
  }
}
