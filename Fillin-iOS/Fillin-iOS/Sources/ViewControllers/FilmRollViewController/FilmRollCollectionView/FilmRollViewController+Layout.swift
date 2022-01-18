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
        let firstItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
        )
        firstItem.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 9)
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(165),
                heightDimension: .fractionalHeight(1))
        )
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 9)
    
        let firstGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(108),
                heightDimension: .fractionalHeight(1)),
            subitem: firstItem, count: 1)
        
        let secondGroup = NSCollectionLayoutGroup.horizontal(
            // TODO: 5 데이터 갯수로 바꿔주세요.
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(165 * CGFloat(dataSource.serverCuration?.photos.count ?? 0)),
                heightDimension: .fractionalHeight(1)),
            subitem: item, count: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                // TODO: 5 데이터 갯수로 바꿔주세요.
                widthDimension: .absolute(165 * CGFloat(dataSource.serverCuration?.photos.count ?? 0) + 108),
                heightDimension: .absolute(124)),
            subitems: [firstGroup, secondGroup])
        
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
        let shorterItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(165)
            )
        )
        shorterItem.contentInsets = .init(
            top: 0, leading: 4.5, bottom: 9, trailing: 4.5
        )
        
        let longerItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(256)
            )
        )
        longerItem.contentInsets = .init(
            top: 0, leading: 4.5, bottom: 9, trailing: 4.5
        )

        let leftGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(165*5)
            ),
            subitem: shorterItem, count: 5)
        
        let rightGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(256*5)
            ),
            subitem: longerItem, count: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(256*5)
            ),
            subitems: [leftGroup, rightGroup])

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = []
        section.contentInsets = .init(top: 18, leading: 13.5, bottom: 23, trailing: 13.5)
        return section
    }
    
}
