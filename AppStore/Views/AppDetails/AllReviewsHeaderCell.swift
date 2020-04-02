//
//  AllReviewsHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import UIKit

final class AllReviewsHeaderCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var auxiliaryView: ReviewAuxiliaryView!

    static func estimatedSize(with width: CGFloat) -> CGSize {
        return .init(width: width, height: 150)
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias StoreType = AppsGroupStore
    var store: StoreType?
    var indexPath: IndexPath = []

    func apply(with store: StoreType?) {
//        let appDetails = data
//        auxiliaryView.apply(appDetails: appDetails)
    }
}
