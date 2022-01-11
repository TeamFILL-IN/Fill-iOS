//
//  FilmRollClickViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/11.
//

import UIKit

class FilmRollClickViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var dimmedBackview: UIView!
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var filmNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    // MARK: - @IBAction Properties
    @IBAction func touchDismissButton(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.dimmedBackview.alpha = 0.0
            self.view.layoutIfNeeded()
            self.popUpView.isHidden = true
        }, completion: { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        })
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

// MARK: - Extensions
extension FilmRollClickViewController {
    private func setUI() {
        profileNameLabel.font = .body2
        filmNameLabel.font = .engDisplay2Book
        likeButton.titleLabel?.font = .body2
        likeButton.layer.borderWidth = 1
        likeButton.layer.borderColor = UIColor.darkGrey1.cgColor
        likeButton.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7), imageTitlePadding: CGFloat(6))
    }
    
}
