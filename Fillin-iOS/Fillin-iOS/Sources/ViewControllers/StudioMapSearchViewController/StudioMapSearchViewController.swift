//
//  StudioMapSearchViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/13.
//

import UIKit

class StudioMapSearchViewController: UIViewController {
  
  // MARK: - Properties
  var searchBar: UISearchBar!
  //var filteredData: [Keepin?] = []
  var serverSearchStudios: StudioSearchResponse?
  let backGroundView = UIView()
  let magnifyingGlassButton = UIButton()
  let searchPlaceTextField = UITextField() // searchBar
  let tableView = UITableView()
  let dividerView = UIView()
  let navigationBar = FilinNavigationBar()
  let searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSearchView()
    layoutNavigaionBar()
    layoutDividerView()
    makeTableView()
    setupSearch()
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
  // searchBar
//  func setSearchBar(){
//    searchBar.delegate = self
//    searchBar.barTintColor = .white
//    searchBar.setImage(UIImage(named: "icSearch"), for: .search, state: .normal)
//    searchBar.autocapitalizationType = .none
//    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
//      //서치바 백그라운드 컬러
//      textfield.backgroundColor = .white
//      //플레이스홀더 글씨 색 정하기
//      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.keepinGray3])
//      //서치바 텍스트입력시 색 정하기
//      textfield.textColor = .black
//      
//      if let leftView = textfield.leftView as? UIImageView {
//        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
//        //이미지 틴트컬러 정하기
//        leftView.tintColor = UIColor.keepinGray3
//      }
//    }
//    searchBar.backgroundImage = UIImage()
//  }
  
  private func setUpTextField() {
    searchPlaceTextField.becomeFirstResponder()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  private func layoutNavigaionBar() {
    view.add(navigationBar) {
      self.navigationBar.popViewController = {
        print("버튼 누름")
        self.view.endEditing(true)
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
    tableView.showsVerticalScrollIndicator = false
    
    registerXib()
    layoutTableView()
  }
  
  func registerXib() {
    tableView.register(StudioMapSearchTableViewCell.self, forCellReuseIdentifier: Const.Xib.studioSearchTableViewCell)
  }
  
  func setupSearch() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Candies"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  @objc func touchSearchButton(_ sender: UIButton) {
  }
}

// MARK: - Extension - UITableViewDataSource, UITableViewDelegate
extension StudioMapSearchViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    if filteredData.isEmpty && load{
//      stackview.isHidden = true
//      noSearchView.isHidden = false
//      return 0
//    }
//    else{
//      stackview.isHidden = false
//      noSearchView.isHidden = true
//      return filteredData.count
    return serverSearchStudios?.studios.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.studioSearchTableViewCell, for: indexPath) as? StudioMapSearchTableViewCell else { return UITableViewCell() }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.clear
  }
}

extension StudioMapSearchViewController {
  func searchStudiosWithAPI(keyword: String) {
    StudioMapAPI.shared.searchStudio(keyword: keyword) { response in
      switch response {
      case .success(let data):
        if let search = data as? StudioSearchResponse {
          self.serverSearchStudios = search
          self.tableView.reloadData()
        }
      case .requestErr(let message):
        print("searchStudioWithAPI - requestErr: \(message)")
      case .pathErr:
        print("searchStudioWithAPI - pathErr")
      case .serverErr:
        print("searchStudioWithAPI - serverErr")
      case .networkFail:
        print("searchStudioWithAPI - networkFail")
      }
    }
  }
}

// 검색창 기능 구현
extension StudioMapSearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {

  }
}
