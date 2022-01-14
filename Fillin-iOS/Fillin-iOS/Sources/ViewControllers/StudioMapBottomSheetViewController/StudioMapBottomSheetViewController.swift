////
////  StudioMapBottomSheetViewController.swift
////  Fillin-iOS
////
////  Created by 임주민 on 2022/01/14.
////
//
import UIKit
//
//class StudioMapBottomSheetViewController: UIViewController {
//
//  // MARK: - Properties
//  var bottomHeight: CGFloat = 210
//
//  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
//
////  private let bottomSheetView = UIView().then {
////    $0.backgroundColor = .white
////  }
//
//  let backView: UIView = {
//      let view = UIView()
//    view.backgroundColor = .darkGray
//      return view
//  }()
//
//  private let dismissIndicatorView = UIView().then {
//    $0.backgroundColor = .darkGrey2
//    $0.layer.cornerRadius = 3
//  }
//
//  let bottomSheetView: UIView = {
//      let view = UIView()
//      view.backgroundColor = .systemBackground
//
//      view.layer.cornerRadius = 27
//      view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//      view.clipsToBounds = true
//
//      return view
//  }()
//
//  let bottomSheetCoverView: UIView = {
//      let view = UIView()
//      view.backgroundColor = .systemBackground
//
//      view.layer.cornerRadius = 27
//      view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//      view.clipsToBounds = true
//
//      return view
//  }()
//
//  // MARK: - View Life Cycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    setupUI()
//    setupGestureRecognizer()
//  }
//
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//
//    showBottomSheet()
//  }
//
//  // MARK: - Custom Func
//  private func setupUI() {
//    view.addSubview(bottomSheetView)
//    view.addSubview(backView)
//    view.addSubview(dismissIndicatorView)
//    view.addSubview(bottomSheetCoverView)
//
//    backView.alpha = 0.0
//    setupLayout()
//  }
//
//  private func setupGestureRecognizer() {
//    let backViewTap = UITapGestureRecognizer(target: self, action: #selector(backViewTapped(_:)))
//    backView.addGestureRecognizer(backViewTap)
//    backView.isUserInteractionEnabled = true
//
//    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGestrue))
//    swipeGesture.direction = .down
//    view.addGestureRecognizer(swipeGesture)
//  }
//
//  private func setupLayout() {
//    backView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      backView.topAnchor.constraint(equalTo: view.topAnchor),
//      backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//      backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//      backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//    ])
//
//    bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
//    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
//    bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
//    NSLayoutConstraint.activate([
//      bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//      bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//      bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//      bottomSheetViewTopConstraint
//    ])
//
//    dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 102),
//      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
//      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
//      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
//    ])
//  }
//
//  private func showBottomSheet() {
//    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
//    let bottomPadding: CGFloat = view.safeAreaInsets.bottom
//
//    bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
//
//    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//        self.backView.alpha = 1.0
//        self.view.layoutIfNeeded()
//    }, completion: { _ in
//        self.bottomSheetCoverView.isHidden = true
//    })
//  }
//
//  private func hideBottomSheetAndGoBack() {
//    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
//    let bottomPadding = view.safeAreaInsets.bottom
//    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
//    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//        self.backView.alpha = 0.0
//        self.view.layoutIfNeeded()
//        self.bottomSheetCoverView.isHidden = false
//    }, completion: { _ in
//        if self.presentingViewController != nil {
//            self.dismiss(animated: false, completion: nil)
//        }
//    })
//  }
//
//  func hideBottomSheetAndPresentVC(nextViewController: UIViewController) {
//      let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
//      let bottomPadding = view.safeAreaInsets.bottom
//      bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
//      UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//          self.backView.alpha = 0.0
//          self.view.layoutIfNeeded()
//          self.bottomSheetCoverView.isHidden = false
//      }, completion: { _ in
//          if self.presentingViewController != nil {
//              guard let presentingVC = self.presentingViewController else { return }
//              self.dismiss(animated: false) {
//                  let nextVC = nextViewController
//                  nextVC.modalPresentationStyle = .overFullScreen
//                  presentingVC.present(nextVC, animated: true, completion: nil)
//              }
//          }
//      })
//  }
//
//  @objc private func backViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
//    hideBottomSheetAndGoBack()
//  }
//
//  @objc func panGestrue(_ recognizer: UISwipeGestureRecognizer) {
//    if recognizer.state == .ended {
//      switch recognizer.direction {
//      case .down:
//        hideBottomSheetAndGoBack()
//      default:
//        break
//      }
//    }
//  }
//  // MARK: - Extensions
//
//  // MARK: - UITableViewDataSource
//
//  // MARK: - UITableViewDelegate
//
//}

class StudioMapBottomSheetViewController: UIViewController {
  
  // MARK: - Properties
  // 바텀 시트 높이
  var bottomHeight: CGFloat = 475
  
  // bottomSheet가 view의 상단에서 떨어진 거리
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  
  // 기존 화면을 흐려지게 만들기 위한 뷰
  let dimmedBackView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  // 바텀 시트 뷰
  let bottomSheetView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    
    view.layer.cornerRadius = 27
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.clipsToBounds = true
    
    return view
  }()
  
  // 자연스러운 애니메이션을 위한..커버..
  let bottomSheetCoverView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    
    view.layer.cornerRadius = 27
    view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    view.clipsToBounds = true
    
    return view
  }()
  
  // dismiss Indicator View UI 구성 부분
  private let dismissIndicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 3
    
    return view
  }()
  
  // 바텀 시트 메인 라벨
  public let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.textAlignment = .center
    label.sizeToFit()
    
    return label
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .clear
    setupUI()
    setupGestureRecognizer()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    showBottomSheet()
  }
  
  // MARK: - @Functions
  // UI 세팅 작업
  private func setupUI() {
    view.addSubview(dimmedBackView)
    view.addSubview(bottomSheetView)
    view.addSubview(dismissIndicatorView)
    view.addSubview(titleLabel)
    view.addSubview(bottomSheetCoverView)
    
    dimmedBackView.alpha = 0.0
    setupLayout()
  }
  
  // GestureRecognizer 세팅 작업
  private func setupGestureRecognizer() {
    // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
    dimmedBackView.addGestureRecognizer(dimmedTap)
    dimmedBackView.isUserInteractionEnabled = true
    
    // 스와이프 했을 때, 바텀시트를 내리는 swipeGesture
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  // 레이아웃 세팅
  private func setupLayout() {
    dimmedBackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dimmedBackView.topAnchor.constraint(equalTo: view.topAnchor),
      dimmedBackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dimmedBackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dimmedBackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
    let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
    bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
    NSLayoutConstraint.activate([
      bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      bottomSheetViewTopConstraint
    ])
    
    bottomSheetCoverView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomSheetCoverView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
      bottomSheetCoverView.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
      bottomSheetCoverView.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
      bottomSheetCoverView.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
    ])
    
    dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 102),
      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
    ])
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: dismissIndicatorView.bottomAnchor, constant: 28),
      titleLabel.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
    ])
  }
  
  // 바텀 시트 표출 애니메이션
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding: CGFloat = view.safeAreaInsets.bottom
    
    bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
    
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.dimmedBackView.alpha = 1.0
      self.view.layoutIfNeeded()
    }, completion: { _ in
      self.bottomSheetCoverView.isHidden = true
    })
  }
  
  // 바텀 시트 사라지는 애니메이션
  func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
      self.bottomSheetCoverView.isHidden = false
    }, completion: { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    })
  }
  
  func hideBottomSheetAndPresentVC(nextViewController: UIViewController) {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
      self.bottomSheetCoverView.isHidden = false
    }, completion: { _ in
      if self.presentingViewController != nil {
        guard let presentingVC = self.presentingViewController else { return }
        self.dismiss(animated: false) {
          let nextVC = nextViewController
          nextVC.modalPresentationStyle = .overFullScreen
          presentingVC.present(nextVC, animated: true, completion: nil)
        }
      }
    })
  }
  
  // UITapGestureRecognizer 연결 함수 부분
  @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
  
  // UISwipeGestureRecognizer 연결 함수 부분
  @objc func panGesture(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        hideBottomSheetAndGoBack()
      default:
        break
      }
    }
  }
}
