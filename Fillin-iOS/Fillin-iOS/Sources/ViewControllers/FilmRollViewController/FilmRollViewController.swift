//
//  FilmRollViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class FilmRollViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var navigationBar: FilinNavigationBar!
    @IBOutlet weak var filmCurationLabel: UILabel!
    
    @IBOutlet weak var filmCurationCollectionView: UICollectionView!
    @IBOutlet weak var filmRollCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNavigationBar()
    }
    
}

extension FilmRollViewController {
    private func setUI() {
        filmCurationLabel.font = .engHead
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
