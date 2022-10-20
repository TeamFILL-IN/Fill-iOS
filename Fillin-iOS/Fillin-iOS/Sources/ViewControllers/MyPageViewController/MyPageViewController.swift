//
//  MyPageViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

import SnapKit
import Then

// MARK: - MyPageViewController
class MyPageViewController: UIViewController {
  
  // MARK: - Properties
  let screenWidth = UIScreen.main.bounds.width - 36
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let mypageScrollview = UIScrollView()
  let mypageScrollContainverView = UIView()
  let userImageview = UIImageView()
  let userNameLabel = UILabel()
  let userCameraIcon = UIButton()
  let userCameraLabel = UILabel()
  let usereditIcon = UIButton()
  let optionStackView = UIStackView()
  let likeContainerView = UIView()
  let likeIcon = UIButton()
  let likeLabel = UILabel()
  let myplaceContainerView = UIView()
  let myplaceIcon = UIButton()
  let myplaceLabel = UILabel()
  let reportContainerView = UIView()
  let reportIcon = UIButton()
  let reportLabel = UILabel()
  let orangeBackgroundview = UIImageView()
  let noticeexplainLabel = UILabel()
  let noticesubExplainLabel = UILabel()
  let exitButton = UIButton()
  let firstgraylineView = UIView()
  let myphotosLabel = UILabel()
  let myphotosFoldButton = UIButton()
  let myphotoCollectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  let secondgrayLineView = UIView()
  let termsBackgroundview = UIView()
  let termsLabel = UILabel()
  let thirdgrayLineView = UIView()
  
  var serverNewPhotos: PhotosResponse?
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    register()
    layout()
    self.myphotoCollectionview.delegate = self
    self.myphotoCollectionview.dataSource = self
    userPhotosWithAPI()
  }
}

// MARK: - Extension
extension MyPageViewController {
  func register() {
    self.myphotoCollectionview.register(MyPagePhotoCollectionViewCell.self, forCellWithReuseIdentifier: MyPagePhotoCollectionViewCell.identifier)
  }
  func layout() {
    layoutNavigaionBar()
    layoutMyPageScrollView()
    layoutMyPageScrollContainerView()
    layoutUserImageView()
    layoutUserNameLabel()
    layoutUserCameraIcon()
    layoutUserCameraLabel()
    layoutUserEditIcon()
    layoutOptionStackView()
    layoutLikeContainerView()
    layoutLikeIcon()
    layoutLikeLabel()
    layoutMyPlaceContainerView()
    layoutMyPlaceIcon()
    layoutMyPlaceLabel()
    layoutReportContainerView()
    layoutReportIcon()
    layoutReportLabel()
    layoutOrangeBackgroundView()
    layoutNoticeExplainLabel()
    layoutNoticeSubExplainLabel()
    layoutExitButton()
    layoutFirstGrayLineView()
    layoutMyphotosLabel()
    layoutMyPhotosFoldButton()
    layoutMyPhotoCollectionView()
    layoutSecondGrayLine()
    layoutTermsBackgroundView()
    layoutTermsLabel()
    layoutThirdgraylineView()
  }
  func layoutNavigaionBar() {
    view.add(navigationBar) {
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
  func layoutMyPageScrollView() {
    view.add(mypageScrollview) {
      $0.backgroundColor = .fillinBlack
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.isScrollEnabled = true
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.navigationBar.snp.bottom)
        make.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutMyPageScrollContainerView() {
    mypageScrollview.add(mypageScrollContainverView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints { make in
        make.centerX.top.leading.equalToSuperview()
        make.bottom.equalTo(self.mypageScrollview.snp.bottom)
        make.width.equalTo(self.view)
        make.height.equalTo(self.view).priority(250)
      }
    }
  }
  func layoutUserImageView() {
    mypageScrollContainverView.add(userImageview) {
      $0.setBorder(borderColor: .fillinWhite, borderWidth: 1)
      $0.setRounded(radius: 27.5)
      $0.image = Asset.appleLogo.image
      $0.contentMode = .scaleAspectFill
      $0.clipsToBounds = true
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.mypageScrollContainverView.snp.top).offset(14)
        make.leading.equalToSuperview().offset(18)
        make.width.equalTo(55)
        make.height.equalTo(55)
      }
    }
  }
  func layoutUserNameLabel() {
    mypageScrollContainverView.add(userNameLabel) {
      $0.setupLabel(text: "찰칵찰칵 필린이",
                    color: .fillinWhite,
                    font: .headline)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.mypageScrollContainverView.snp.top).offset(14)
        make.leading.equalTo(self.userImageview.snp.trailing).offset(12)
      }
    }
  }
  func layoutUserCameraIcon() {
    mypageScrollContainverView.add(userCameraIcon) {
      $0.setImage(UIImage(asset: Asset.icnCamera), for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.userNameLabel.snp.bottom).offset(6)
        make.leading.equalTo(self.userNameLabel.snp.leading)
        make.width.equalTo(18)
        make.height.equalTo(18)
      }
    }
  }
  func layoutUserCameraLabel() {
    mypageScrollContainverView.add(userCameraLabel) {
      $0.setupLabel(text: "사용 중인 카메라를 입력해주세요.",
                    color: .grey4,
                    font: .body1)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
        make.leading.equalTo(self.userCameraIcon.snp.trailing).offset(7)
        make.centerY.equalTo(self.userCameraIcon)
      }
    }
  }
  func layoutUserEditIcon() {
    mypageScrollContainverView.add(usereditIcon) {
      $0.setImage(UIImage(asset: Asset.icnEdit), for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.userNameLabel.snp.top)
        make.trailing.equalToSuperview().offset(-18)
        make.width.equalTo(24)
        make.height.equalTo(24)
      }
    }
  }
  func layoutOptionStackView() {
    mypageScrollContainverView.add(optionStackView) {
      $0.axis = .horizontal
      $0.distribution = .fillEqually
      $0.alignment = .center
      $0.spacing = 0
      $0.backgroundColor = .fillinBlack
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.userCameraLabel.snp.bottom).offset(31)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(60)
      }
    }
  }
  func layoutLikeContainerView() {
    optionStackView.addArrangedSubview(likeContainerView)
    likeContainerView.backgroundColor = .fillinBlack
  }
  func layoutLikeIcon() {
    likeContainerView.add(likeIcon) {
      $0.setImage(Asset.imgHeart.image, for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(1)
        make.centerX.equalToSuperview()
        make.width.equalTo(30)
        make.height.equalTo(24)
      }
    }
  }
  func layoutLikeLabel() {
    likeContainerView.add(likeLabel) {
      $0.setupLabel(text: "좋아요",
                    color: .fillinWhite,
                    font: .body1)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.likeIcon.snp.bottom).offset(17)
        make.centerX.equalTo(self.likeIcon)
        make.bottom.equalToSuperview()
      }
    }
  }
  func layoutMyPlaceContainerView() {
    optionStackView.addArrangedSubview(myplaceContainerView)
    myplaceContainerView.backgroundColor = .fillinBlack
  }
  func layoutMyPlaceIcon() {
    myplaceContainerView.add(myplaceIcon) {
      $0.setImage(Asset.imgScrap.image, for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(1)
        make.centerX.equalToSuperview()
        make.width.equalTo(30)
        make.height.equalTo(24)
      }
    }
  }
  func layoutMyPlaceLabel() {
    myplaceContainerView.add(myplaceLabel) {
      $0.setupLabel(text: "내 현상소",
                    color: .fillinWhite,
                    font: .body1)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.myplaceIcon.snp.bottom).offset(16)
        make.centerX.equalTo(self.myplaceIcon)
        make.bottom.equalToSuperview()
      }
    }
  }
  func layoutReportContainerView() {
    optionStackView.addArrangedSubview(reportContainerView)
    reportContainerView.backgroundColor = .fillinBlack
  }
  func layoutReportIcon() {
    reportContainerView.add(reportIcon) {
      $0.setImage(Asset.icnFeedback.image, for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalToSuperview().offset(1)
        make.centerX.equalToSuperview()
        make.width.equalTo(30)
        make.height.equalTo(24)
      }
    }
  }
  func layoutReportLabel() {
    reportContainerView.add(reportLabel) {
      $0.setupLabel(text: "제보하기",
                    color: .fillinWhite,
                    font: .body1)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.reportIcon.snp.bottom).offset(16)
        make.centerX.equalTo(self.reportIcon)
        make.bottom.equalToSuperview()
      }
    }
  }
  func layoutOrangeBackgroundView() {
    mypageScrollContainverView.add(orangeBackgroundview) {
      $0.image = Asset.iosBanner.image
      $0.contentMode = .scaleAspectFill
      let tapGesture = UITapGestureRecognizer(target: self,
                                              action: #selector(self.orangeBackgroundViewClicked))
      $0.addGestureRecognizer(tapGesture)
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.optionStackView.snp.bottom).offset(12)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(110)
      }
    }
  }
  func layoutNoticeExplainLabel() {
    orangeBackgroundview.add(noticeexplainLabel) {
      $0.setupLabel(text: "나만 아는 필름과 현상소를",
                    color: .fillinBlack,
                    font: .body2)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.orangeBackgroundview).offset(39)
        make.leading.equalTo(self.orangeBackgroundview).offset(20)
      }
    }
  }
  func layoutNoticeSubExplainLabel() {
    orangeBackgroundview.add(noticesubExplainLabel) {
      $0.setupLabel(text: "필린에 알려주세요!",
                    color: .fillinBlack,
                    font: .subhead3)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.noticeexplainLabel.snp.bottom)
        make.leading.equalTo(self.noticeexplainLabel)
      }
    }
  }
  func layoutExitButton() {
    mypageScrollContainverView.add(exitButton) {
      $0.setImage(Asset.btExit.image, for: .normal)
      $0.addTarget(self, action: #selector(self.exitButtonClicked), for: .touchUpInside)
      $0.bringSubviewToFront(self.exitButton)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.orangeBackgroundview).offset(22)
        make.trailing.equalTo(self.orangeBackgroundview).offset(-8)
        make.width.height.equalTo(18)
      }
    }
  }
  func layoutFirstGrayLineView() {
    mypageScrollContainverView.add(firstgraylineView) {
      $0.backgroundColor = .darkGrey2
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.orangeBackgroundview.snp.bottom).offset(16)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview()
        make.height.equalTo(2)
      }
    }
  }
  func layoutMyphotosLabel() {
    mypageScrollContainverView.add(myphotosLabel) {
      $0.setupLabel(text: "MY PHOTOS",
                    color: .fillinWhite,
                    font: .engHead)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.firstgraylineView.snp.bottom).offset(22)
        make.leading.equalToSuperview().offset(19)
      }
    }
  }
  func layoutMyPhotosFoldButton() {
    mypageScrollContainverView.add(myphotosFoldButton) {
      $0.setImage(Asset.btnMyphoto.image, for: .normal)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.firstgraylineView.snp.bottom).offset(24)
        make.trailing.equalToSuperview().offset(-20)
        make.width.height.equalTo(22)
      }
    }
  }
  func layoutMyPhotoCollectionView() {
    mypageScrollContainverView.add(myphotoCollectionview) {
      $0.backgroundColor = .fillinRed
      $0.isUserInteractionEnabled = true
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.myphotosLabel.snp.bottom).offset(12)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        //TODO: Collectionview Height 조절해야함
      }
    }
  }
  func layoutSecondGrayLine() {
    mypageScrollContainverView.add(secondgrayLineView) {
      $0.backgroundColor = .darkGrey2
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.myphotoCollectionview.snp.bottom).offset(12)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview()
        make.height.equalTo(1)
      }
    }
  }
  func layoutTermsBackgroundView() {
    mypageScrollContainverView.add(termsBackgroundview) {
      $0.backgroundColor = .clear
      let tapGesture = UITapGestureRecognizer(target: self,
                                              action: #selector(self.termsClicked))
      $0.addGestureRecognizer(tapGesture)
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.secondgrayLineView.snp.bottom)
        make.leading.trailing.equalToSuperview()
        make.height.equalTo(60)
      }
    }
  }
  func layoutTermsLabel() {
    termsBackgroundview.add(termsLabel) {
      $0.setupLabel(text: "약관 및 정책",
                    color: .grey2,
                    font: .body3)
      $0.snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutThirdgraylineView() {
    mypageScrollContainverView.add(thirdgrayLineView) {
      $0.backgroundColor = .darkGrey2
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.termsBackgroundview.snp.bottom)
        make.centerX.equalToSuperview()
        make.width.equalToSuperview()
        make.height.equalTo(1)
        make.bottom.equalTo(self.mypageScrollContainverView.snp.bottom).offset(-121)
      }
    }
  }
  @objc func exitButtonClicked() {
    print("exitButtonClicked")
  }
  @objc func orangeBackgroundViewClicked(sender: UITapGestureRecognizer) {
    print("orangeorange")
  }
  @objc func termsClicked(sender: UITapGestureRecognizer) {
    print("temrsClicked")
  }
}
// MARK: - UICollectionView
extension MyPageViewController: UICollectionViewDelegate {
  
}

extension MyPageViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("룰루")
    return serverNewPhotos?.photos.count ?? 19
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let myphotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPagePhotoCollectionViewCell.identifier, for: indexPath) as? MyPagePhotoCollectionViewCell else {return UICollectionViewCell() }
    myphotoCell.mypagePhotoImageView.updateServerImage(serverNewPhotos?.photos[indexPath.row].imageURL ?? "")
    myphotoCell.awakeFromNib()
    return myphotoCell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let photoPopupVC = FilmRollClickViewController()
    photoPopupVC.modalTransitionStyle = .crossDissolve
    photoPopupVC.modalPresentationStyle = .overCurrentContext
    photoPopupVC.userprofile = serverNewPhotos?.photos[indexPath.row].userImageURL ?? ""
    photoPopupVC.username = serverNewPhotos?.photos[indexPath.row].nickname ?? ""
    photoPopupVC.filmname = serverNewPhotos?.photos[indexPath.row].filmName ?? ""
    photoPopupVC.photoImage = serverNewPhotos?.photos[indexPath.row].imageURL ?? ""
    photoPopupVC.likeCount = serverNewPhotos?.photos[indexPath.row].likeCount ?? 0
    self.present(photoPopupVC, animated: true, completion: nil)
  }
}

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width-18)/3
    let cellHeight = (collectionView.frame.width-18)/3
//    let viewHeight = (Int(cellHeight)*(serverNewPhotos?.photos.count ?? 0))+9*(serverNewPhotos?.photos.count ?? 0 - 1)
//    self.myphotoCollectionview.snp.remakeConstraints { make in
//      make.height.equalTo(0)
//    }
    return CGSize(width: cellWidth, height: cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 9
  }
}

// MARK: - Network
extension MyPageViewController {
  func userPhotosWithAPI() {
    MyPageAPI.shared.userPhotos { response in
      switch response {
      case .success(let data):
        if let photos = data as? PhotosResponse {
          // 마이페이지 사진 없을 시 분기처리
          if photos.photos.isEmpty == true {
            self.userImageview.updateServerImage("icnCall")
            self.userNameLabel.text = "수정해야damm~~"
          } else {
            self.userImageview.updateServerImage(photos.photos[0].userImageURL)
            self.userNameLabel.text = photos.photos[0].nickname
          }
          // /3을 하게 되면 1,2개일 때는 제대로 나오지 않기 때문에 소수점 올림 해주기
          let photosCount = ceil(Double(photos.photos.count)/3)
          let intPhotosCount = Int(photosCount)
          self.myphotoCollectionview.heightAnchor.constraint(equalToConstant: CGFloat((intPhotosCount*(Int(UIScreen.main.bounds.width)-36)/3 + 9))+90).isActive = true
          self.myphotoCollectionview.reloadData()
        }
      case .requestErr(let message):
        print("userPhotosWithAPI - requestErr: \(message)")
      case .pathErr:
        print("userPhotosWithAPI - pathErr")
      case .serverErr:
        print("userPhotosWithAPI - serverErr")
      case .networkFail:
        print("userPhotosWithAPI - networkFail")
      }
    }
  }
}
