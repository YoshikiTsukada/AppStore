//
//  CollectionViewRegister.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/13.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import UIKit

protocol CollectionViewRegister : class {
    var cellTypes: [UICollectionViewCell.Type] { get }
    func registerAllCollectionViewCells(to collectionView: UICollectionView)
    func registerCollectionViewCell(to collectionView: UICollectionView, cellType: UICollectionViewCell.Type)
}

extension CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] { return [] }
    
    func registerAllCollectionViewCells(to collectionView: UICollectionView) {
        cellTypes.forEach { cellType in
            registerCollectionViewCell(to: collectionView, cellType: cellType)
        }
    }
    
    func registerCollectionViewCell(to collectionView: UICollectionView, cellType: UICollectionViewCell.Type) {
        let typeString = String(describing: cellType)
        collectionView.register(UINib(nibName: typeString, bundle: nil), forCellWithReuseIdentifier: typeString)
    }
}
