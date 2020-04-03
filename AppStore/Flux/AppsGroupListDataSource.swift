//
//  AppsGroupListDataSource.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/04/01.
//

import UIKit

final class AppsGroupListDataSource: NSObject {
    private let groupStore: GroupStoreBase

    init(groupStore: GroupStoreBase) {
        self.groupStore = groupStore
    }

    func configure(_ collectionView: UICollectionView) {
        registerAllCollectionViewCells(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension AppsGroupListDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupStore.appsGroups[groupStore.selectedIndex.item].apps.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = IntroductionListUpCell.dequeue(from: collectionView, for: indexPath, with: groupStore)
        cell.insertSectionLineIfNeeded(indexPath.item - 1 < groupStore.appsGroups[groupStore.selectedIndex.item].apps.count)
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = groupStore.appsGroups[groupStore.selectedIndex.item].apps[indexPath.item]
        ActionCreator.showAppDetailsFromList(app)
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: IntroductionListUpVC.DataSet.cellWidth(width), height: IntroductionListUpVC.DataSet.cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return IntroductionListUpVC.DataSet.cellEdge
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return IntroductionListUpVC.DataSet.cellSpacing
    }
}

extension AppsGroupListDataSource: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            IntroductionListUpCell.self,
        ]
    }
}
