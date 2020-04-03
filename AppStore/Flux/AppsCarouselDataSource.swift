//
//  AppsCarouselDataSource.swift
//  AppStore
//
//  Created by Tsukada Yoshiki on 2020/04/03.
//

import UIKit

final class AppsCarouselDataSource: NSObject {
    private let actionCreator: ActionCreator
    private let appsCarouselStore: AppsCarouselStore
    
    init(actionCreator: ActionCreator, appsCarouselStore: AppsCarouselStore) {
        self.actionCreator = actionCreator
        self.appsCarouselStore = appsCarouselStore
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
        return appsCarouselStore.carouselApps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AppsCarouselCell.dequeue(from: collectionView, for: indexPath, with: appsCarouselStore)
        cell.insertSectionLineIfNeeded(indexPath.item % 3 != 2)
        return cell
    }
    
    //
    // MARK: UICollectionViewDelegate
    //
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
//        let id = data.apps[indexPath.item].id
//        delegate?.appsCarouselView(didSelectAppIdWith: id)
    }
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: IntroductionVC.DataSet.appsCarouselCellWidth(width), height: IntroductionVC.DataSet.appsCarouselCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let spacing = IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset
        return .init(top: 0, left: spacing, bottom: 0, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return IntroductionVC.DataSet.appsCarouselCellHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return IntroductionVC.DataSet.appsCarouselCellVerticalSpacing
    }
}

extension AppsCarouselDataSource: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppsCarouselCell.self,
        ]
    }
}
