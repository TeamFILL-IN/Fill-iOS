//
//  ArrowCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/13.
//

import UIKit

class ArrowCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.arrowCollectionViewCell, bundle: Bundle(for: ArrowCollectionViewCell.self))
    }
    
}
