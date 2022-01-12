//
//  HomeViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/09.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

extension HomeViewController {
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
