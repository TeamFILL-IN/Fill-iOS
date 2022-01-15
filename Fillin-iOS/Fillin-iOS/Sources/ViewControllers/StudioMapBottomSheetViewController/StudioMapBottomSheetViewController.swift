//
///  StudioMapBottomSheetViewController.swift
///  Fillin-iOS
//////
//  Created by 임주민 on 2022/01/14.
////
import UIKit

class StudioMapBottomSheetViewController: UIViewController {
  
  // MARK: - Properties
  var bottomHeight: CGFloat = 210
  
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
    view.backgroundColor = .darkGrey2
    return view
  }()
  
  // 애니메이션을 위한 뷰
  let bottomSheetCoverView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey2
    return view
  }()
  
  // dismiss Indicator View UI 구성 부분
  private let dismissIndicatorView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey1
    view.layer.cornerRadius = 3
    
    return view
  }()
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
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
    view.addSubview(bottomSheetCoverView)
    view.backgroundColor = .clear
    
    dimmedBackView.alpha = 0.0
    setupLayout()
  }
  
  private func setupGestureRecognizer() {
    // TapGesture
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
    dimmedBackView.addGestureRecognizer(dimmedTap)
    dimmedBackView.isUserInteractionEnabled = true
    
    // swipeGesture
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  // 레이아웃
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
      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 40),
      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 3),
      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
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
