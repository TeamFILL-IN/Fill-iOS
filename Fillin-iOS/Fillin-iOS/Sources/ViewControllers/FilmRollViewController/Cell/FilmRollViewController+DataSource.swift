//
//  FilmRollViewController+DataSource.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import Foundation
import UIKit

final class FilmRollViewControllerDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch FilmRollSection.allCases[section] {
            // TODO: data 갯수
        case .filmCuration:   return 5
        case .filmType:   return 1
        case .filmRoll:   return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch FilmRollSection.allCases[indexPath.section] {
        case .filmCuration:
            guard let curationCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmCurationCollectionViewCell, for: indexPath) as? FilmCurationCollectionViewCell else { return UICollectionViewCell() }

            return curationCell
            
        case .filmType:
            guard let curationCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmTypeCollectionViewCell, for: indexPath) as? FilmTypeCollectionViewCell else { return UICollectionViewCell() }

            return curationCell
            
        case .filmRoll:
            guard let curationCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Xib.filmCurationCollectionViewCell, for: indexPath) as? FilmCurationCollectionViewCell else { return UICollectionViewCell() }

            return curationCell
        }
    }
}
