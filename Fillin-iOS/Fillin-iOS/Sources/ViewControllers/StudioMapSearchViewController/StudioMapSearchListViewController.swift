//
//  StudioMapSearchListViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/14.
//

import UIKit

class StudioMapSearchListViewController: UIViewController {

  // MARK: - Properties
  //private let searchBar = UISearchBar()
  private let categoryView = UIView()
  private let categoryButton = UIButton()
  private let searchResultTV = UITableView()
  
  let navigationBar = FilinNavigationBar()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    //setSearchResultTV()
    setNavigationBar()
    layoutNavigaionBar()
    //setSearchBar()            
  }

//  func setSearchResultTV() {
//    searchResultTV.delegate = self
//    searchResultTV.dataSource = self
//  }
//
//  func setSearchBar() {
//    searchBar.delegate = self
//    searchBar.barTintColor = .grey1
//    searchBar.layer.borderColor = UIColor.fillinRed.cgColor
//    searchBar.layer.borderWidth = 1
//    //searchBar.setImage(Asset.icnSearch.image, for: .normal))
//    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
//      textfield.backgroundColor = .darkGrey2
//      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "추억을 현상할 현상소를 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.grey1])
//      //서치바 텍스트입력시 색 정하기
//      textfield.textColor = .fillinWhite
//
//      if let leftView = textfield.leftView as? UIImageView {
//        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
//      }
//      searchBar.backgroundImage = UIImage()
//    }
//  }
  
  @objc func dismissScreen() {
    self.dismiss(animated: true, completion: nil)
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // 커스텀 네비게이션 탭바
  func setNavigationBar() {
    navigationBar.popViewController = { self.navigationController?.popViewController(animated: true) }
  }
  
  func layoutNavigaionBar() {
    view.add(navigationBar) {
      self.navigationBar.popViewController = {
        self.navigationController?.popViewController(animated: true)
      }
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
  }
}

