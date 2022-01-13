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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNavigationBar()
    }
    
}

extension FilmRollViewController {
    private func setUI() {
        
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
