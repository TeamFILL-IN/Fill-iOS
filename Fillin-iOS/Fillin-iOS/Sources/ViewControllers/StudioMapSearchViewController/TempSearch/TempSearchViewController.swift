//
//  TempSearchViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/14.
//

import UIKit

class TempSearchViewController: UIViewController {

  // MARK: - Properties
  var tableView = UITableView()
  var isFiltering: Bool {
    let searchController = self.navigationItem.searchController
    let isActive = searchController?.isActive ?? false
    let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
    
    return isActive && isSearchBarHasText
  }

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Func
  func makeTableView() {
    tableView = UITableView()
    tableView.dataSource = self
    self.view.addSubview(tableView)
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mountinCell")
  }
  
  func layoutTableView() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
      $0.bottom.equalTo(self.view.snp.bottom)
      $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
    }
  }
  
  func makeSearchBar() {
    let searchController = UISearchController(searchResultsController: nil).then {
      $0.searchBar.placeholder = "추억을 현상할 현상소를 검색해보세요."
      $0.obscuresBackgroundDuringPresentation = false
      $0.searchResultsUpdater = self
    }
    self.navigationItem.hidesSearchBarWhenScrolling =  false
    self.navigationItem.searchController = searchController
  }
}

// MARK: - TableView Delegate
extension TempSearchViewController: UITableViewDelegate {
  

}

// MARK: - TableView DataSource
extension TempSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.isFiltering ? self.data.filterValue.count : self.data.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mountinCell")!
    if self.isFiltering == false {
      cell.textLabel?.text = self.data.items[indexPath.row]
    } else {
      cell.textLabel?.text = self.data.filterValue[indexPath.row]
    }
    
    return cell
  }
}

extension TempSearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else {
      return
    }
    print(text)
    self.data.filterValue = self.data.items.filter{ $0.localizedCaseInsensitiveContains(text)}
    
    self.tableView.reloadData()
  }
}

class data {
  var main:String
  var detail:detailtype
  var filtervalue: [Int] = []
  
  
  init(main: String, detail: detailtype) {
    self.main = main
    self.detail = detail
  }
}

enum detailtype:String {
  case A = "A"
  case B = "B"
}

