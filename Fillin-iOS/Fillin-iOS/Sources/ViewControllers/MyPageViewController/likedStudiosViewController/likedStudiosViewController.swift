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
  private let headerView = UIView()
  
  private lazy var studiosCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = true
    collectionView.backgroundColor = .black
    
    return collectionView
  }()
  
  private let myStudioLabel = UILabel().then {
    $0.text = "My Studio"
    $0.font = UIFont(name: "FuturaStd-Book", size: 16)
    $0.textColor = .fillinWhite
  }
  
  private let backCircleView = UIView().then {
    $0.backgroundColor = .fillinRed
    $0.layer.cornerRadius = 12
  }
  
  private var studioCountLabel = UILabel().then {
    $0.font = UIFont(name: "FuturaStd-Book", size: 12)
    $0.textColor = .fillinWhite
  }
  
  private let borderLineView = UIView().then {
    $0.backgroundColor = .darkGrey1
  }
  
  private lazy var upButton = UIButton().then {
    $0.setImage(Asset.btnUp.image, for: .normal)
    $0.addTarget(self, action: #selector(upButtonDidTap), for: .touchUpInside)
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setAttribute()
    setLayout()
    setDummyData()
  }
  
  // MARK: - @objc
  @objc func upButtonDidTap(_ sender: UIButton) {
    studiosCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }
  
  // MARK: - Custom Method
  private func setDummyData() {
    for _ in 0..<22 {
      likedStudiosList.append(contentsOf: [LikedStudio(id: 0, name: "필린 사진관", address: "서울특별시 영등포구 여의도동21-3 가가가가가가가가가가가가가가가가")])
    }
    studioCountLabel.text = "\(likedStudiosList.count)"
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
    navigationBar.popViewController = { self.navigationController?.popViewController(animated: true)
    }
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
    layoutHeaderView()
    layoutStudiosCollectionView()
    layoutFloatingUpButton()
  }
  
  private func layoutNavigaionBar() {
    view.addSubview(navigationBar)
    navigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
  }
  
  private func layoutHeaderView() {
    view.addSubview(headerView)
    headerView.addSubviews([myStudioLabel, backCircleView, studioCountLabel, borderLineView])
    headerView.snp.makeConstraints {
      $0.top.equalTo(navigationBar.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    myStudioLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().inset(19)
    }
    backCircleView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().inset(18)
      $0.width.height.equalTo(24)
    }
    studioCountLabel.snp.makeConstraints {
      $0.center.equalTo(backCircleView)
    }
    borderLineView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
  
  private func layoutStudiosCollectionView() {
    view.addSubview(studiosCollectionView)
    studiosCollectionView.snp.makeConstraints {
      $0.top.equalTo(headerView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
  
  private func layoutFloatingUpButton() {
    view.addSubview(upButton)
    upButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(36)
      $0.trailing.equalToSuperview().inset(18)
    }
  }
}

// MARK: - UICollectionViewDelegate
extension LikedStudiosViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // TODO: - 뷰 전환
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
