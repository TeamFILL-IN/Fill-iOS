//
//  FilmCurationCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import UIKit

class FilmCurationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var filmCurationImageView: UIImageView!
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationCollectionViewCell, bundle: Bundle(for: FilmCurationCollectionViewCell.self))
    }

}
