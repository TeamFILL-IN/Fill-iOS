//
//  FilmCurationCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import UIKit

class FilmCurationCollectionViewCell: UICollectionViewCell {

    var isLiked = false
    
    @IBOutlet weak var filmCurationImageView: UIImageView!
    @IBOutlet weak var photoLikeButton: UIButton!
    
    @IBAction func touchLikeButton(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.filmCurationCollectionViewCell, bundle: Bundle(for: FilmCurationCollectionViewCell.self))
    }
    
    private func setUI() {
        photoLikeButton.isSelected = isLiked
    }
    
    override func prepareForReuse() {
        photoLikeButton.isSelected = false
    }

}
