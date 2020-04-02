//
//  AppsGroupListDataSource.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/04/01.
//

import UIKit

final class AppsGroupListDataSource: NSObject {
    private let actionCreator: ActionCreator
    private let appsGroupStore: AppsGroupStore

    init(actionCreator: ActionCreator, appsGroupStore: AppsGroupStore) {
        self.actionCreator = actionCreator
        self.appsGroupStore = appsGroupStore
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
        return appsGroupStore.selectedAppsGroup?.apps.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = IntroductionListUpCell.dequeue(from: collectionView, for: indexPath, with: appsGroupStore)
        cell.insertSectionLineIfNeeded(indexPath.item - 1 < appsGroupStore.selectedAppsGroup?.apps.count ?? 0)
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = appsGroupStore.selectedAppsGroup?.apps[indexPath.item] else { return }
        actionCreator.showAppDetails(app)
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
