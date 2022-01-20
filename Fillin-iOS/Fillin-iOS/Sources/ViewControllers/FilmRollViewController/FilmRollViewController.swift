//
//  FilmRollViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class FilmRollViewController: UIViewController {
    
    // MARK: - Properties
    let dataSource = FilmRollViewControllerDataSource()
    
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
        curationWithAPI()
        filmStylePhotosWithAPI(styleId: 1)
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
    
    @objc func pushToFilmTypeViewController(_ notification: Notification) {
        let selectedFilmDict = notification.object as? NSDictionary
        let nextVC = FilmSelectViewController()
        nextVC.selectedTag = selectedFilmDict?["selectedTag"] as? Int ?? 0
        nextVC.selectedLeading = selectedFilmDict?["selectedLeading"] as? CGFloat ?? 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - Network
extension FilmRollViewController {
    func curationWithAPI() {
        FilmRollAPI.shared.curation { response in
            switch response {
            case .success(let data):
                if let curations = data as? CurationResponse {
                    self.dataSource.serverCuration = curations
                    self.filmRollCollectionView.reloadData()
                }
            case .requestErr(let message):
                print("latestPhotosWithAPI - requestErr: \(message)")
            case .pathErr:
                print("latestPhotosWithAPI - pathErr")
            case .serverErr:
                print("latestPhotosWithAPI - serverErr")
            case .networkFail:
                print("latestPhotosWithAPI - networkFail")
            }
        }
    }
    
    func filmStylePhotosWithAPI(styleId: Int) {
        FilmRollAPI.shared.filmStylePhotos(styleId: styleId) { response in
            switch response {
            case .success(let data):
                if let photos = data as? PhotosResponse {
                    print(photos)
//                    self.dataSource.serverPhotos = photos
//                    self.filmRollCollectionView.reloadData()
                }
            case .requestErr(let message):
                print("latestPhotosWithAPI - requestErr: \(message)")
            case .pathErr:
                print("latestPhotosWithAPI - pathErr")
            case .serverErr:
                print("latestPhotosWithAPI - serverErr")
            case .networkFail:
                print("latestPhotosWithAPI - networkFail")
            }
        }
    }
}
