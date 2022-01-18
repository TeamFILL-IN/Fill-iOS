//
//  MyPagePhotoCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/01/13.
//

import UIKit

import SnapKit
import Then

// MARK: - MyPagePhotoCollectionViewCell
class MyPagePhotoCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Components
  var mypagePhotoImageView = UIImageView() {
    didSet {
      self.mypagePhotoImageView.contentMode = .scaleAspectFill
    }
  }
  
  // MARK: - LifeCycles
  override func awakeFromNib() {
    super.awakeFromNib()
    layout()
    self.backgroundColor = .darkGrey1
  }
}

// MARK: - Extensions
extension MyPagePhotoCollectionViewCell {
  func layout() {
    layoutMyPagePhotoImageView()
  }
  func layoutMyPagePhotoImageView() {
    self.contentView.add(mypagePhotoImageView) {
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading)
        $0.trailing.equalTo(self.contentView.snp.trailing)
        $0.bottom.equalTo(self.contentView.snp.bottom)
      }
    }
  }
}
