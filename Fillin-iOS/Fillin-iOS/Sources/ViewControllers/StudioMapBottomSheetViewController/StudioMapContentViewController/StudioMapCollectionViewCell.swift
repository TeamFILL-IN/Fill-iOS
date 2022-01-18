//
//  StudioMapCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/18.
//

import UIKit

class StudioMapCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  var photoReviewImageView = UIImageView() {
    didSet {
      self.photoReviewImageView.contentMode = .scaleAspectFit
    }
  }
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
  }
}

// MARK: - Extensions
extension StudioMapCollectionViewCell {
  
  func layout() {
    layoutMyPagePhotoImageView()
    self.backgroundColor = .black
  }
  
  func layoutMyPagePhotoImageView() {
    self.contentView.add(photoReviewImageView) {
      $0.image = Asset.iosPhotoRectangle.image
      $0.snp.makeConstraints {
        $0.top.leading.trailing.bottom.equalTo(self.contentView)
      }
    }
  }
}
