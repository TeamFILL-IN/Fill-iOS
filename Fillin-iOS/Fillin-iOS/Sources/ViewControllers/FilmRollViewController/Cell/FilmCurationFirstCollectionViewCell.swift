//
//  FilmCurationFirstCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/16.
//

import UIKit

class FilmCurationFirstCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationFirstCollectionViewCell, bundle: Bundle(for: FilmCurationFirstCollectionViewCell.self))
    }

}
