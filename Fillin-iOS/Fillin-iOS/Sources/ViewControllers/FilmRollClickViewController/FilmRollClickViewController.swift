//
//  FilmRollClickViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/11.
//

import UIKit

class FilmRollClickViewController: UIViewController {
  
  var userprofile = ""
  var username = ""
  var filmname = ""
  var photoImage = ""
    var likeCount = 0
    var isLiked = false
  
  
  // MARK: - @IBOutlet Properties
  @IBOutlet weak var visualVC: UIVisualEffectView!
  @IBOutlet weak var dimmedBackView: UIView!
  @IBOutlet weak var popUpView: UIView!
  
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var profileNameLabel: UILabel!
  @IBOutlet weak var filmNameLabel: UILabel!
  
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  
  
  // MARK: - @IBAction Properties
  @IBAction func touchDismissButton(_ sender: Any) {
    dismissPopUp()
  }
  
  @IBAction func touchLikeButton(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    // TODO: 23 실제 값+1 으로 채워넣기
      sender.setTitle(String(likeCount+1), for: .selected)
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
    setupGestureRecognizer()
    setBlurLayer()
    
  }
  
}

// MARK: - Extensions
extension FilmRollClickViewController {
  private func setUI() {
    dimmedBackView.backgroundColor = .clear
    profileNameLabel.font = .body2
    filmNameLabel.font = .engDisplay2Book
      likeButton.setTitle(String(likeCount), for: .normal)
    likeButton.titleLabel?.font = .body2
    likeButton.layer.borderWidth = 1
    likeButton.layer.borderColor = UIColor.darkGrey1.cgColor
    likeButton.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7), imageTitlePadding: CGFloat(6))
      likeButton.isSelected = isLiked
    profileImage.updateServerImage(userprofile)
    profileNameLabel.text = username
    filmNameLabel.text = filmname
    photoImageView.updateServerImage(photoImage)
  }
  
  private func setupGestureRecognizer() {
    // 흐린 부분 탭할 때, 바텀시트를 내리는 TapGesture
    let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(tappedDimmedView(_:)))
    visualVC.addGestureRecognizer(dimmedTap)
    visualVC.isUserInteractionEnabled = true
  }
  
  private func dismissPopUp() {
    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
      self.dimmedBackView.alpha = 0.0
      self.view.layoutIfNeeded()
      self.popUpView.isHidden = true
    }, completion: { _ in
      if self.presentingViewController != nil {
        self.dismiss(animated: false, completion: nil)
      }
    })
  }
  private func setBlurLayer() {
    let blurEffect = UIBlurEffect(style: .regular)
    let visualEffectView = UIVisualEffectView(effect: blurEffect)
    visualEffectView.frame = self.view.frame
    visualEffectView.translatesAutoresizingMaskIntoConstraints = false
    self.dimmedBackView.addSubview(visualEffectView)
  }
  @objc private func tappedDimmedView(_ tapRecognizer: UITapGestureRecognizer) {
    dismissPopUp()
  }
}
