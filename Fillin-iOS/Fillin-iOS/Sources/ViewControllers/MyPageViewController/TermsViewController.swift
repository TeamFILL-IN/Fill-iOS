//
//  TermsViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/09/01.
//

import UIKit

import SnapKit
import Then

// MARK: - TermsViewController
class TermsViewController: UIViewController {
  
  // MARK: - Components
  let navigationBar = FilinNavigationBar()
  let termTableView = UITableView()
  let settingTitles = ["개인정보처리방침", "이용약관"]
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.termTableView.delegate = self
    self.termTableView.dataSource = self
    register()
    layout()
    setUI()
  }
}
extension TermsViewController {
  func register() {
    self.termTableView.register(TermTableViewCell.self, forCellReuseIdentifier: TermTableViewCell.identifier)
  }
  func layout() {
    layoutNavigaionBar()
    layoutTermTableView()
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
  func layoutTermTableView() {
    self.view.add(termTableView) {
      $0.separatorStyle = .none
      $0.snp.makeConstraints { make in
        make.top.equalTo(self.navigationBar.snp.bottom)
        make.leading.trailing.bottom.equalToSuperview()
      }
    }
  }
  func setUI() {
    self.view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
  }
  func openURL(link: URL) {
    if UIApplication.shared.canOpenURL(link) {
      UIApplication.shared.open(link, options: [:], completionHandler: nil)
    }
  }
}
// MARK: - TableViewDataSource
extension TermsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let termCell = tableView.dequeueReusableCell(withIdentifier: TermTableViewCell.identifier, for: indexPath) as? TermTableViewCell else {return UITableViewCell() }
    termCell.backgroundColor = .clear
    termCell.selectionStyle = . none
    termCell.termExplainLabel.text = settingTitles[indexPath.section]
    termCell.termExplainLabel.textColor = .fillinWhite
    termCell.awakeFromNib()
    
    return termCell
    
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      openURL(link: URL(string: Const.URL.infoTermURL)!)
    case 1:
      openURL(link: URL(string: Const.URL.useTermURL)!)
    default: print("default!")
    }
  }
}
// MARK: - TableViewDelegate
extension TermsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIScreen.main.bounds.size.height * (50/812)
  }
}
