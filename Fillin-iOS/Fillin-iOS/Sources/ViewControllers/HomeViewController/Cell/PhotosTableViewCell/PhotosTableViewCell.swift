//
//  PhotosTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        registerXib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: Const.Xib.photosTableViewCell, bundle: Bundle(for: PhotosTableViewCell.self))
    }
    
    private func setUI() {
        titleLabel.font = .engHead
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
    }
    
    private func registerXib() {
        photosCollectionView.register(PhotosCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.photosCollectionViewCell)
    }
}

extension PhotosTableViewCell: UICollectionViewDelegate {
    
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.photosCollectionViewCell, for: indexPath) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return photoCell
    }
    
}
