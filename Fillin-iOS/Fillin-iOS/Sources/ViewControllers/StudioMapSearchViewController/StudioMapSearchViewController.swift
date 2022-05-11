//
//  StudioMapSearchViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/13.
//

import UIKit

class StudioMapSearchViewController: UIViewController {
  
  // MARK: - Properties
  var serverSearchStudios: StudioSearchResponse?
  let backGroundView = UIView()
  let magnifyingGlassButton = UIButton()
  let searchPlaceTextField = UITextField() // searchBar
  let tableView = UITableView()
  let dividerView = UIView()
  let noSearchImageView = UIImageView()
  let navigationBar = FilinNavigationBar()
  let searchController = UISearchController(searchResultsController: nil)
  
  var status: Status = .originStudioVC
  var selectedStudio = ""
  static var selectedStudioId = 0
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    layoutSearchView()
    layoutNavigaionBar()
    makeTableView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    setUpTextField()
  }
  
  // MARK: - layout
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
    view.add(dividerView) {
      $0.backgroundColor = .darkGrey3
      $0.snp.makeConstraints {
        $0.top.equalTo(self.searchPlaceTextField.snp.bottom).offset(18)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(2)
      }
    }
  }
  private func layoutNavigaionBar() {
    view.add(navigationBar) {
      switch self.status {
      case .originStudioVC :
        self.navigationBar.popViewController = {
          print("버튼 누름")
          self.view.endEditing(true)
          self.dismiss(animated: true, completion: nil)
        }
      case .addPhotoVC :
        self.navigationBar.popViewController = {
          self.view.endEditing(true)
          self.navigationController?.popViewController(animated: true)
        }
      case .originFilmVC :
        return
      }
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        $0.leading.trailing.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
  }
  private func layoutTableView() {
    view.add(tableView) {
      $0.backgroundColor = .clear
      $0.showsVerticalScrollIndicator = false
      $0.snp.makeConstraints {
        $0.top.equalTo(self.dividerView.snp.bottom)
        $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
        $0.bottom.equalTo(self.view.snp.bottom)
        $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
      }
    }
  }
  
  // MARK: - Custom Method
  func makeTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    registerXib()
    layoutTableView()
  }
  
  func registerXib() {
    tableView.register(StudioMapSearchTableViewCell.self, forCellReuseIdentifier: Const.Xib.studioSearchTableViewCell)
  }
  
  func setUpTextField() { /// 수정
    searchPlaceTextField.becomeFirstResponder()
  }
  
  func changeEmptySearchView() {
    print("call")
    view.add(noSearchImageView) {
      $0.image = UIImage(named: "noSearch")
      $0.snp.makeConstraints {
        $0.top.equalTo(self.searchPlaceTextField.snp.bottom).offset(135)
        $0.centerX.equalTo(self.view.snp.centerX)
        $0.height.equalTo(223)
        $0.width.equalTo(246)
      }
    }
  }
      
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  @objc func touchSearchButton(_ sender: UIButton) {
    self.view.endEditing(true)
    changeEmptySearchView() /// (임시로 실행) 토큰 나오면 이 줄 삭제하기
    searchStudiosWithAPI(keyword: searchPlaceTextField.text ?? "")
  }
}

// MARK: - Extension - UITableViewDataSource, UITableViewDelegate
extension StudioMapSearchViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return serverSearchStudios?.studios.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.studioSearchTableViewCell, for: indexPath) as? StudioMapSearchTableViewCell else { return UITableViewCell() }
    cell.nameStudioLabel.updateServerLabel(name: serverSearchStudios?.studios[indexPath.row].name ?? "", keyword: searchPlaceTextField.text ?? "")
    cell.locationStudionLabel.updateServerLabel(name: serverSearchStudios?.studios[indexPath.row].address ?? "", keyword: searchPlaceTextField.text ?? "")
    cell.nameStudioLabel.text = serverSearchStudios?.studios[indexPath.row].name
    cell.studioId = serverSearchStudios?.studios[indexPath.row].id
    cell.awakeFromNib()
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 85
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor.clear
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let studioCell = tableView.cellForRow(at: indexPath) as? StudioMapSearchTableViewCell
    studioCell?.isSelected = true
    selectedStudio = studioCell?.nameStudioLabel.text ?? ""
    StudioMapSearchViewController.selectedStudioId = studioCell?.studioId ?? 0
    /// studioVC에서 들어올때, addPhoto에서 들어올 때 분기처리
    switch status {
    case .originStudioVC :
      let searchStudioID = serverSearchStudios?.studios[indexPath.row].id
      self.dismiss(animated: true, completion: nil)
      NotificationCenter.default.post(name: NSNotification.Name("GetLatLng"), object: searchStudioID, userInfo: nil)
      
    case .addPhotoVC :
      let selectedStudioDict = ["selectedStudioId": StudioMapSearchViewController.selectedStudioId, "selectedStudio": selectedStudio] as [String: Any]
      NotificationCenter.default.post(name: NSNotification.Name.selectedStudioIdAPI, object: selectedStudioDict, userInfo: nil)
      self.navigationController?.popViewController(animated: true)
      
    case .originFilmVC:
      return
    }
  }
}

extension StudioMapSearchViewController {
  func searchStudiosWithAPI(keyword: String) {
    StudioMapAPI.shared.searchStudio(keyword: keyword) { response in
      switch response {
      case .success(let data):
        if let search = data as? StudioSearchResponse {
          self.serverSearchStudios = search
          if ((self.serverSearchStudios?.studios.isEmpty) != nil) {
            self.changeEmptySearchView()
          } else {
            self.tableView.reloadData()
          }
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
