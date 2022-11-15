//
//  TermTableViewCell.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/09/01.
//

import UIKit

import SnapKit
import Then

// MARK: - TermTableViewCell
class TermTableViewCell: UITableViewCell {
  
  static let identifier = "TermTableViewCell"
  
  // MARK: - Component
  let termExplainLabel = UILabel()
  let termmoveIcon = UIButton()
  let divideLine = UIView()
  
  // MARK: - LifeCycle
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = .clear
    layout()
    setUI()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
extension TermTableViewCell {
  func layout() {
    layoutTermExplainLabel()
    layoutTermMoveIcon()
    layoutDivideLine()
  }
  func layoutTermExplainLabel() {
    self.contentView.add(termExplainLabel) {
      $0.textColor = .white
      $0.font = .body3
      $0.snp.makeConstraints { make in
        make.centerY.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutTermMoveIcon() {
    self.contentView.add(termmoveIcon) {
      $0.setImage(UIImage(asset: Asset.btnOpen), for: .normal)
      $0.snp.makeConstraints { make in
        make.centerY.equalTo(self.termExplainLabel)
        make.trailing.equalToSuperview().offset(-18)
        make.height.equalTo(24)
        make.width.equalTo(24)
      }
    }
  }
  func layoutDivideLine() {
    self.contentView.add(divideLine) {
      $0.backgroundColor = UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.termExplainLabel.snp.bottom).offset(18)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(1)
      }
    }
  }
  func setUI() {
    self.contentView.backgroundColor = .fillinBlack
  }
}
