//
//  HomeViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        registerXib()
    }
}

// MARK: - Extensions
extension HomeViewController {
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        homeTableView.dataSource = self
        homeTableView.delegate = self
        if #available(iOS 15, *) {
            homeTableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func registerXib() {
        homeTableView.register(WelcomeTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.welcomeTableViewCell)
        homeTableView.register(TabBarTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.tabBarTableViewCell)
        homeTableView.register(MapTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.mapTableViewCell)
        homeTableView.register(PhotosTableViewCell.nib(), forCellReuseIdentifier: Const.Xib.photosTableViewCell)
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
            return 136
        case 1 :
            return 80
        case 2 :
            return 248
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
                let nextVC = AddPhotoViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            tabBarCell.pushToFilmRollViewController = {
                let nextVC = FilmRollViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            tabBarCell.pushToStudioMapViewController = {
                let nextVC = StudioMapViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            
            tabBarCell.pushToMyPageViewController = {
                let nextVC = MyPageViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
            return tabBarCell
        case 2 :
            guard let mapCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.mapTableViewCell, for: indexPath) as? MapTableViewCell else {
                return UITableViewCell()
            }
            
            return mapCell
        case 3 :
            guard let photosCell = tableView.dequeueReusableCell(withIdentifier: Const.Xib.photosTableViewCell, for: indexPath) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            
            return photosCell
        default:
            return UITableViewCell()
        }
        
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}
