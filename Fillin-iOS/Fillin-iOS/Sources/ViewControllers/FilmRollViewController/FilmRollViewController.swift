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
        filmCurationLabel.font = .engHead
        filmRollCollectionView.delegate = self
//        filmRollCollectionView.dataSource = self
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

// MARK: - UICollectionViewDataSource
//extension FilmRollViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
//}
