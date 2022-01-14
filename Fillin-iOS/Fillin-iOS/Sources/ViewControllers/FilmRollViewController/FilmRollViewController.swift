//
//  FilmRollViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class FilmRollViewController: UIViewController {
    
    // MARK: - Properties
    private let dataSource = FilmRollViewControllerDataSource()
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var navigationBar: FilinNavigationBar!
    @IBOutlet weak var filmRollCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNavigationBar()
        registerXib()
    }
    
}

// MARK: - Extensions
extension FilmRollViewController {
    private func setUI() {
        filmRollCollectionView.dataSource = dataSource
        filmRollCollectionView.collectionViewLayout = createLayout()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func registerXib() {
        filmRollCollectionView.register(FilmCurationCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.filmCurationCollectionViewCell)
        filmRollCollectionView.register(FilmTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.filmTypeCollectionViewCell)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilmRollViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - UICollectionViewDelegate
extension FilmRollViewController: UICollectionViewDelegate {
    
}
