//
//  LikedStudiosCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2023/01/19.
//

import UIKit

import SnapKit
import Then

final class LikedStudiosCollectionViewCell: UICollectionViewCell {
  // MARK: - Property
  static let identifier = "LikedStudiosCollectionViewCell"
  
  // MARK: - UI Property
  private let markerImageView = UIImageView().then {
    $0.image = Asset.icnPlaceSmall.image
  }
  
  private let nameLabel = UILabel().then {
    $0.textColor = .white
    $0.font = .subhead3
  }
  
  private let addressLabel = UILabel().then {
    $0.textColor = .grey1
    $0.font = .body1
  }
  
  private let scrapButton = UIButton().then {
    $0.setImage(Asset.btnScrapActive.image, for: .normal)
  }
  
  private let borderLineView = UIView().then {
    $0.backgroundColor = .darkGrey1
  }
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Custom Method
  
  private func setLayout() {
    addSubviews([markerImageView, nameLabel, addressLabel, scrapButton, borderLineView])
    
    markerImageView.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(14)
      $0.width.height.equalTo(22)
    }
    
    nameLabel.snp.makeConstraints {
      $0.centerY.equalTo(markerImageView)
      $0.leading.equalTo(markerImageView.snp.trailing).offset(7)
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(7)
      $0.leading.equalTo(nameLabel.snp.leading)
      $0.trailing.equalTo(scrapButton.snp.leading).offset(-12)
    }
    
    scrapButton.snp.makeConstraints {
      $0.centerY.equalTo(markerImageView)
      $0.trailing.equalToSuperview().inset(16)
      $0.width.height.equalTo(32)
    }
    
    borderLineView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
  
  func setData(studioName: String, studioAddress: String) {
    nameLabel.text = studioName
    addressLabel.text = studioAddress
  }
}
