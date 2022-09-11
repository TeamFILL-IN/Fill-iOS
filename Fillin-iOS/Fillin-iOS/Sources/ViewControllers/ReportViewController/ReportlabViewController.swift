//
//  ReportDetailViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/09/07.
//

import UIKit

import SnapKit
import Then

// MARK: - ReportDetailViewController
class ReportlabViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let titleLabel = UILabel()
  let reportTextView = UITextView()
  let sendButton = UIButton()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.reportTextView.delegate = self
    layout()
  }
}
// MARK: - Extension
extension ReportlabViewController {
  func layout() {
    
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
      $0.setupLabel(text: "현상소 제보",
                    color: .fillinWhite,
                    font: .subhead3)
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.navigationBar.snp.bottom).offset(24)
        make.leading.equalToSuperview().offset(18)
      }
    }
  }
  func layoutReportTextView() {
    self.view.add(reportTextView) {
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.backgroundColor = UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0)
      $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
      $0.font = .body2
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
        make.centerX.equalToSuperview()
        make.leading.equalToSuperview().offset(18)
        make.height.equalTo(185)
      }
    }
  }
  func layoutSendButton() {
    self.view.add(sendButton) {
      $0.setupButton(title: "보내기", color: .grey4, font: .headline, backgroundColor: UIColor(red: 29.0 / 255.0, green: 29.0 / 255.0, blue: 29.0 / 255.0, alpha: 1.0), state: .normal, radius: 0)
      $0.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.leading.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
        make.height.equalTo(80)
      }
    }
  }
}

extension ReportlabViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
  }
}
