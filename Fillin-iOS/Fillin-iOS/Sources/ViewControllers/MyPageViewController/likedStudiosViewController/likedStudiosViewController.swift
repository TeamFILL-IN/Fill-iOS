//
//  likedStudiosViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2023/01/19.
//

import UIKit

import SnapKit
import Then

final class LikedStudiosViewController: UIViewController {
  // MARK: - Properties
  var likedStudiosList: [LikedStudio] = []
  
  // MARK: - UI Properties
  private let navigationBar = FilinNavigationBar()
  
  private lazy var studiosCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = true
    collectionView.backgroundColor = .black
    
    return collectionView
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAttribute()
    setLayout()
    setDummyData()
  }
  
  // MARK: - @objc
  
  // MARK: - Custom Method
  private func setDummyData() {
    for _ in 0..<20 {
      likedStudiosList.append(contentsOf: [LikedStudio(id: 0, name: "필린 사진관", address: "서울특별시 영등포구 여의도동21-3 가가가가가가가가가가가가가가가가")])
    }
  }
}

// MARK: - Attribute
extension LikedStudiosViewController {
  private func setAttribute() {
    setUpNavigationBar()
    registerCell()
    setDelegate()
  }
  
  private func setUpNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
    navigationBar.popViewController = { self.navigationController?.popViewController(animated: true) }
  }
  
  private func registerCell() {
    studiosCollectionView.register(LikedStudiosCollectionViewCell.self, forCellWithReuseIdentifier: LikedStudiosCollectionViewCell.identifier)
  }
  
  private func setDelegate() {
    studiosCollectionView.delegate = self
    studiosCollectionView.dataSource = self
  }
}

// MARK: - Layout
extension LikedStudiosViewController {
  private func setLayout() {
    layoutNavigaionBar()
    layoutStudiosCollectionView()
  }
  
  private func layoutNavigaionBar() {
    view.add(navigationBar)
    navigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
  }
  
  private func layoutStudiosCollectionView() {
    view.add(studiosCollectionView)
    studiosCollectionView.snp.makeConstraints {
      $0.top.equalTo(navigationBar.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDelegate
extension LikedStudiosViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath.row)
    //      let studioMapViewController = StudioMapViewController(contentViewController: <#UIViewController#>)
    //      detailMyDiaryViewController.diaryId = diaryList[indexPath.row].diaryId
    //      self.navigationController?.pushViewController(studioMapViewController, animated: true)
  }
}

// MARK: - UICollectionViewDataSource
extension LikedStudiosViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return likedStudiosList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikedStudiosCollectionViewCell.identifier, for: indexPath) as? LikedStudiosCollectionViewCell else { return UICollectionViewCell() }
    let studioName = likedStudiosList[indexPath.row].name
    let studioAddress = likedStudiosList[indexPath.row].address
    cell.setData(studioName: studioName, studioAddress: studioAddress)
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LikedStudiosViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellSize = CGSize(width: UIScreen.main.bounds.width, height: 85)
    
    return cellSize
  }
}
