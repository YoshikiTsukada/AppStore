//
//  AppsCarouselDataSource.swift
//  AppStore
//
//  Created by Tsukada Yoshiki on 2020/04/03.
//

import UIKit

final class AppsCarouselDataSource: NSObject {
    private let groupStore: GroupStoreBase
    
    private let carouselIndex: IndexPath
    
    init(groupStore: GroupStoreBase, carouselIndex: IndexPath) {
        self.groupStore = groupStore
        self.carouselIndex = carouselIndex
    }
    
    func configure(_ collectionView: UICollectionView) {
        registerAllCollectionViewCells(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension AppsCarouselDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupStore.appsGroups[carouselIndex.item].apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let app = groupStore.appsGroups[carouselIndex.item].apps[indexPath.item]
        let cell = AppsCarouselCell.dequeue(from: collectionView, for: indexPath, with: groupStore)
        cell.apply(with: app)
        cell.insertSectionLineIfNeeded(indexPath.item % 3 != 2)
        return cell
    }
    
    //
    // MARK: UICollectionViewDelegate
    //
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = groupStore.appsGroups[carouselIndex.item].apps[indexPath.item]
        ActionCreator.showAppDetailsFromCarousel(app)
    }
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: IntroductionDataSet.appsCarouselCellWidth(width), height: IntroductionDataSet.appsCarouselCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = IntroductionDataSet.appsCarouselCellHorizontalSectionInset
        return .init(top: 0, left: spacing, bottom: 0, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return IntroductionDataSet.appsCarouselCellHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return IntroductionDataSet.appsCarouselCellVerticalSpacing
    }
}

extension AppsCarouselDataSource: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppsCarouselCell.self,
        ]
    }
}
