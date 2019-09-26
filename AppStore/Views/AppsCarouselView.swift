//
//  AppsCarouselView.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/26.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit
import Foundation

protocol AppsCarouselViewDelegate : class {
}

class AppsCarouselView : UIView {
    var collectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        registerAllCollectionViewCells(to: collectionView)
        return collectionView
    }
    
    var data: DataSet = .empty
    var delegate: AppsCarouselViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionView() {
        addSubview(collectionView)
        print("setupCollectionView")
    }
}

extension AppsCarouselView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard data.results.count > 0 else { return UICollectionViewCell() }
        
        let results = data.results[indexPath.row]
        let cell = AppsCarouselCell.dequeue(from: collectionView, for: indexPath, with: results)
        cell.insertSectionLineIfNeeded(indexPath.row % 3 != 2)
        return cell
    }
}

extension AppsCarouselView : UICollectionViewDelegateFlowLayout {
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

extension AppsCarouselView {
    struct DataSet {
        var results: [Result] = []
        static let empty: DataSet = .init()
    }
}

extension AppsCarouselView : CollectionViewCellRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppsCarouselCell.self
        ]
    }
}
