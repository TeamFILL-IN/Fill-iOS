//
//  HomeViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    var newPhotos: PhotosResponse?
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var floatingButton: UIView!
    @IBOutlet weak var floatingButtonLabel: UILabel!
    
    // MARK: - @IBAction Properties
    @IBAction func touchDismissFloatingButton(_ sender: Any) {
        floatingButton.isHidden = true
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerXib()
        setNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        floatingButton.isHidden = false
    }
}

// MARK: - Extensions
extension HomeViewController {
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        floatingButtonLabel.font = .subhead2
        homeTableView.dataSource = self
        homeTableView.delegate = self
        if #available(iOS 15, *) {
            homeTableView.sectionHeaderTopPadding = 0
        }
        
        latestPhotosWithAPI()
    }
    
    private func registerXib() {
        homeTableView.register(WelcomeTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.welcomeTableViewCell)
        homeTableView.register(TabBarTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.tabBarTableViewCell)
        homeTableView.register(MapTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.mapTableViewCell)
        homeTableView.register(PhotosTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.photosTableViewCell)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToFilmRollViewController(_:)), name: .pushToFilmRollViewController, object: nil)
    }
    
    // MARK: - @objc Methods
    @objc func pushToFilmRollViewController(_ notification: Notification) {
        self.navigationController?.pushViewController(FilmRollViewController(), animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 137
        case 1 :
            return 81
        case 2 :
            return 249
        case 3 :
            return 209
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            guard let welcomeCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.welcomeTableViewCell, for: indexPath) as? WelcomeTableViewCell else {
                return UITableViewCell()
            }
            
            return welcomeCell
        case 1 :
            guard let tabBarCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.tabBarTableViewCell, for: indexPath) as? TabBarTableViewCell else {
                return UITableViewCell()
            }
            tabBarCell.pushToAddPhotoViewController = {
                self.navigationController?.pushViewController(AddPhotoViewController(), animated: true)
            }
            
            tabBarCell.pushToFilmRollViewController = {
                self.navigationController?.pushViewController(FilmRollViewController(), animated: true)
            }
            
            tabBarCell.pushToStudioMapViewController = {
                self.navigationController?.pushViewController(StudioMapViewController(), animated: true)
            }
            
            tabBarCell.pushToMyPageViewController = {
                self.navigationController?.pushViewController(MyPageViewController(), animated: true)
            }
            return tabBarCell
        case 2 :
            guard let mapCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.mapTableViewCell, for: indexPath) as? MapTableViewCell else {
                return UITableViewCell()
            }
            
            mapCell.selectionStyle = .none
            return mapCell
        case 3 :
            guard let photosCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.photosTableViewCell, for: indexPath) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            
            photosCell.selectionStyle = .none
            return photosCell
        default:
            return UITableViewCell()
        }
        
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2 :
            self.navigationController?.pushViewController(StudioMapViewController(), animated: true)
        default:
            return 
        }
    }
    
}

// MARK: - Network
extension HomeViewController {
    func latestPhotosWithAPI() {
        HomeAPI.shared.latestPhotos { response in
            switch response {
            case .success(let data):
                if let photos = data as? PhotosResponse {
//                    self.newPhotos = photos
//                    self.homeTableView.reloadData()
                    print("photos")
                    print(photos)
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
