//
//  StudioMapSearchTableViewCell.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/16.
//

import UIKit

class StudioMapSearchTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  let icon = UIImageView()
  let nameStudioLabel = UILabel()
  let locationStudionLabel = UILabel()
  let cellDividerView = UIView()
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - Func
  func layoutContents() {
    contentView.add(icon) {
      $0.image = Asset.icnPlaceSmall.image
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView).offset(18)
        $0.leading.equalTo(self.contentView).offset(18)
        $0.height.equalTo(22)
        $0.width.equalTo(22)
      }
    }
    contentView.add(nameStudioLabel) {
      $0.font = .subhead3
      $0.textColor = .white
      $0.text = "필린 사진관"
      $0.snp.makeConstraints {
        $0.top.equalTo(self.contentView).offset(18)
        $0.leading.equalTo(self.icon.snp.trailing).offset(7)
      }
    }
    contentView.add(locationStudionLabel) {
      $0.font = .body1
      $0.textColor = .grey1
      $0.text = "서울특별시 영등포구 여의도동 21-3 에이틴나인틴트웬티트웬티티티티티티"
      $0.snp.makeConstraints {
        $0.top.equalTo(self.nameStudioLabel.snp.bottom).offset(7)
        $0.leading.equalTo(self.nameStudioLabel.snp.leading)
        $0.trailing.equalTo(self.contentView).offset(-30)
      }
    }
    contentView.add(cellDividerView) {
      $0.backgroundColor = .darkGrey1
      $0.snp.makeConstraints {
        $0.height.equalTo(1)
        $0.leading.trailing.equalTo(self.contentView)
        $0.bottom.equalTo(self.contentView)
      }
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    layoutContents()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
