//
//  AppDetailsReviewCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/17.
//

import UIKit

final class AppDetailsReviewCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
    }
}
