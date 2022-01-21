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
        filmRollCollectionView.delegate = self
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

extension FilmRollViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoPopupVC = FilmRollClickViewController()
        photoPopupVC.modalPresentationStyle = .overCurrentContext
        photoPopupVC.modalTransitionStyle = .crossDissolve
        switch FilmRollSection.allCases[indexPath.section] {
        case .filmCuration:
            if indexPath.row > 0 {
                photoPopupVC.userprofile = dataSource.serverCuration?.photos[indexPath.row-1].userImageURL ?? ""
                photoPopupVC.username = dataSource.serverCuration?.photos[indexPath.row-1].nickname ?? ""
                photoPopupVC.filmname = dataSource.serverCuration?.photos[indexPath.row-1].filmName ?? ""
                photoPopupVC.photoImage = dataSource.serverCuration?.photos[indexPath.row-1].imageURL ?? ""
                photoPopupVC.likeCount = dataSource.serverCuration?.photos[indexPath.row-1].likeCount ?? 0
                photoPopupVC.isLiked = dataSource.serverCuration?.photos[indexPath.row-1].isLiked ?? false
                self.present(photoPopupVC, animated: true, completion: nil)
            }
        case .filmType:
            print("nothing")
        case .filmRoll:
            photoPopupVC.userprofile = dataSource.serverPhotos?.photos[indexPath.row].userImageURL ?? ""
            photoPopupVC.username = dataSource.serverPhotos?.photos[indexPath.row].nickname ?? ""
            photoPopupVC.filmname = dataSource.serverPhotos?.photos[indexPath.row].filmName ?? ""
            photoPopupVC.photoImage = dataSource.serverPhotos?.photos[indexPath.row].imageURL ?? ""
            photoPopupVC.likeCount = dataSource.serverPhotos?.photos[indexPath.row].likeCount ?? 0
            photoPopupVC.isLiked = dataSource.serverPhotos?.photos[indexPath.row].isLiked ?? false
            self.present(photoPopupVC, animated: true, completion: nil)
        }
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
