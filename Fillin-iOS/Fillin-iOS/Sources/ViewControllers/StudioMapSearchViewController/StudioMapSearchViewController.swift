//
//  StudioMapSearchViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/13.
//

import UIKit

class StudioMapSearchViewController: UIViewController {
  
  // MARK: - Properties
  let backGroundView = UIView()
  let magnifyingGlassButton = UIButton()
  let searchPlaceTextField = UITextField()
  let tableView = UITableView()
  let dividerView = UIView()
  let navigationBar = FilinNavigationBar()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSearchView()
    layoutNavigaionBar()
    layoutDividerView()
    makeTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setUpTextField()
  }
  
  // MARK: - Custom Func
  private func layoutSearchView() {
    view.add(backGroundView) {
      $0.backgroundColor = .darkGrey2
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide)
        $0.leading.equalTo(self.view)
        $0.bottom.equalTo(self.view)
        $0.trailing.equalTo(self.view)
      }
    }
    view.add(searchPlaceTextField) {
      $0.backgroundColor = .darkGrey2
      $0.layer.borderColor = UIColor.fillinRed.cgColor
      $0.layer.borderWidth = 1
      $0.textColor = .white
      $0.font = .body2
      $0.setPlaceHolder()
      $0.addLeftPadding()
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(68)
        $0.leading.equalTo(self.view).inset(18)
        $0.trailing.equalTo(self.view).inset(18)
        $0.size.height.equalTo(48)
      }
    }
    view.add(magnifyingGlassButton) {
      $0.setImage(Asset.icnSearch.image, for: .normal)
      $0.addTarget(self, action: #selector(self.touchSearchButton), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.top.equalTo(self.searchPlaceTextField).inset(11)
        $0.leading.equalTo(self.searchPlaceTextField).inset(295)
        $0.bottom.equalTo(self.searchPlaceTextField).inset(11)
        $0.trailing.equalTo(self.searchPlaceTextField).inset(18)
      }
    }
  }
  
  private func setUpTextField() {
    searchPlaceTextField.becomeFirstResponder()
  }
  
  private func layoutNavigaionBar() {
    view.add(navigationBar) {
      self.navigationBar.popViewController = {
        self.dismiss(animated: true, completion: nil)
      }
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
  }
  
  private func layoutDividerView() {
    view.add(dividerView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.searchPlaceTextField.snp.bottom).offset(18)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(2)
      }
    }
  }
  
  private func layoutTableView() {
    view.add(tableView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.dividerView.snp.bottom)
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
      }
    }
  }
  
  func makeTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    self.tableView.register(StudioMapSearchTableViewCell.self, forCellReuseIdentifier: "StudioSearchCell")
    self.tableView.showsVerticalScrollIndicator = false
    
    layoutTableView()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  @objc func touchSearchButton(_ sender: UIButton) {
  }
}

// MARK: - Extension - UITableViewDataSource, UITableViewDelegate
extension StudioMapSearchViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10 // 임시 값
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudioSearchCell", for: indexPath) as? StudioMapSearchTableViewCell else { return UITableViewCell() }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.clear
  }
}
