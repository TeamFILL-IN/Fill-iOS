//
//  FilmCurationCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import UIKit

class FilmCurationCollectionViewCell: UICollectionViewCell {

    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationCollectionViewCell, bundle: Bundle(for: FilmCurationCollectionViewCell.self))
    }

}
