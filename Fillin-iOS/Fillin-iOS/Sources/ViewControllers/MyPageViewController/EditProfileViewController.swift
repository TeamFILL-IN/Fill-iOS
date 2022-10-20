//
//  EditProfileViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/10/03.
//

import UIKit

import SnapKit
import Then

// MARK: - EditProfileViewController
class EditProfileViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let profileImage = UIImageView()
  let editProfileButtonImage = UIButton()
  let editProfileLabel = UILabel()
  let nicknameLabel = UILabel()
  let nicknameTextField = UITextField()
  let nicknameBorder = UIView()
  let cameraLabel = UILabel()
  let cameraTextField = UITextField()
  let cameraBorder = UIView()
  let changeProfileButton = UIButton()
  final let maxLength = 10
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    setUI()
    attribute()
    attributePlaceholder()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange(_:)),
                                           name: UITextField.textDidChangeNotification,
                                           object: nicknameTextField)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange(_:)),
                                           name: UITextField.textDidChangeNotification,
                                           object: cameraTextField)
    
  }
}
// MARK: - Extensions
extension EditProfileViewController {
  func layout() {
    layoutNavigaionBar()
    layoutProfileImage()
    layoutEditProfileButtonImage()
    layoutEditProfileLabel()
    layoutNicknameLabel()
    layoutNicknameTextField()
    layoutNicknameBorder()
    layoutCameraLabel()
    layoutCameraTextField()
    layoutCameraBorder()
    layoutChangeProfileButton()
  }
  func layoutNavigaionBar() {
    self.view.add(navigationBar) {
      self.navigationBar.popViewController = {
        self.navigationController?.popViewController(animated: true)
      }
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        make.leading.trailing.equalToSuperview()
        make.height.equalTo(50)
      }
    }
  }
  func layoutProfileImage() {
    self.view.add(profileImage) {
      $0.setBorder(borderColor: .fillinWhite, borderWidth: 1)
      $0.setRounded(radius: 27.5)
      $0.image = Asset.noSearch.image
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.navigationBar.snp.bottom).offset(21)
        make.centerX.equalToSuperview()
        make.width.height.equalTo(55)
      }
    }
  }
  func layoutEditProfileButtonImage() {
    self.view.add(editProfileButtonImage) {
      $0.setImage(Asset.btnAddProfile.image, for: .normal)
      $0.addTarget(self, action: #selector(self.profileChangeButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints { make in
        make.top.leading.trailing.bottom.equalTo(self.profileImage)
        make.width.height.equalTo(55)
      }
    }
  }
  func layoutEditProfileLabel() {
    self.view.add(editProfileLabel) {
      $0.setupLabel(text: "프로필 사진 바꾸기", color: .grey3, font: .body1)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.editProfileButtonImage.snp.bottom).offset(12)
        make.centerX.equalToSuperview()
      }
    }
  }
  func layoutNicknameLabel() {
    self.view.add(nicknameLabel) {
      $0.setupLabel(text: "닉네임", color: .fillinWhite, font: .subhead3)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.editProfileLabel.snp.bottom).offset(28)
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutNicknameTextField() {
    self.view.add(nicknameTextField) {
      $0.placeholder = "닉네임을 입력해주세요. (10자 이하)"
      $0.font = .subhead1
      $0.textColor = .fillinWhite
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.clearButtonMode = .always
      if let clearButton = self.nicknameTextField.value(forKeyPath: "_clearButton") as? UIButton {
        clearButton.setImage(Asset.btnClear.image, for: .normal)
        $0.snp.makeConstraints { make in
          make.top.equalTo(self.nicknameLabel.snp.bottom).offset(16)
          make.centerX.equalToSuperview()
          make.leading.equalToSuperview().offset(18)
        }
      }
    }
  }
  func layoutNicknameBorder() {
    self.view.add(nicknameBorder) {
      $0.backgroundColor = .darkGrey1
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.nicknameTextField.snp.bottom).offset(6)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(1)
      }
    }
  }
  func layoutCameraLabel() {
    self.view.add(cameraLabel) {
      $0.setupLabel(text: "카메라", color: .fillinWhite, font: .subhead3)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.nicknameBorder.snp.bottom).offset(40)
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutCameraTextField() {
    self.view.add(cameraTextField) {
      $0.placeholder = "사용 중인 카메라 이름을 입력해주세요."
      $0.font = .subhead1
      $0.textColor = .fillinWhite
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.clearButtonMode = .always
      if let clearButton = self.cameraTextField.value(forKeyPath: "_clearButton") as? UIButton {
        clearButton.setImage(Asset.btnClear.image, for: .normal)
        $0.snp.makeConstraints { make in
          make.top.equalTo(self.cameraLabel.snp.bottom).offset(16)
          make.centerX.equalToSuperview()
          make.leading.equalToSuperview().offset(18)
        }
      }
    }
  }
  func layoutCameraBorder() {
    self.view.add(cameraBorder) {
      $0.backgroundColor = .darkGrey1
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.cameraTextField.snp.bottom).offset(6)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(1)
      }
    }
  }
  func layoutChangeProfileButton() {
    self.view.add(changeProfileButton) {
      $0.setupButton(title: "프로필 변경",
                     color: .grey4,
                     font: .headline,
                     backgroundColor: .textviewGrey,
                     state: .normal,
                     radius: 0)
      $0.isUserInteractionEnabled = false
      $0.addTarget(self, action: #selector(self.sendButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.leading.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
        make.height.equalTo(80)
      }
    }
  }
  func setUI() {
    self.view.backgroundColor = .fillinBlack
  }
  func attribute() {
    self.nicknameTextField.delegate = self
    self.cameraTextField.delegate = self
  }
  func attributePlaceholder() {
    nicknameTextField.attributedPlaceholder = NSAttributedString(string : "닉네임을 입력해주세요. (10자 이하)",
                                                                 attributes : [NSAttributedString.Key.foregroundColor: UIColor.grey4,
                                                                               NSAttributedString.Key.font  : UIFont.body1])
    cameraTextField.attributedPlaceholder = NSAttributedString(string : "사용 중인 카메라 이름을 입력해주세요.",
                                                               attributes : [NSAttributedString.Key.foregroundColor: UIColor.grey4,
                                                                             NSAttributedString.Key.font :UIFont.body1])
  }
  @objc func profileChangeButtonClicked() {
    print("프로필 이미지 변경하기")
  }
  @objc func sendButtonClicked() {
    print("프로필 변경하기")
  }
  /// 빈 공간 터치하면 키보드 내려가게
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

// MARK: - UITextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
  
  /// Return 눌렀을 때 키보드 내리기
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  /// nicknameTextField 글자수 세기, 제한
  @objc private func textDidChange(_ notification: Notification) {
    if let textField = notification.object as? UITextField {
      if let nicknametext = nicknameTextField.text {
        
        if nicknametext.count > maxLength {
          // 6글자 넘어가면 자동으로 키보드 내려감
          //          textField.resignFirstResponder()
          let countNum = nicknameTextField.text?.count ?? 0
          //          countTextLabel.text = "\(countNum)/6"
        }
        // 초과되는 텍스트 제거
        if nicknametext.count >= maxLength {
          let index = nicknametext.index(nicknametext.startIndex, offsetBy: maxLength)
          let newString = nicknametext[nicknametext.startIndex..<index]
          textField.text = String(newString)
          let countNum = nicknameTextField.text?.count ?? 0
          //          countTextLabel.text = "\(countNum)/6"
          if let clearButton = self.nicknameTextField.value(forKeyPath: "_clearButton") as? UIButton {
            clearButton.setImage(Asset.btnClear.image, for: .normal)
          }
        }
        if nicknametext.isEmpty == true {
          self.changeProfileButton.setupButton(title: "프로필 변경",
                                               color: .grey4,
                                               font: .headline,
                                               backgroundColor: .textviewGrey,
                                               state: .normal,
                                               radius: 0)
        } else {
          self.changeProfileButton.setupButton(title: "프로필 변경",
                                               color: .fillinBlack,
                                               font: .headline,
                                               backgroundColor: .fillinRed,
                                               state: .normal,
                                               radius: 0)
        }
      }
    }
  }
}
