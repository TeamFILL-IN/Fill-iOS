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
class MyPageViewController: UIViewController, ConstraintRelatableTarget {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let mypageScrollview = UIScrollView()
  let mypageScrollContainverView = UIView()
  //  let navigationBar : UIView = {
  //    let view = FilinNavigationBar()
  //    return view
  //  }()
  let userImageview = UIImageView()
  let userNameLabel = UILabel()
  let userCameraIcon = UIButton()
  let userCameraLabel = UILabel()
  let usereditIcon = UIButton()
  let orangeBackgroundview = UIView()
  let noticeexplainLabel = UILabel()
  let gotonoticepageButton = UIButton()
  let graylineView = UIView()
  let myphotosLabel = UILabel()
  let myphotoCollectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.isScrollEnabled = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    register()
    layout()
    self.myphotoCollectionview.delegate = self
    self.myphotoCollectionview.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    /// subview들이 자리 잡은 후 레이아웃 조정 필요할 때 (ex. radius 값)
    self.userImageview.layer.cornerRadius = self.userImageview.frame.width/2
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
    layoutOrangeBackgroundView()
    layoutNoticeExplainLabel()
    layoutGotoNoticePageButton()
    layoutGrayLineView()
    layoutMyphotosLabel()
    layoutMyPhotoCollectionView()
  }
  func layoutNavigaionBar() {
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
  func layoutMyPageScrollView() {
    view.add(mypageScrollview) {
      $0.backgroundColor = .fillinBlack
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.isScrollEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.navigationBar.snp.bottom)
        $0.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutMyPageScrollContainerView() {
    mypageScrollview.add(mypageScrollContainverView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .fillinBlack
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints {
        $0.centerX.top.leading.equalToSuperview()
        $0.bottom.equalTo(self.mypageScrollview.snp.bottom)
        $0.height.equalTo((UIScreen.main.bounds.height*(249/812)+10*(UIScreen.main.bounds.width-36)/3 + 9) - 9)
      }
    }
  }
  func layoutUserImageView() {
    mypageScrollContainverView.add(userImageview) {
      $0.image = Asset.profile.image
      //      $0.backgroundColor = .white
      $0.snp.makeConstraints {
        $0.top.equalTo(self.mypageScrollContainverView.snp.top).offset(14)
        $0.leading.equalToSuperview().offset(18)
        $0.width.equalTo(55)
        $0.height.equalTo(55)
      }
    }
  }
  func layoutUserNameLabel() {
    mypageScrollContainverView.add(userNameLabel) {
      $0.setupLabel(text: "찰칵찰칵 필린이",
                    color: .fillinWhite,
                    font: .headline)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.mypageScrollContainverView.snp.top).offset(14)
        $0.leading.equalTo(self.userImageview.snp.trailing).offset(12)
      }
    }
  }
  func layoutUserCameraIcon() {
    mypageScrollContainverView.add(userCameraIcon) {
      $0.setImage(UIImage(asset: Asset.icnCamera), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.userNameLabel.snp.bottom).offset(6)
        $0.leading.equalTo(self.userNameLabel.snp.leading)
        $0.width.equalTo(18)
        $0.height.equalTo(18)
      }
    }
  }
  func layoutUserCameraLabel() {
    mypageScrollContainverView.add(userCameraLabel) {
      $0.setupLabel(text: "Fuji film X-T200",
                    color: .systemGray3,
                    font: .engDisplay2Book)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.userNameLabel.snp.bottom).offset(5)
        $0.leading.equalTo(self.userCameraIcon.snp.trailing).offset(7)
      }
    }
  }
  func layoutUserEditIcon() {
    mypageScrollContainverView.add(usereditIcon) {
      $0.setImage(UIImage(asset: Asset.icnEdit), for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.userNameLabel.snp.top)
        $0.trailing.equalToSuperview().offset(-18)
        $0.width.equalTo(24)
        $0.height.equalTo(24)
      }
    }
  }
  func layoutOrangeBackgroundView() {
    mypageScrollContainverView.add(orangeBackgroundview) {
      $0.backgroundColor = .fillinRed
      $0.layer.cornerRadius = 5
      $0.snp.makeConstraints {
        $0.top.equalTo(self.userCameraLabel.snp.bottom).offset(28)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.height.equalTo(80)
      }
    }
  }
  func layoutNoticeExplainLabel() {
    orangeBackgroundview.add(noticeexplainLabel) {
      $0.setupLabel(text: "나만 아는 필름과 현상소를\n필린에 알려주세요!",
                    color: .fillinBlack,
                    font: .body2)
      /// 필린에 알려주세요만 굵은 글씨로 변경하기
      let attributedStr = NSMutableAttributedString(string: self.noticeexplainLabel.text ?? "")
      attributedStr.addAttribute(.font, value: UIFont.subhead3, range: (self.noticeexplainLabel.text! as NSString).range(of: "필린에 알려주세요!"))
      self.noticeexplainLabel.attributedText = attributedStr
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.leading.equalToSuperview().offset(24)
      }
    }
  }
  func layoutGotoNoticePageButton() {
    orangeBackgroundview.add(gotonoticepageButton) {
      $0.setImage(UIImage(asset: Asset.icnGo), for: .normal)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalToSuperview().offset(-16)
      }
    }
  }
  func layoutGrayLineView() {
    mypageScrollContainverView.add(graylineView) {
      $0.backgroundColor = .darkGrey2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.orangeBackgroundview.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
        $0.width.equalToSuperview()
        $0.height.equalTo(2)
      }
    }
  }
  func layoutMyphotosLabel() {
    mypageScrollContainverView.add(myphotosLabel) {
      $0.setupLabel(text: "MY PHOTOS",
                    color: .fillinWhite,
                    font: .engHead)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.graylineView.snp.bottom).offset(22)
        $0.leading.equalToSuperview().offset(19)
      }
    }
  }
  func layoutMyPhotoCollectionView() {
    mypageScrollContainverView.add(myphotoCollectionview) {
      $0.backgroundColor = .orange
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.myphotosLabel.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.bottom.equalTo(self.mypageScrollContainverView.snp.bottom)
      }
    }
  }
}
// MARK: - UICollectionView
extension MyPageViewController : UICollectionViewDelegate {
  
}

extension MyPageViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let myphotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPagePhotoCollectionViewCell.identifier, for: indexPath) as? MyPagePhotoCollectionViewCell else {return UICollectionViewCell() }
    myphotoCell.awakeFromNib()
    return myphotoCell
  }
}

extension MyPageViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width-18)/3
    let cellHeight = (collectionView.frame.width-18)/3
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewzLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 9
  }
}
