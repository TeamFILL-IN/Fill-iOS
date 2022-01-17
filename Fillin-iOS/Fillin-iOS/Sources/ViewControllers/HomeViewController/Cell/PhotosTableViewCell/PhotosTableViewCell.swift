//
//  PhotosTableViewCell.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/12.
//

import UIKit
import Kingfisher

class PhotosTableViewCell: UITableViewCell {

    // MARK: - Properties
    var serverNewPhotos: PhotosResponse?
    
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
        photosCollectionView.register(ArrowCollectionViewCell.nib(), forCellWithReuseIdentifier: Const.Xib.arrowCollectionViewCell)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat

        switch indexPath.row {
        case 8:
            width = 65
            height = collectionView.frame.size.height
        default:
            width = 107
            height = collectionView.frame.size.height
        }

        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1 + (serverNewPhotos?.photos.count ?? 0)
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 8:
            guard let arrowCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.arrowCollectionViewCell, for: indexPath) as? ArrowCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return arrowCell
        default:
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.photosCollectionViewCell, for: indexPath) as? PhotosCollectionViewCell else {
                return UICollectionViewCell()
            }
            
//            photoCell.photoImageView.updateServerImage(serverNewPhotos?.photos[indexPath.row].imageURL ?? "")
            
            photoCell.photoImageView.updateServerImage("https://mblogthumb-phinf.pstatic.net/MjAxODAzMTRfMjcz/MDAxNTIwOTU0NTM4MDY1.5WmSbdqE3GMfHq8dwgRjPUFFUVf6Q5XwpIFc-_JZfpkg.vZDTqlsDfLQOAB7qQfdNHhEuGNk6umQox1WRjKPWriYg.JPEG.kj_8/20160901_57c7ce9428fe6.jpg?type=w2")

            return photoCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 8:
            NotificationCenter.default.post(name: .pushToFilmRollViewController, object: nil)
        default:
            return
        }
    }
    
}

// MARK: - UICollectionViewDelegate
extension PhotosTableViewCell: UICollectionViewDelegate {
    
}

// MARK: - Network
extension PhotosTableViewCell {
    func updateNewPhotos(data: PhotosResponse) {
        serverNewPhotos = data
        photosCollectionView.reloadData()
    }
}
