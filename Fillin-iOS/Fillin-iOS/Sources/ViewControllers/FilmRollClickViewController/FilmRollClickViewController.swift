//
//  FilmRollClickViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/11.
//

import UIKit

class FilmRollClickViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var dimmedBackview: UIView!
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var profileTouchArea: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var filmTouchArea: UIView!
    @IBOutlet weak var filmNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet var dividerViews: [UIView]!
    
    @IBAction func touchDismissButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
