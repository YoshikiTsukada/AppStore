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

    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
        guard let result = data?.results.first else { return }
        
        averageRatingLabel.text = String(result.averageUserRating)
    }
}

extension AppDetailsReviewsCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension AppDetailsReviewsCell : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppDetailsReviewCell.self,
        ]
    }
}
