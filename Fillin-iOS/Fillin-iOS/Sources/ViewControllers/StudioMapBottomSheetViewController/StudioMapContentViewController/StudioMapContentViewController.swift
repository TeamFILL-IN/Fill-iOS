//
//  StudioMapContentViewController.swift
//  Pods
//
//  Created by 임주민 on 2022/01/17.
//

import UIKit

class StudioMapContentViewController: UIViewController {
  
  // MARK: - Properties
  var serverStudioInfo: StudioInfoResponse?
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
    collectionView.isScrollEnabled = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttribute()
    setupUI()
    register()
    studioInfoWithAPI()
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
        $0.height.equalTo((UIScreen.main.bounds.height*(500/812)+10*(UIScreen.main.bounds.width-36)/3 + 9) - 9)
      }
    }
    
    // label
    studioScrollContainverView.add(studioLabel) {
      
      print(self.serverStudioInfo?.studio.name ?? "none data")
      $0.text = self.serverStudioInfo?.studio.name
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
        $0.height.equalTo(1)
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
        $0.top.equalTo(self.locationImageView.snp.bottom).offset(52)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(callImageView) {
      $0.image = Asset.icnCall.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.timeImageView.snp.bottom).offset(96)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(priceImageView) {
      $0.image = Asset.icnPrice.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.callImageView.snp.bottom).offset(18)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    studioScrollContainverView.add(linkImageView) {
      $0.image = Asset.icnLink.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.priceImageView.snp.bottom).offset(62)
        $0.leading.equalTo(self.studioScrollContainverView.snp.leading).offset(18)
        $0.width.height.equalTo(22)
      }
    }
    
    // Label
    studioScrollContainverView.add(locationLabel) {
      $0.text = "서울특별시 영등포구 여의도동 21-3 가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가"
      $0.font = .body2
      $0.textColor = .grey1
      $0.numberOfLines = 0
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.studioLabel.snp.bottom).offset(25)
        $0.leading.equalTo(self.locationImageView.snp.trailing).offset(8)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(timeLabel) {
      $0.text = "매일 10:30 ~ 22:00 가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가가"
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.timeImageView.snp.top)
        $0.leading.equalTo(self.timeImageView.snp.trailing).offset(8)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(callLabel) {
      $0.text = "010-2929-2020"
      $0.numberOfLines = 0
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byCharWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.callImageView.snp.top)
        $0.leading.equalTo(self.callImageView.snp.trailing).offset(8)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(priceLabel) {
      $0.text = "컬러 스캔: 4,000원 가가가가가가가가가가가가가\n흑백 스캔: 5,000원 가가가가가가가가가가가가가\n4롤 스캔 시 10,000원 가가가가가가가가가가가가"
      $0.numberOfLines = 3
      $0.font = .body2
      $0.textColor = .grey1
      $0.lineBreakMode = .byWordWrapping
      $0.snp.makeConstraints {
        $0.top.equalTo(self.priceImageView.snp.top)
        $0.leading.equalTo(self.priceImageView.snp.trailing).offset(8)
        $0.trailing.equalTo(self.studioScrollContainverView.snp.trailing).offset(-25)
      }
    }
    studioScrollContainverView.add(linkButton) {
      $0.setTitle("웹사이트로 이동", for: .normal)
      $0.setTitleColor(.fillinRed, for: .normal)
      $0.titleLabel?.font =  .body1
      $0.snp.makeConstraints {
        $0.top.equalTo(self.priceImageView.snp.bottom).offset(62)
        $0.leading.equalTo(self.linkImageView.snp.trailing).offset(8)
        $0.height.equalTo(18)
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
        $0.height.equalTo(1)
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
      $0.isUserInteractionEnabled = true
      $0.snp.makeConstraints {
        $0.top.equalTo(self.photoReviewLabel.snp.bottom).offset(12)
        $0.centerX.equalToSuperview()
        $0.leading.equalToSuperview().offset(18)
        $0.bottom.equalTo(self.studioScrollContainverView.snp.bottom)
      }
    }
  }
}

// MARK: - Network
extension StudioMapContentViewController {
    func studioInfoWithAPI() {
      StudioMapAPI.shared.infoStudio { response in
            switch response {
            case .success(let data):
                if let studioinfo = data as? StudioInfoResponse {
                  self.serverStudioInfo = studioinfo
                }
            case .requestErr(let message):
                print("studioInfoWithAPI - requestErr: \(message)")
            case .pathErr:
                print("studioInfoWithAPI - pathErr")
            case .serverErr:
                print("studioInfoWithAPI - serverErr")
            case .networkFail:
                print("studioInfoWithAPI - networkFail")
            }
        }
    }
}
 
// MARK: - UICollectionView
extension StudioMapContentViewController: UICollectionViewDelegate {
  
}

extension StudioMapContentViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 30
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let myphotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: StudioMapCollectionViewCell.identifier, for: indexPath) as? StudioMapCollectionViewCell else {return UICollectionViewCell() }
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
