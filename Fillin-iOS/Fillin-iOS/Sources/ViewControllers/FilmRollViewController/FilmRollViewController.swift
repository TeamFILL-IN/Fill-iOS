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
    
    // MARK: - @IBAction Properties
    @IBAction func touchAddPhotoButton(_ sender: Any) {
        let nextVC = AddPhotoViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNavigationBar()
        registerXib()
        setNotification()
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
        filmRollCollectionView.register(FilmCurationFirstCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.filmCurationFirstCollectionViewCell)
        filmRollCollectionView.register(FilmCurationCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.filmCurationCollectionViewCell)
        filmRollCollectionView.register(FilmTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.filmTypeCollectionViewCell)
        filmRollCollectionView.register(
            FilmCurationCollectionReusableView.nib(),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Const.Xib.filmCurationCollectionReusableView)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToFilmTypeViewController), name: Notification.Name.pushToFilmSelectViewController, object: nil)
    }

    @objc func pushToFilmTypeViewController() {
        let nextVC = FilmSelectViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
