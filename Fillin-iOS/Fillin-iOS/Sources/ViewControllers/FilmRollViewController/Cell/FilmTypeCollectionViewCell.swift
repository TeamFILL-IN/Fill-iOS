//
//  FilmTypeCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import UIKit

class FilmTypeCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet var filmTypeButtons: [UIButton]!
    @IBOutlet weak var chooseFilmView: UIView!
    @IBOutlet weak var chooseFilmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmTypeCollectionViewCell, bundle: Bundle(for: FilmTypeCollectionViewCell.self))
    }
    
    private func setUI() {
        filmTypeButtons.forEach{
            $0.titleLabel?.font = .subhead2
        }
        chooseFilmLabel.font = .body2
    }
}
