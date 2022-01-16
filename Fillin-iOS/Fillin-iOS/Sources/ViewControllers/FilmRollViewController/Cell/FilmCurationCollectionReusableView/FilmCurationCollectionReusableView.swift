//
//  FilmCurationCollectionReusableView.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/15.
//

import UIKit

class FilmCurationCollectionReusableView: UICollectionReusableView {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationCollectionReusableView, bundle: Bundle(for: FilmCurationCollectionReusableView.self))
    }
    
    private func setUI() {
        titleLabel.font = .engHead
    }
}
