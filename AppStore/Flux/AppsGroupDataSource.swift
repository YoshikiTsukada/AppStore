//
//  AppsGroupDataSource.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import UIKit

final class AppsGroupDataSource: NSObject {
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

extension AppsGroupDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHandler.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .appsGroupHeader?:
            return 0
        case .appsGroup?:
            return appsGroupStore.appsGroups.count
        default: return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return UICollectionViewCell()
        case .appsGroup?:
//            let appsGroup = appsGroupStore.appsGroups[indexPath.item]
//            let cell = AppsGroupCell.dequeue(from: collectionView, for: indexPath, with: appsGroup)
            let cell = AppsGroupCell.dequeue(from: collectionView, for: indexPath, with: appsGroupStore)
//            cell.delegate = self
            cell.titleConversion()
            return cell
        default: return UICollectionViewCell()
        }
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return .zero
        case .appsGroup?:
            return .init(width: width, height: IntroductionVC.DataSet.appsGroupCellHeight)
        default: return .zero
        }
    }
}

extension AppsGroupDataSource {
    private enum SectionHandler: Int, CaseIterable {
        case appsGroupHeader
        case appsGroup

        static var appsGroupSection: Int {
            return appsGroup.rawValue
        }

        init?(_ section: Int) {
            switch section {
            case type(of: self).appsGroupHeader.rawValue: self = .appsGroupHeader
            case type(of: self).appsGroup.rawValue: self = .appsGroup
            default: return nil
            }
        }
    }
}

extension AppsGroupDataSource: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppsGroupCell.self,
        ]
    }
}
