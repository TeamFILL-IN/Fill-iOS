//
//  FilmSelectViewController.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/19.
//

import UIKit

class FilmSelectViewController: UIViewController {
    
    // MARK: - Properties
    var viewWidth = UIScreen.main.bounds.width
    var selectedTag = 0
    var selectedLeading: CGFloat = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var navigationBar: FilinNavigationBar!
    @IBOutlet var filmTypeButtons: [UIButton]!
    @IBOutlet weak var chosenViewLeading: NSLayoutConstraint!
    @IBOutlet weak var filmTypeTableView: UITableView!
    
    // MARK: - @IBAction Properties
    @IBAction func touchFilmTypeButtons(_ sender: UIButton) {
        if !sender.isSelected {
            filmTypeButtons.forEach {
                $0.isSelected = false
            }
            sender.isSelected = !sender.isSelected
            // TODO: 서버 붙이고 반복코드 리팩토링
            switch sender.tag {
            case 0:
                selectedTag = 0
                selectedLeading = 0
            case 1:
                selectedTag = 1
                selectedLeading = viewWidth/4
            case 2:
                selectedTag = 2
                selectedLeading = (viewWidth/4)*2
            case 3:
                selectedTag = 3
                selectedLeading = (viewWidth/4)*3
            default:
                return
            }
            chosenViewLeading.constant = selectedLeading
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigationBar()
    }
}
// MARK: - Extensions
extension FilmSelectViewController {
    private func setUI() {
        filmTypeButtons.forEach {
            $0.titleLabel?.font = .subhead2
        }
        filmTypeButtons[selectedTag].isSelected = true
        chosenViewLeading.constant = selectedLeading
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        navigationBar.popViewController = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
