//
//  OnboardingViewController.swift
//  Fillin-iOS
//
//  Created by 김지수 on 2022/03/01.
//

import UIKit

import SnapKit
import Then

// MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
  
  // MARK: - Components
  let onboardingCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.isScrollEnabled = true
    collectionView.isPagingEnabled = true
    return collectionView
  }()
  let containerView = UIView()
  let skipButton = UIButton()
  let pageControl = UIPageControl()
  
  var onboardingData: [OnboardingDataModel] = []
  var currentPage: Int = 0 {
    didSet {
      pageControl.currentPage = currentPage
      
      if currentPage == onboardingData.count - 1 {
        skipButton.setupButton(title: "시작하기", color: .fillinRed, font: .subhead3, backgroundColor: .clear, state: .normal, radius: 0)
      } else {
        skipButton.setupButton(title: "건너뛰기", color: .grey3, font: .subhead3, backgroundColor: .clear, state: .normal, radius: 0)
      }
    }
  }
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .fillinBlack
    self.navigationController?.navigationBar.isHidden = true
    layout()
    setUI()
    setCollectionView()
    setOnboardingData()
  }
}
// MARK: - Extension
extension OnboardingViewController {
  func layout() {
    layoutOnboardingCollectionView()
    layoutContainerView()
    layoutPageControl()
    layoutSkipButton()
  }
  func layoutOnboardingCollectionView() {
    self.view.add(onboardingCollectionView) {
      $0.showsHorizontalScrollIndicator = false
      $0.contentInsetAdjustmentBehavior = .never
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(64)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(self.view.snp.bottom).offset(-66)
      }
    }
  }
  func layoutContainerView() {
    self.view.add(containerView) {
      $0.backgroundColor = .clear
      $0.snp.makeConstraints {
        $0.top.equalTo(self.view.snp.bottom).offset(-66)
        $0.leading.equalToSuperview()
        $0.trailing.equalToSuperview().offset(-31)
        $0.height.equalTo(22)
      }
    }
  }
  func layoutPageControl() {
    self.containerView.add(pageControl) {
      $0.numberOfPages = 3
      $0.pageIndicatorTintColor = .darkGrey1
      $0.currentPageIndicatorTintColor = .fillinRed
      $0.snp.makeConstraints {
        $0.leading.equalTo(self.containerView.snp.leading)
        $0.centerY.equalToSuperview()
      }
    }
  }
  func layoutSkipButton() {
    self.containerView.add(skipButton) {
      $0.setupButton(title: "건너뛰기", color: .grey3, font: .subhead3, backgroundColor: .clear, state: .normal, radius: 0)
      $0.addTarget(self, action: #selector(self.skipButtonClicked), for: .touchUpInside)
      $0.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.trailing.equalToSuperview()
      }
    }
  }
  private func setUI() {
    pageControl.isUserInteractionEnabled = false
  }
  
  private func setCollectionView() {
    onboardingCollectionView.delegate = self
    onboardingCollectionView.dataSource = self
    self.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.cellId)
  }
  
  private func setOnboardingData() {
    onboardingData.append(contentsOf: [
      OnboardingDataModel(imageName: "intro1",
                          title: "필름을 스캔 할 현상소 정보를 찾고 계신가요?",
                          description: "주변 현상소 정보를\n필린에서 찾아보세요!"),
      OnboardingDataModel(imageName: "intro2",
                          title: "어떤 필름을 사용 해 볼지 고민 하고 계신가요?",
                          description: "다양한 필름 사진을\n필린에서 만나보세요!"),
      OnboardingDataModel(imageName: "intro3",
                          title: "직접 찍은 필름 사진이나 정보를 공유하고 싶나요?",
                          description: "나만의 필름 사진을\n필린에서 공유해보세요!")
    ])
  }
  @objc func skipButtonClicked() {
      let loginVC = LoginViewController()
      loginVC.modalPresentationStyle = .fullScreen
      loginVC.modalTransitionStyle = .crossDissolve
      self.present(loginVC, animated: true, completion: nil)
  }
}
// MARK: - CollectionView Delegate, DataSource
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return onboardingData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.cellId, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
    cell.awakeFromNib()
    cell.setOnboardingSlides(onboardingData[indexPath.row])
    return cell
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let width = scrollView.frame.width
    currentPage = lroundl(Float80(scrollView.contentOffset.x / width))
  }
}

// MARK: - CollectionView Delegate Flow Layout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}
