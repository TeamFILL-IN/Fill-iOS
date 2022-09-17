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
    setUI()
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
    tapRecognizer.numberOfTapsRequired = 1
    tapRecognizer.isEnabled = true
    tapRecognizer.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapRecognizer)
  }
}
// MARK: - Extension
extension ReportlabViewController {
  func layout() {
    layoutNavigaionBar()
    layoutTitleLabel()
    layoutReportTextView()
    layoutSendButton()
  }
  func setUI() {
    self.view.backgroundColor = .fillinBlack
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
      $0.backgroundColor = .textviewGrey
      $0.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
      $0.font = .body2
      $0.text = "찰칵찰칵 필린이님만 아는 현상소 정보가 있다면 필린에게도 제보해주세요! 필린님의 소중한 제보가 필린을 성장하게 합니다."
      $0.textColor = .grey2
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
      $0.setupButton(title: "보내기",
                     color: .grey4,
                     font: .headline,
                     backgroundColor: .textviewGrey,
                     state: .normal,
                     radius: 0)
      $0.isUserInteractionEnabled = false
      $0.addTarget(self, action: #selector(self.sendButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints { make in
        make.centerX.equalToSuperview()
        make.leading.trailing.equalToSuperview()
        make.bottom.equalToSuperview()
        make.height.equalTo(80)
      }
    }
  }
  @objc func handleTap() {
    reportTextView.resignFirstResponder()
  }
  @objc func sendButtonClicked() {
  }
}
extension ReportlabViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.grey2 {
      textView.text = nil
      textView.textColor = UIColor.fillinWhite
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "찰칵찰칵 필린이님만 아는 필름 정보가 있다면 필린에게도 제보해주세요! 필린님의 소중한 제보가 필린을 성장하게 합니다."
      textView.textColor = UIColor.grey2
    } else {
      //TextView에 내용 있을 때 버튼 활성화
      sendButton.setupButton(title: "보내기",
                             color: .fillinBlack,
                             font: .headline,
                             backgroundColor: .fillinRed,
                             state: .normal,
                             radius: 0)
      sendButton.isUserInteractionEnabled = true
    }
  }
}
