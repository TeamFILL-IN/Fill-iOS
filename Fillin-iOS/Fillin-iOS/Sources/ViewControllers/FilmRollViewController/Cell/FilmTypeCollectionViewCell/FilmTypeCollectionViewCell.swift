//
//  FilmTypeCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import UIKit

class FilmTypeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var viewWidth = UIScreen.main.bounds.width
    var selectedTag = 0
    var selectedLeading: CGFloat = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet var filmTypeButtons: [UIButton]!
    @IBOutlet weak var chooseFilmView: UIView!
    @IBOutlet weak var chooseFilmLabel: UILabel!
    @IBOutlet weak var chosenViewLeading: NSLayoutConstraint!
    
    // MARK: - @IBOutlet Properties
    @IBAction func touchFilmTypeButtons(_ sender: UIButton) {
        if !sender.isSelected {
            filmTypeButtons.forEach {
                $0.isSelected = false
            }
            sender.isSelected = !sender.isSelected
            switch sender.tag {
            case 0:
                chosenViewLeading.constant = 0
                selectedTag = 0
                selectedLeading = 0
            case 1:
                chosenViewLeading.constant = viewWidth/4
                selectedTag = 1
                selectedLeading = viewWidth/4
            case 2:
                chosenViewLeading.constant = (viewWidth/4)*2
                selectedTag = 2
                selectedLeading = (viewWidth/4)*2
            case 3:
                chosenViewLeading.constant = (viewWidth/4)*3
                selectedTag = 3
                selectedLeading = (viewWidth/4)*3
            default:
                return
            }
            chosenViewLeading.constant = selectedLeading
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setGesture()
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmTypeCollectionViewCell, bundle: Bundle(for: FilmTypeCollectionViewCell.self))
    }
    
    private func setUI() {
        filmTypeButtons.forEach {
            $0.titleLabel?.font = .subhead2
        }
        chooseFilmLabel.font = .body2
        filmTypeButtons[selectedTag].isSelected = true
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchChooseFilmView(_:)))
        chooseFilmView.isUserInteractionEnabled = true
        chooseFilmView.addGestureRecognizer(tapGesture)
    }
    
    @objc func touchChooseFilmView(_ sender: UITapGestureRecognizer) {
        // TODO: 필름 종류 선택 뷰로 이동
        let selectedFilmDict = ["selectedTag": selectedTag, "selectedLeading": selectedLeading] as [String: Any]
        NotificationCenter.default.post(name: NSNotification.Name.pushToFilmSelectViewController, object: selectedFilmDict, userInfo: nil)
    }
}
