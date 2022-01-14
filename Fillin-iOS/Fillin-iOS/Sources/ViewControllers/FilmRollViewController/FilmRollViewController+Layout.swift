//
//  FilmRollViewController+Layout.swift
//  Fillin-iOS
//
//  Created by Yi Joon Choi on 2022/01/14.
//

import Foundation
import UIKit

extension FilmRollViewController {
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch FilmRollSection.allCases[sectionIndex] {
            case .filmCuration:        return self?.filmCurationSectionLayout()
            case .filmType:       return self?.filmTypeSectionLayout()
            case .filmRoll:       return self?.filmRollSectionLayout()
            }
        }
    }
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(46)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
    }
    
    func filmCurationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(165),
                heightDimension: .absolute(124))
        )
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 9)
    
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(165),
                heightDimension: .estimated(124)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 18, bottom: 23, trailing: 0)
        return section
    }
    
    func filmTypeSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(91))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(91)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = []
        return section
    }
    
    func filmRollSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            ),
            subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 9, leading: 9, bottom: 0, trailing: 9
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = []
        return section
    }
    
}
