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
    var selectedFilm = ["필름 종류를 선택하세요",
                        "필름 종류를 선택하세요",
                        "필름 종류를 선택하세요",
                        "필름 종류를 선택하세요"]
    
    // MARK: - @IBOutlet Properties
    @IBOutlet var filmTypeButtons: [UIButton]!
    @IBOutlet weak var chooseFilmView: UIView!
    @IBOutlet weak var chooseFilmLabel: UILabel!
    @IBOutlet weak var chosenViewLeading: NSLayoutConstraint!
    
    // MARK: - @IBAction Properties
    @IBAction func touchFilmTypeButtons(_ sender: UIButton) {
        // TODO: 서버 붙이고 반복코드 리팩토링
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
            setSelectedFilm()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        setGesture()
        setNotification()
        setSelectedFilm()
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
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchChooseFilmView(_:)))
        chooseFilmView.isUserInteractionEnabled = true
        chooseFilmView.addGestureRecognizer(tapGesture)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedFilmType), name: Notification.Name.updateSelectedFilmType, object: nil)
    }
    
    private func setSelectedFilm() {
        chooseFilmLabel.text = selectedFilm[selectedTag]
        filmTypeButtons[selectedTag].isSelected = true
        chosenViewLeading.constant = selectedLeading
    }
    
    @objc func touchChooseFilmView(_ sender: UITapGestureRecognizer) {
        let selectedFilmDict = ["selectedTag": selectedTag, "selectedLeading": selectedLeading] as [String: Any]
        NotificationCenter.default.post(name: NSNotification.Name.pushToFilmSelectViewController, object: selectedFilmDict, userInfo: nil)
    }
    
    @objc func updateSelectedFilmType(_ notification: Notification) {
        // TODO: touchFilmTypeButtons에서도 사용되기 때문에 더러운 코드 리팩토링
        filmTypeButtons.forEach {
            $0.isSelected = false
        }
        let selectedFilmDict = notification.object as? NSDictionary
        selectedTag = selectedFilmDict?["selectedTag"] as? Int ?? 0
        selectedLeading = selectedFilmDict?["selectedLeading"] as? CGFloat ?? 0
        selectedFilm[selectedTag] = selectedFilmDict?["selectedFilm"] as? String ?? ""
        chooseFilmLabel.font = .engDisplay2Book
        setSelectedFilm()
    }
}
