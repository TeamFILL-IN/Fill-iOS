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
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    layout()
  }
}
// MARK: - Extension
extension AddPhotoViewController {
  func layout() {
    layoutNavigationBar()
    layoutPhotoBackgroundView()
    layoutPhotoIcon()
    layoutFilmLabel()
    layoutFilmChooseButton()
    layoutStudioLabel()
    layoutStudioChooseButton()
    layoutAddPhotoBackground()
    layoutAddphotoButton()
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
      $0.setImage(UIImage(asset: Asset.icnAddPhotoBig), for: .normal)
      $0.addTarget(self, action: #selector(self.touchphotoIconButton), for: .touchUpInside)
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
      $0.contentHorizontalAlignment = .left
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
      $0.addTarget(self, action: #selector(self.touchfilmChooseButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.filmLabel.snp.bottom).offset(9)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(48)
      }
    }
  }
  func layoutStudioLabel() {
    view.add(studioLabel) {
      $0.setupLabel(text: "Studio",
                    color: .fillinWhite,
                    font: .body3)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.filmchooseButton.snp.bottom).offset(18)
        $0.leading.equalTo(self.filmLabel.snp.leading)
      }
    }
  }
  func layoutStudioChooseButton() {
    view.add(studiochooseButton) {
      $0.setupButton(title: "어떤 현상소에서 현상했나요?",
                     color: .grey1,
                     font: .body2,
                     backgroundColor: .darkGrey2,
                     state: .normal,
                     radius: 0)
      $0.setBorder(borderColor: .fillinRed, borderWidth: 1)
      $0.contentHorizontalAlignment = .left
      $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
      $0.addTarget(self, action: #selector(self.touchstudioChooseButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioLabel.snp.bottom).offset(9)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(48)
      }
    }
  }
  func layoutAddPhotoBackground() {
    view.add(addphotoBackground) {
      $0.backgroundColor = .fillinRed
      $0.snp.makeConstraints {
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalToSuperview()
        $0.height.equalTo(74)
      }
    }
  }
  func layoutAddphotoButton() {
    addphotoBackground.add(addphotoButton) {
      $0.setTitle("Add Photo", for: .normal)
      $0.titleLabel?.font = .engBighead
      $0.setTitleColor(.fillinBlack, for: .normal)
      $0.addTarget(self, action: #selector(self.touchaddPhotoButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(15)
        $0.centerX.equalToSuperview()
      }
    }
  }
  @objc func touchphotoIconButton() {
   
  }
  @objc func touchfilmChooseButton() {
    
  }
  @objc func touchstudioChooseButton() {
    
  }
  @objc func touchaddPhotoButton() {
   let secondVC = SecondAddPhotoPopUpViewController()
    secondVC.modalPresentationStyle = .overCurrentContext
    secondVC.modalTransitionStyle = .crossDissolve
    self.present(secondVC, animated: false, completion: nil)
  }
}
