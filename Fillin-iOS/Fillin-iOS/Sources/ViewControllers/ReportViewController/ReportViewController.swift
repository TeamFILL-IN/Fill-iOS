//
//  ReportViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/09/07.
//

import UIKit

import SnapKit
import Then

// MARK: - ReportViewController
class ReportViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let titleLabel = UILabel()
  let subtitleLabel = UILabel()
  let containerView = UIView()
  let filmreportView = UIView()
  let filmreportContainerView = UIView()
  let filmreportImage = UIImageView()
  let filmreportLabel = UILabel()
  let shopreportView = UIView()
  let shopreportContainerView = UIView()
  let shopreportImage = UIImageView()
  let shopreportLabel = UILabel()
  let extrareportButton = UIButton()
  let extrareportIcon = UIButton()
  let underlineView = UIView()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    filmTapRecognizer()
    labTapRecognizer()
  }
}
// MARK: - Extension
extension ReportViewController {
  func layout() {
    layoutNavigaionBar()
    layoutTitleLabel()
    layoutSubTitleLabel()
    layoutContainerView()
    layoutFilmReportView()
    layoutFilmReportContainerView()
    layoutFilmReportImage()
    layoutFilmReportLabel()
    layoutShopReportView()
    layoutShopReportContainerView()
    layoutShopReportImage()
    layoutShopReportLabel()
    layoutExtraReportButton()
    layoutExtraReportIcon()
    layoutUnderLineView()
  }
  func layoutNavigaionBar() {
    self.view.add(navigationBar) {
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
  func layoutTitleLabel() {
    self.view.add(titleLabel) {
      $0.setupLabel(text: "필린은 언제나 열려있어요!",
                    color: .fillinWhite,
                    font: .headline)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.navigationBar.snp.bottom).offset(24)
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutSubTitleLabel() {
    self.view.add(subtitleLabel) {
      $0.textAlignment = .left
      $0.numberOfLines = 3
      $0.setupLabel(text: "찰칵찰칵 필린이님만 아는 필름, 현상소 정보가 있다면\n필린에게도 제보해주세요!\n필린님의 소중한 제보가 필린을 성장하게 합니다.",
                    color: .grey1,
                    font: .body2)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.titleLabel.snp.bottom).offset(14)
        make.leading.equalTo(self.titleLabel)
      }
    }
  }
  func layoutContainerView() {
    self.view.add(containerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.subtitleLabel.snp.bottom).offset(35)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(86)
      }
    }
  }
  func layoutFilmReportView() {
    self.containerView.add(filmreportView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints { make in
        make.top.leading.bottom.equalToSuperview()
        make.width.equalTo((UIScreen.main.bounds.width-45)/2)
      }
    }
  }
  func layoutFilmReportContainerView() {
    self.filmreportView.add(filmreportContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints { make in
        make.centerX.centerY.equalToSuperview()
        make.width.equalTo(97)
        make.height.equalTo(26)
      }
    }
  }
  func layoutFilmReportImage() {
    self.filmreportContainerView.add(filmreportImage) {
      $0.image = Asset.icnFilmRoll.image
      $0.snp.makeConstraints { make in
        make.top.leading.bottom.equalToSuperview()
        make.width.height.equalTo(24)
      }
    }
  }
  func layoutFilmReportLabel() {
    self.filmreportContainerView.add(filmreportLabel) {
      $0.setupLabel(text: "필름 제보",
                    color: .fillinWhite,
                    font: .body3)
      $0.snp.makeConstraints { make in
        make.top.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutShopReportView() {
    self.containerView.add(shopreportView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints { make in
        make.top.trailing.bottom.equalToSuperview()
        make.width.equalTo((UIScreen.main.bounds.width-45)/2)
      }
    }
  }
  func layoutShopReportContainerView() {
    self.shopreportView.add(shopreportContainerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints { make in
        make.centerX.centerY.equalToSuperview()
        make.width.equalTo(112)
        make.height.equalTo(26)
      }
    }
  }
  func layoutShopReportImage() {
    self.shopreportContainerView.add(shopreportImage) {
      $0.image = Asset.icnMap.image
      $0.snp.makeConstraints { make in
        make.top.leading.bottom.equalToSuperview()
        make.width.height.equalTo(24)
      }
    }
  }
  func layoutShopReportLabel() {
    self.shopreportContainerView.add(shopreportLabel) {
      $0.setupLabel(text: "현상소 제보",
                    color: .fillinWhite,
                    font: .body3)
      $0.snp.makeConstraints { make in
        make.top.trailing.bottom.equalToSuperview()
      }
    }
  }
  func layoutExtraReportButton() {
    self.view.add(extrareportButton) {
      $0.setupButton(title: "기타 문의/건의", color: .grey2, font: .body1, backgroundColor: .clear, state: .normal, radius: 0)
      $0.addTarget(self, action: #selector(self.extraReportButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.containerView.snp.bottom).offset(18)
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutExtraReportIcon() {
    self.view.add(extrareportIcon) {
      $0.setImage(UIImage(asset: Asset.goRightIcon),
                  for: .normal)
      $0.snp.makeConstraints { make in
        make.centerY.equalTo(self.extrareportButton).offset(1)
        make.leading.equalTo(self.extrareportButton.snp.trailing).offset(2)
        make.width.height.equalTo(13)
      }
    }
  }
  func layoutUnderLineView() {
    self.view.add(underlineView) {
      $0.backgroundColor = .grey3
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.extrareportButton.snp.bottom).offset(1)
        make.leading.equalToSuperview().offset(18)
        make.width.equalTo(88)
        make.height.equalTo(1)
      }
    }
  }
  func filmTapRecognizer() {
    // 필름제보 탭 클릭 시
    let filmTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleFilmTap))
    filmTapRecognizer.numberOfTapsRequired = 1
    filmTapRecognizer.isEnabled = true
    filmTapRecognizer.cancelsTouchesInView = false
    self.filmreportView.addGestureRecognizer(filmTapRecognizer)
  }
  func labTapRecognizer() {
    // 현상소 제보 탭 클릭 시
    let labTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleLabTap))
    labTapRecognizer.numberOfTapsRequired = 1
    labTapRecognizer.isEnabled = true
    labTapRecognizer.cancelsTouchesInView = false
    self.shopreportView.addGestureRecognizer(labTapRecognizer)
  }
  @objc func handleFilmTap() {
    self.navigationController?.pushViewController(ReportFilmViewController(), animated: false)
  }
  @objc func handleLabTap() {
    self.navigationController?.pushViewController(ReportlabViewController(), animated: false)
  }
  @objc func extraReportButtonClicked() {
    self.navigationController?.pushViewController(ReportContactViewController(), animated: false)
  }
}
