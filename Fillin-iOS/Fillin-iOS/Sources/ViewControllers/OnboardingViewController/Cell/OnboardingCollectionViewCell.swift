//
//  OnboardingCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/03/01.
//

import UIKit

import SnapKit

// MARK: - OnboardingCollectionViewCell
class OnboardingCollectionViewCell: UICollectionViewCell {
  static let cellId = String(describing: OnboardingCollectionViewCell.self)
  
  let imageName: String = ""
  let onboardingView = UIImageView()
  let onboardingTitleLabel = UILabel()
  let onboardingDescriptionLabel = UILabel()
  
  // MARK: - Life Cycles
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = .fillinBlack
    layout()
  }
  // MARK: - Custom Functions
  func setOnboardingSlides(_ slides: OnboardingDataModel) {
    onboardingTitleLabel.text = slides.title
    onboardingDescriptionLabel.text = slides.description
    setOnboardingImage(slides.imageName)
  }
  private func setOnboardingImage(_ onboardingImageName: String) {
    onboardingView.contentMode = .scaleAspectFit
    onboardingView.image = UIImage(named: onboardingImageName)
  }
}
extension OnboardingCollectionViewCell {
  func layout() {
    layoutOnboardingTitleLabel()
    layoutOnboardingDescriptionLabel()
    layoutOnboardingView()
  }
  func layoutOnboardingTitleLabel() {
    self.contentView.add(onboardingTitleLabel) {
      $0.setupLabel(text: "일단 뭐라도 적는다", color: .grey1, font: .body2, align: .left)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView.snp.top)
        $0.leading.equalTo(self.contentView.snp.leading).offset(28)
      }
    }
  }
  func layoutOnboardingDescriptionLabel() {
    self.contentView.add(onboardingDescriptionLabel) {
      $0.setupLabel(text: "일단 뭐라도 적는다\n오예", color: .fillinWhite, font: .display1, align: .left)
      $0.textAlignment = .left
      $0.numberOfLines = 2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.onboardingTitleLabel.snp.bottom).offset(18)
        $0.leading.equalTo(self.onboardingTitleLabel.snp.leading)
      }
    }
  }
  func layoutOnboardingView() {
    self.contentView.add(onboardingView) {
      $0.image = Asset.intro1.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.onboardingDescriptionLabel.snp.bottom).offset(67)
        $0.centerX.equalTo(self.contentView.snp.centerX)
        $0.width.equalTo(self.contentView.snp.width)
      }
    }
  }
}
