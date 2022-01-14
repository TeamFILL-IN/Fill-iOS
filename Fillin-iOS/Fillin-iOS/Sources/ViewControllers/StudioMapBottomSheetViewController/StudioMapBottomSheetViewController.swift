//
//  StudioMapBottomSheetViewController.swift
//  Fillin-iOS
//
//  Created by 임주민 on 2022/01/14.
//

import UIKit

class StudioMapBottomSheetViewController: UIViewController {
  
  // MARK: - Properties
  var bottomHeight: CGFloat = 807
  
  private var bottomSheetViewTopConstraint: NSLayoutConstraint!
  
  private let bottomSheetView = UIView().then {
    $0.backgroundColor = .darkGrey2
  }
  
  private let backView = UIView().then {
    $0.alpha = 0.0
  }
  
  private let dismissIndicatorView = UIView().then {
    $0.backgroundColor = .darkGrey2
    $0.layer.cornerRadius = 3
  }

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
  
  // MARK: - Custom Func
  private func setupUI() {
    view.addSubview(bottomSheetView)
    view.addSubview(backView)
    
    setupLayout()
  }
  
  private func setupGestureRecognizer() {
    let backViewTap = UITapGestureRecognizer(target: self, action: #selector(backViewTapped(_:)))
    backView.addGestureRecognizer(backViewTap)
    backView.isUserInteractionEnabled = true
    
    let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(panGestrue))
    swipeGesture.direction = .down
    view.addGestureRecognizer(swipeGesture)
  }
  
  private func setupLayout() {
    backView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backView.topAnchor.constraint(equalTo: view.topAnchor),
      backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    dismissIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dismissIndicatorView.widthAnchor.constraint(equalToConstant: 102),
      dismissIndicatorView.heightAnchor.constraint(equalToConstant: 7),
      dismissIndicatorView.topAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12),
      dismissIndicatorView.centerXAnchor.constraint(equalTo: bottomSheetView.centerXAnchor)
    ])
  }
  
  private func showBottomSheet() {
    let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding: CGFloat = view.safeAreaInsets.bottom
    
    bottomSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - bottomHeight
    
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
      self.backView.alpha = 0.0
      self.view.layoutIfNeeded()
    }, completion: nil)
  }
  
  private func hideBottomSheetAndGoBack() {
    let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
    let bottomPadding = view.safeAreaInsets.bottom
    bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
    UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
      self.backView.alpha = 0.0
      self.view.layoutIfNeeded()
    }) { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    }
  }
  
  @objc private func backViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
    hideBottomSheetAndGoBack()
  }
  
  @objc func panGestrue(_ recognizer: UISwipeGestureRecognizer) {
    if recognizer.state == .ended {
      switch recognizer.direction {
      case .down:
        hideBottomSheetAndGoBack()
      default:
        break
      }
    }
  }
  // MARK: - Extensions
  
  // MARK: - UITableViewDataSource
  
  // MARK: - UITableViewDelegate
  
}
