//
//  StudioMapContentViewController.swift
//  Pods
//
//  Created by 임주민 on 2022/01/17.
//

import UIKit
import SafariServices

class StudioMapContentViewController: UIViewController {
  
  // MARK: - Properties
  var serverStudioPhotos: PhotosResponse?
  let studioScrollview = UIScrollView()
  let studioScrollContainverView = UIView()
  let studioLabel = UILabel()
  let scrapButton = UIButton()
  let firstdividerView = UIView()
  let seconddividerView = UIView()
  let locationImageView = UIImageView()
  let timeImageView = UIImageView()
  let callImageView = UIImageView()
  let priceImageView = UIImageView()
  let linkImageView = UIImageView()
  let locationLabel = UILabel()
  let timeLabel = UILabel()
  let callLabel = UILabel()
  let priceLabel = UILabel()
  let linkButton = UIButton()
  let photoReviewLabel = UILabel()
  let underlineView = UIView()
  let studioCollectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttribute()
    setupUI()
    register()
    studioPhotosWithAPI(studioID: StudioMapViewController.selectedMarkerID ?? 0)
  }
  
  // MARK: - Func
  func setupAttribute() {
    self.studioCollectionview.delegate = self
    self.studioCollectionview.dataSource = self
  }
  
  func register() {
    self.studioCollectionview.register(StudioMapCollectionViewCell.self, forCellWithReuseIdentifier: StudioMapCollectionViewCell.identifier)
  }
  
  func setupUI() {
    // 스크롤뷰
    view.add(studioScrollview) {
      $0.backgroundColor = .clear
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.showsVerticalScrollIndicator = false
      $0.isScrollEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.top).offset(29)
        $0.centerX.leading.trailing.bottom.equalToSuperview()
      }
    }
    studioScrollview.add(studioScrollContainverView) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = .clear
      $0.contentMode = .scaleToFill
      $0.snp.makeConstraints {
        $0.centerX.top.leading.equalToSuperview()
        $0.bottom.equalTo(self.studioScrollview.snp.bottom)
        $0.width.equalTo(self.view)
        $0.height.equalTo(self.view).priority(250)
      }
    }
    // Label
    studioScrollContainverView.add(studioLabel) {
      $0.text = StudioMapViewController.name
      $0.textColor = .white
      $0.font = .headline
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioScrollContainverView.snp.top)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(30)
      }
    }
    studioScrollContainverView.add(scrapButton) {
      $0.setImage(Asset.btnScrap.image, for: .normal)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioScrollContainverView.snp.top)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-18)
        $0.width.height.equalTo(32)
      }
    }
    studioScrollContainverView.add(firstdividerView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioLabel.snp.bottom).offset(12)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing)
        $0.height.equalTo(2)
      }
    }
    // Label
    studioScrollContainverView.add(locationLabel) {
      if StudioMapViewController.address == nil {
        $0.text = "등록된 주소가 없습니다."
      } else {
        $0.text = StudioMapViewController.address
      }
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioLabel.snp.bottom).offset(25)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(48)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(timeLabel) {
      if StudioMapViewController.time == nil {
        $0.text = "등록된 운영시간이 없습니다."
      } else {
        $0.text = StudioMapViewController.time
      }
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.locationLabel.snp.bottom).offset(8)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(48)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(callLabel) {
      if StudioMapViewController.tel == nil {
        $0.text = "등록된 전화번호가 없습니다."
      } else {
        $0.text = StudioMapViewController.tel
      }
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.timeLabel.snp.bottom).offset(8)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(48)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(priceLabel) {
      if StudioMapViewController.price == nil {
        $0.text = "등록된 가격정보가 없습니다."
      } else {
        $0.text = StudioMapViewController.price
      }
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byWordWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.callLabel.snp.bottom).offset(18)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(48)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(linkButton) {
      $0.setTitle("웹사이트로 이동", for: .normal)
      $0.setTitleColor(.fillinRed, for: .normal)
      $0.titleLabel?.font =  .body1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.priceLabel.snp.bottom).offset(18)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(48)
        $0.height.equalTo(18)
      }
      if StudioMapViewController.site == nil {
        print("등록된 사이트 없음")
        self.linkButton.addTarget(self, action: #selector(self.touchNoSiteLinkButton), for: .touchUpInside)
      } else {
        self.linkButton.addTarget(self, action: #selector(self.touchLinkButton), for: .touchUpInside)
      }
    }
    // 아이콘
    studioScrollContainverView.add(locationImageView) {
      $0.image = Asset.icnPlaceSmall.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioLabel.snp.bottom).offset(25)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(timeImageView) {
      $0.image = Asset.icnTime.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.timeLabel.snp.top)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(callImageView) {
      $0.image = Asset.icnCall.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.callLabel.snp.top)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(priceImageView) {
      $0.image = Asset.icnPrice.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.priceLabel.snp.top)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(linkImageView) {
      $0.image = Asset.icnLink.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.linkButton.snp.top)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    
    studioScrollContainverView.add(underlineView) {
      $0.backgroundColor = .fillinRed
      $0.snp.makeConstraints {
        $0.top.equalTo(self.linkButton.snp.bottom).offset(2.5)
        $0.leading.equalTo(self.linkButton.snp.leading)
        $0.width.equalTo(80)
        $0.height.equalTo(1)
      }
    }
    studioScrollContainverView.add(seconddividerView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.underlineView.snp.bottom).offset(18.5)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing)
        $0.height.equalTo(3)
      }
    }
    studioScrollContainverView.add(photoReviewLabel) {
      $0.text = "PHOTO REVIEW"
      $0.textColor = .fillinWhite
      $0.font = .engHead
      $0.snp.makeConstraints {
        $0.top.equalTo(self.seconddividerView.snp.bottom).offset(24)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(19)
      }
    }
    // 컬렉션뷰
    studioScrollContainverView.add(studioCollectionview) {
      $0.backgroundColor = .clear
      $0.isUserInteractionEnabled = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photoReviewLabel.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.bottom.equalTo(self.studioScrollContainverView.snp.bottom)
      }
    }
  }
  
  // MARK: - @objc
  @objc func touchLinkButton() {
    let studioUrl = NSURL(string: StudioMapViewController.site ?? "none site")
    let studioSafariView: SFSafariViewController = SFSafariViewController(url: studioUrl! as URL)
    self.present(studioSafariView, animated: true, completion: nil)
  }
  
  @objc func touchNoSiteLinkButton() {
    let alert = UIAlertController(title: "사이트 미등록", message: "해당 현상소의 등록된 사이트가 없습니다.", preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: false, completion: nil)
  }
}

// MARK: - UICollectionView
extension StudioMapContentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return serverStudioPhotos?.photos.count ?? 0
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let myphotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: StudioMapCollectionViewCell.identifier, for: indexPath) as? StudioMapCollectionViewCell else {return UICollectionViewCell() }
    myphotoCell.photoReviewImageView.updateServerImage(serverStudioPhotos?.photos[indexPath.row].imageURL ?? "")
    myphotoCell.awakeFromNib()
    return myphotoCell
  }
}

extension StudioMapContentViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = (collectionView.frame.width-18)/3
    let cellHeight = (collectionView.frame.width-18)/3
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets.zero
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 9
  }
}

extension StudioMapContentViewController: UICollectionViewDelegate {
  
}

extension StudioMapContentViewController {
  func studioPhotosWithAPI(studioID: Int) {
    StudioMapAPI.shared.photoStudio(studioID: studioID) { response in
      switch response {
      case .success(let data):
        if let photos = data as? PhotosResponse {
          self.serverStudioPhotos = photos
          self.studioCollectionview.reloadData()
        }
      case .requestErr(let message):
        print("studioPhotosWithAPI - requestErr: \(message)")
      case .pathErr:
        print("studioPhotosWithAPI - pathErr")
      case .serverErr:
        print("studioPhotosWithAPI - serverErr")
      case .networkFail:
        print("studioPhotosWithAPI - networkFail")
      }
    }
  }
}
