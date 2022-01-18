//
//  FilmSelectViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import UIKit

class FilmSelectViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: FilinNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Extensions
extension FilmSelectViewController {
    private func setUI() {
        
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
