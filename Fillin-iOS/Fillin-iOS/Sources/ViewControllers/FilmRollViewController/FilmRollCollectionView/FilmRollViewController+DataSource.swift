//
//  FilmRollViewController+DataSource.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import Foundation
import UIKit

class FilmRollViewControllerDataSource: NSObject, UICollectionViewDataSource {
    
    var serverCuration: CurationResponse?
    var serverPhotos: PhotosResponse?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch FilmRollSection.allCases[section] {
        case .filmCuration:
            return (serverCuration?.photos.count ?? 0) + 1
        case .filmType:
            return 1
        case .filmRoll:
            return serverPhotos?.photos.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch FilmRollSection.allCases[indexPath.section] {
        case .filmCuration:
            switch indexPath.row {
            case 0:
                guard let curationFirstCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmCurationFirstCollectionViewCell, for: indexPath) as? FilmCurationFirstCollectionViewCell else { return UICollectionViewCell() }
                
                curationFirstCell.curationTitleLabel.text = serverCuration?.curation.title

                return curationFirstCell
            default:
                guard let curationCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmCurationCollectionViewCell, for: indexPath) as? FilmCurationCollectionViewCell else { return UICollectionViewCell() }
                
                curationCell.filmCurationImageView.updateServerImage(serverCuration?.photos[indexPath.row-1].imageURL ?? "")
                return curationCell
            }
            
        case .filmType:
            guard let filmTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmTypeCollectionViewCell, for: indexPath) as? FilmTypeCollectionViewCell else { return UICollectionViewCell() }
            
            return filmTypeCell
            
        case .filmRoll:
            guard let filmRollCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmCurationCollectionViewCell, for: indexPath) as? FilmCurationCollectionViewCell else { return UICollectionViewCell() }

            filmRollCell.filmCurationImageView.updateServerImage(serverPhotos?.photos[indexPath.row].imageURL ?? "")
            return filmRollCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch FilmRollSection.allCases[indexPath.section] {
        case .filmCuration:
            guard let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: Const.Xib.filmCurationCollectionReusableView,
                for: indexPath
            ) as? FilmCurationCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            return view
        default: return UICollectionReusableView()
        }
        
    }
}
