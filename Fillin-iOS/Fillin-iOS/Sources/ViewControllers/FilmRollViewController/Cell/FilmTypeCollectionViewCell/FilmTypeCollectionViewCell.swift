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
            case 1:
                chosenViewLeading.constant = viewWidth/4
            case 2:
                chosenViewLeading.constant = (viewWidth/4)*2
            case 3:
                chosenViewLeading.constant = (viewWidth/4)*3
            default:
                return
            }
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
        filmTypeButtons[0].isSelected = true
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchChooseFilmView(_:)))
        chooseFilmView.isUserInteractionEnabled = true
        chooseFilmView.addGestureRecognizer(tapGesture)
    }
    
    @objc func touchChooseFilmView(_ sender: UITapGestureRecognizer) {
         // TODO: 필름 종류 선택 뷰로 이동
        NotificationCenter.default.post(name: NSNotification.Name.pushToFilmSelectViewController, object: nil, userInfo: nil)
    }
}
