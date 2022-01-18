//
//  StudioMapBottomSheetViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/14.
//
import UIKit

class StudioMapBottomSheetViewController: UIViewController {
  
  // MARK: - Properties
  enum BottomSheetViewState {
    case expanded
    case normal
  }
  
  private let contentViewController: UIViewController
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  var bottomSheetPanMinTopConstant: CGFloat = 50.0
  var bottomHeight: CGFloat = 210
  let defaultHeight: CGFloat = 210
  private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
  
  let bottomSheetView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey2
    return view
  }()
  
  let bottomSheetCoverView: UIView = {
    let view = UIView()
    view.backgroundColor = .darkGrey2
    return view
  }()
  
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
  
  // MARK: - init
  init(contentViewController: UIViewController) {
    self.contentViewController = contentViewController
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - @Functions
  // UI 세팅 작업
  private func setupUI() {
    addChild(contentViewController)
    bottomSheetView.addSubview(contentViewController.view)
    contentViewController.didMove(toParent: self)
    bottomSheetView.clipsToBounds = true
    
    view.addSubviews([bottomSheetView, dismissIndicatorView, bottomSheetCoverView])
    view.backgroundColor = .clear

    let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
    
    viewPan.delaysTouchesBegan = false
    viewPan.delaysTouchesEnded = false
    view.addGestureRecognizer(viewPan)
    
    setupLayout()
  }
  
  private func setupGestureRecognizer() {

    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  // 레이아웃
  private func setupLayout() {
    contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
      contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
      contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
      contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
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
  
  private func showBottomSheet(atState: BottomSheetViewState = .normal) {
    
    if atState == .normal {
      let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding: CGFloat = view.safeAreaInsets.bottom
      bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
    } else {
      bottomSheetViewTopConstraint.constant = bottomSheetPanMinTopConstant
    }
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      self.bottomSheetCoverView.isHidden = true
    })
  }
  
  func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
      self.bottomSheetCoverView.isHidden = false
    }, completion: { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    })
  }

  func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
    guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
    else { return number }
    return nearestVal
  }
  
  func setNotification() {
    NotificationCenter.default.post(name: NSNotification.Name.changeMarker, object: nil, userInfo: nil)
  }
  
  // MARK: - @objc
  @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
  
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
  
  @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
    let translation = panGestureRecognizer.translation(in: self.view)
    let velocity = panGestureRecognizer.velocity(in: view)
    
    switch panGestureRecognizer.state {
    case .began:
      bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
    case .changed:
      if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
        bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
      }
    case .ended:
      if velocity.y > 1500 {
        setNotification()
        hideBottomSheetAndGoBack()
        return
      }
      let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
      let bottomPadding = view.safeAreaInsets.bottom
      
      let defaultPadding = safeAreaHeight + bottomPadding - defaultHeight
      let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant + 200, defaultPadding, safeAreaHeight + bottomPadding])
      if nearestValue == bottomSheetPanMinTopConstant + 200 {
        showBottomSheet(atState: .expanded)
      } else if nearestValue == defaultPadding {
        showBottomSheet(atState: .normal)
      } else {
        setNotification()
        hideBottomSheetAndGoBack()
      }
    default:
      break
    }
  }
}
