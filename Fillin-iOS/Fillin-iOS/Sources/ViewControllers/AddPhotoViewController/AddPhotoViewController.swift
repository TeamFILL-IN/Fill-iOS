//
//  AddPhotoViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

import SnapKit
import Then

// MARK: - ADddPhotoViewController
class AddPhotoViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let photobackgroundView = UIView()
  let photoIcon = UIButton()
  let filmLabel = UILabel()
  let filmchooseButton = UIButton()
  let studioLabel = UILabel()
  let studiochooseButton = UIButton()
  let addphotoBackground = UIView()
  let addphotoButton = UIButton()
  
  // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
      layout()
    }
}
// MARK: - Extension
extension AddPhotoViewController {
  func layout() {
  }
  func layoutNavigationBar() {
    view.add(navigationBar) {
      self.navigationBar.popViewController = {
        self.navigationController?.popViewController(animated: true)
      }
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
  }
  func layoutPhotoBackgroundView() {
    view.add(photobackgroundView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.navigationBar.snp.bottom)
        $0.centerX.equalToSuperview()
        $0.width.height.equalTo(self.view.frame.width)
      }
    }
  }
  func layoutPhotoIcon() {
    photobackgroundView.add(photoIcon) {
      $0.setImage(UIImage(asset: Asset.icnEdit), for: .normal)
      $0.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.centerY.equalToSuperview()
        $0.width.equalTo(106)
        $0.height.equalTo(106)
      }
    }
  }
  func layoutFilmLabel() {
    view.add(filmLabel) {
      $0.setupLabel(text: "Film",
                    color: .fillinWhite,
                    font: .body3)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photobackgroundView.snp.bottom).offset(30)
        $0.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutFilmChooseButton() {
    view.add(filmchooseButton) {
      $0.setupButton(title: "어떤 필름을 사용했나요?",
                     color: .grey1,
                     font: .body2,
                     backgroundColor: .darkGrey2,
                     state: .normal,
                     radius: 0)
      $0.setBorder(borderColor: .fillinRed, borderWidth: 1)
    }
  }
}
