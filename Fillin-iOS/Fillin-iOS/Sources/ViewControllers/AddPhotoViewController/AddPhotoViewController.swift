//
//  AddPhotoViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

import SnapKit
import Then
import Photos

// MARK: - ADddPhotoViewController
class AddPhotoViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  var photobackgroundView = UIImageView()
  let photoIcon = UIButton()
  let filmLabel = UILabel()
  let filmchooseButton = UIButton()
  let studioLabel = UILabel()
  let studiochooseButton = UIButton()
  let addphotoBackground = UIView()
  let addphotoButton = UIButton()
  let imagePickerController = UIImagePickerController()
  
  var status: Status = .addPhotoVC
  
  var selectedId = 0
  var selectedFilm = ""
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    imagePickerController.delegate = self
    
    /// 이미지뷰에 액션을 넣어서 이미지 선택하면 다시 사진 선택할 수 있게
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.touchimageView))
    tapGestureRecognizer.isEnabled = true
    tapGestureRecognizer.numberOfTapsRequired = 1
    /// 이미지뷰는 터치가 원래 안되니까 터치 가능하도록
    self.photobackgroundView.isUserInteractionEnabled = true
    self.photobackgroundView.addGestureRecognizer(tapGestureRecognizer)
    layout()
    setNotification()
  }
  override func viewWillAppear(_ animated: Bool) {
    self.filmchooseButton.titleLabel?.text = selectedFilm
    
    // 이미지와 스튜디오가 있어야 버튼 활성화 되도록 분기처리
    if (self.photobackgroundView.image != Asset.photoInsert.image) && (self.filmchooseButton.titleLabel?.text != "어떤 필름을 사용했나요?") {
      self.addphotoBackground.backgroundColor = .fillinRed
    } else {
      self.addphotoBackground.backgroundColor = .grey3
    }
  }
}
// MARK: - Extension
extension AddPhotoViewController {
  func layout() {
    layoutNavigationBar()
    layoutPhotoBackgroundView()
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
      $0.image = UIImage(asset: Asset.photoInsert)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.navigationBar.snp.bottom)
        $0.centerX.equalToSuperview()
        $0.width.height.equalTo(self.view.frame.width)
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
      $0.addTarget(self, action: #selector(self.touchFilmChooseButton), for: .touchUpInside)
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
      $0.addTarget(self, action: #selector(self.touchStudioChooseButton), for: .touchUpInside)
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
      $0.backgroundColor = .grey3
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
      $0.addTarget(self, action: #selector(self.touchAddPhotoButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalToSuperview().offset(15)
        $0.centerX.equalToSuperview()
      }
    }
  }
  @objc func touchimageView() {
    switch PHPhotoLibrary.authorizationStatus() {
    case .denied:
      makeOKCancelAlert(title: "갤러리 권한이 허용되어 있지 않습니다.",
                              message: "필름 사진 이미지 저장을 위해 갤러리 권한이 필요합니다. 앱 설정으로 이동해 허용해 주세요.",
                              okAction: { _ in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)},
                              cancelAction: nil,
                              completion: nil)
      print("거절")
    case .restricted:
      break
    case .authorized:
      print("허가")
      self.imagePickerController.sourceType = .photoLibrary
      self.present(self.imagePickerController, animated: true, completion: nil)
    case .notDetermined:
      print("노 결정")
      
      PHPhotoLibrary.requestAuthorization({ state in
        DispatchQueue.main.async {
          if state == .authorized {
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
          } else {
            self.dismiss(animated: true, completion: nil)
          }
        }
      })
      
    default:
      break
    }
  }
  @objc func touchFilmChooseButton() {
    let filmSelectVC = FilmSelectViewController()
    filmSelectVC.status = .addPhotoVC
    self.navigationController?.pushViewController(filmSelectVC, animated: true)
  }
  @objc func touchStudioChooseButton() {
    let studioChooseVC = StudioMapSearchViewController()
    self.navigationController?.pushViewController(studioChooseVC, animated: true)
  }
  @objc func touchAddPhotoButton() {
    if self.addphotoBackground.backgroundColor == .fillinRed {
      addPhotosWithAPI(studioId: 6, filmId: selectedId, img: self.photobackgroundView.image ?? UIImage())
    } else {
    }
  }
  // MARK: - Notification
  private func setNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedFilmType), name: Notification.Name.pushToAddPhotoViewController, object: nil)
  }
  @objc func updateSelectedFilmType(_ notification: Notification) {
    let selectedFilmDict = notification.object as? NSDictionary
    selectedId = selectedFilmDict?["selectedId"] as? Int ?? 0
    selectedFilm = selectedFilmDict?["selectedFilm"] as? String ?? ""
    self.filmchooseButton.setTitle(selectedFilm, for: .normal)
  }
}

// MARK: - ImagePicker Extension
extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      photobackgroundView.image = image
      photobackgroundView.contentMode = .scaleAspectFit
      photoIcon.isHidden = true
    }
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - Network
extension AddPhotoViewController {
  func addPhotosWithAPI(studioId: Int, filmId: Int, img: UIImage) {
    AddPhotoAPI.shared.addPhotos(studioId: studioId, filmId: filmId, img: img) { response in
      switch response {
      case .success:
        let secondVC = SecondAddPhotoPopUpViewController()
        secondVC.modalPresentationStyle = .overCurrentContext
        secondVC.modalTransitionStyle = .crossDissolve
        self.present(secondVC, animated: false, completion: nil)
      case .requestErr(let message):
        print("addPhotosWithAPI - requestErr: \(message)")
      case .pathErr:
        print("addPhotosWithAPI - pathErr")
      case .serverErr:
        print("addPhotosWithAPI - serverErr")
      case .networkFail:
        print("addPhotosWithAPI - networkFail")
      }
    }
    
  }
}
