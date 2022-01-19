//
//  FilmCurationFirstCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/16.
//

import UIKit

class FilmCurationFirstCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var curationTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationFirstCollectionViewCell, bundle: Bundle(for: FilmCurationFirstCollectionViewCell.self))
    }

    private func setUI() {
        curationTitleLabel.font = .subhead2
        curationTitleLabel.numberOfLines = 2
        curationTitleLabel.lineBreakMode = .byWordWrapping
        curationTitleLabel.sizeToFit()
    }
}
