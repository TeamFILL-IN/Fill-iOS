//
//  FilmRollViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit
import NVActivityIndicatorView

class FilmRollViewController: UIViewController {
    
    // MARK: - Properties
    let dataSource = FilmRollViewControllerDataSource()
    
    lazy var loadingBgView: UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        bgView.backgroundColor = .backgroundCover
        
        return bgView
    }()
    
    lazy var activityIndicator: NVActivityIndicatorView = {
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                                                        type: .ballBeat,
                                                        color: .fillinRed,
                                                        padding: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
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
        setActivityIndicator()
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
        NotificationCenter.default.addObserver(self, selector: #selector(selectedFilmAPI), name: Notification.Name.selectedFilmAPI, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(selectedFilmIdAPI), name: Notification.Name.selectedFilmIdAPI, object: nil)
    }
    
    private func setActivityIndicator() {
        view.addSubview(loadingBgView)
        loadingBgView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    @objc func pushToFilmTypeViewController(_ notification: Notification) {
        let selectedFilmDict = notification.object as? NSDictionary
        let nextVC = FilmSelectViewController()
        nextVC.selectedTag = selectedFilmDict?["selectedTag"] as? Int ?? 0
        nextVC.selectedLeading = selectedFilmDict?["selectedLeading"] as? CGFloat ?? 0
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func selectedFilmAPI(_ notification: Notification) {
        setActivityIndicator()
        let selectedStyleId = notification.object as? Int ?? 1
        filmStylePhotosWithAPI(styleId: selectedStyleId)
    }
    
    @objc func selectedFilmIdAPI(_ notification: Notification) {
        filmIdPhotosWithAPI(filmId: FilmSelectViewController.selectedId)
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
                print("curationWithAPI - requestErr: \(message)")
            case .pathErr:
                print("curationWithAPI - pathErr")
            case .serverErr:
                print("curationWithAPI - serverErr")
            case .networkFail:
                print("curationWithAPI - networkFail")
            }
        }
    }
    
    func filmStylePhotosWithAPI(styleId: Int) {
        FilmRollAPI.shared.filmStylePhotos(styleId: styleId) { response in
            switch response {
            case .success(let data):
                if let photos = data as? PhotosResponse {
                    self.dataSource.serverPhotos = photos
                    self.filmRollCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.loadingBgView.removeFromSuperview()
                }
            case .requestErr(let message):
                print("filmStylePhotosWithAPI - requestErr: \(message)")
            case .pathErr:
                print("filmStylePhotosWithAPI - pathErr")
            case .serverErr:
                print("filmStylePhotosWithAPI - serverErr")
            case .networkFail:
                print("filmStylePhotosWithAPI - networkFail")
            }
        }
    }
    
    func filmIdPhotosWithAPI(filmId: Int) {
        FilmRollAPI.shared.filmIdPhotos(filmId: filmId) { response in
            switch response {
            case .success(let data):
                if let photos = data as? PhotosResponse {
                    self.dataSource.serverPhotos = photos
                    self.filmRollCollectionView.reloadData()
                }
            case .requestErr(let message):
                print("filmIdPhotosWithAPI - requestErr: \(message)")
            case .pathErr:
                print("filmIdPhotosWithAPI - pathErr")
            case .serverErr:
                print("filmIdPhotosWithAPI - serverErr")
            case .networkFail:
                print("filmIdPhotosWithAPI - networkFail")
            }
        }
    }
}
