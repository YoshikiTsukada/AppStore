//
//  AppDetailsReviewsCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsReviewsCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var averageRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerAllCollectionViewCells(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func apply(ratingLabel appDetails: AppDetails?) {
        guard let rating = appDetails?.averageUserRating else { return }
        
        averageRatingLabel.text = String(rating)
    }
    
    static func estimatedSize(with width: CGFloat) -> CGSize {
        return .init(width: width, height: 375)
    }
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = [Review]
    var data: [Review]?
    
    func apply(with data: [Review]?) {
        collectionView.reloadData()
    }
}

extension AppDetailsReviewsCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(data?.count ?? 0, 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let review = data?[indexPath.item]
        let cell = AppDetailsReviewCell.dequeue(from: collectionView, for: indexPath, with: review)
        return cell
    }
    //
    // MARK: UICollectionViewDelegate
    //
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20 * 2
        return AppDetailsReviewCell.estimatedSize(with: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension AppDetailsReviewsCell : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppDetailsReviewCell.self,
        ]
    }
}
