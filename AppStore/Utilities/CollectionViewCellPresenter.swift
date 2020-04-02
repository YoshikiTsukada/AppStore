//
//  CollectionViewCellPresenter.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/13.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol CollectionViewCellPresenter: class {
    associatedtype StoreType

    var store: StoreType? { get set }
    var indexPath: IndexPath { get set }
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with store: StoreType?) -> Self
    func apply(with store: StoreType?)
}

extension CollectionViewCellPresenter where Self: UICollectionViewCell, StoreType: StoreBase {
    var store: StoreType? { return nil }
    var indexPath: IndexPath { return [] }

    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with store: StoreType?) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! Self
        cell.store = store
        cell.indexPath = indexPath
        cell.apply(with: store)
        return cell
    }
}
