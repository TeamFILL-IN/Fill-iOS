//
//  LoginViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/16.
//

import UIKit

import SnapKit
import Then
import AuthenticationServices

// MARK: - LoginViewController
class LoginViewController: UIViewController {
  
  // MARK: - Components
  let fillinLogoIcon = UIImageView()
  let fillinexplainengLabel = UILabel()
  let fillinexplainkorLabel = UILabel()
  let appleloginBar = UIButton()
  let appleloginIcon = UIButton()
  let appleloginexplainLabel = UILabel()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    layout()
    setUI()
  }
}
// MARK: - Extension
extension LoginViewController {
  func layout() {
    layoutFillinLogoIcon()
    layoutFillinExplainEngLabel()
    layoutFillinExplainKorLabel()
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
  func setUI() {
    let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    authorizationButton.addTarget(self, action: #selector(appleSignInButtonPress), for: .touchUpInside)
    view.add(authorizationButton) {
      authorizationButton.translatesAutoresizingMaskIntoConstraints = false
      $0.snp.makeConstraints {
        $0.bottom.equalToSuperview().offset(-90)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(30)
        $0.height.equalTo(44)
      }
    }
  }
  @objc
  func appleSignInButtonPress() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  func presentToMain() {
    let homeVC = HomeViewController()
    homeVC.modalPresentationStyle = .overFullScreen
    self.present(homeVC, animated: true) {
      //      UserDefaults.standard.set(false, forKey: Const.UserDefaultsKey.isOnboarding)
    }
  }
}

// MARK: - Extension AppleSignIn
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
  
  // Apple ID 연동 성공 시
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
      //      Apple ID
    case let appleIDCredential as ASAuthorizationAppleIDCredential:
      let userToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) ?? ""
      let userIdentifier = appleIDCredential.user
        loginWithAPI(loginRequest: LoginRequest(token: userToken, social: "apple", idKey: userIdentifier))
      //      postUserSignUpWithAPI(request: userIdentifier)
      //      UserDefaults.standard.set(true, forKey: Const.UserDefaultsKey.isAppleLogin)
      //      UserDefaults.standard.set(false, forKey: Const.UserDefaultsKey.isKakaoLogin)
      
    default:
      break
    }
  }
  
  // Apple ID 연동 실패 시
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
  }
}

// MARK: - Network
extension LoginViewController {
    func loginWithAPI(loginRequest: LoginRequest) {
        UserAPI.shared.login(loginRequest: loginRequest) { response in
            switch response {
            case .success(let loginData):
                if let userData = loginData as? LoginResponse {
                    print("loginWithAPI - success")
//                    UserDefaults.standard.set(userData.user.userID, forKey: Const.UserDefaultsKey.userID)
//                    UserDefaults.standard.set(userData.user.token.accessToken, forKey: Const.UserDefaultsKey.accessToken)
//                    UserDefaults.standard.set(userData.user.token.refreshToken, forKey: Const.UserDefaultsKey.refreshToken)
                    self.presentToMain()
                }
            case .requestErr(let message):
                print("loginWithAPI - requestErr: \(message)")
            case .pathErr:
                print("loginWithAPI - pathErr")
            case .serverErr:
                print("loginWithAPI - serverErr")
            case .networkFail:
                print("loginWithAPI - networkFail")
            }
        }
    }
}
