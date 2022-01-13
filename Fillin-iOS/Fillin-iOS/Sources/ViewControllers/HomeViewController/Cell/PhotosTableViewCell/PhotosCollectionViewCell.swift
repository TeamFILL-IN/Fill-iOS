//
//  PhotosCollectionViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/13.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.photosCollectionViewCell, bundle: Bundle(for: PhotosCollectionViewCell.self))
    }
}
