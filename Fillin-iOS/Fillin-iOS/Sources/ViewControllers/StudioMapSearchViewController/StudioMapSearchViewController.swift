//
//  StudioMapSearchViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/13.
//

import UIKit

class StudioMapSearchViewController: UIViewController {
  
  // MARK: - Properties
  private let backGroundView = UIView().then {
    $0.backgroundColor = .darkGrey2
  }
  private let magnifyingGlassButton = UIButton().then {
    $0.setImage(Asset.icnSearch.image, for: .normal)
  }
  private let searchPlaceTextField = UITextField().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.borderColor = UIColor.fillinRed.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .white
    $0.font = .body2
    $0.setPlaceHolder()
    $0.addLeftPadding()
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSeachView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setUpTextField()
  }
  
  // MARK: - Custom Func
  private func layoutSeachView() {
    view.addSubview(backGroundView)
    view.addSubview(searchPlaceTextField)
    view.addSubview(magnifyingGlassButton)
    backGroundView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.leading.equalTo(self.view)
      $0.bottom.equalTo(self.view)
      $0.trailing.equalTo(self.view)
    }
    searchPlaceTextField.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(68)
      $0.leading.equalTo(self.view).inset(18)
      $0.trailing.equalTo(self.view).inset(18)
      $0.size.height.equalTo(48)
    }
    magnifyingGlassButton.snp.makeConstraints {
      $0.top.equalTo(searchPlaceTextField).inset(11)
      $0.leading.equalTo(searchPlaceTextField).inset(295)
      $0.bottom.equalTo(searchPlaceTextField).inset(11)
      $0.trailing.equalTo(searchPlaceTextField).inset(18)
    }
    magnifyingGlassButton.addTarget(self, action: #selector(touchSearchButton), for: .touchUpInside)
  }
  
  private func setUpTextField() {
    searchPlaceTextField.becomeFirstResponder()
  }
  
  @objc func touchSearchButton(_ sender: UIButton) {
  }
}