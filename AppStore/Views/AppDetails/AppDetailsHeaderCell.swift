//
//  AppDetailsHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsHeaderCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var billingLabel: UILabel!
    @IBOutlet weak var reviewAmountLabel: UILabel!
    @IBOutlet weak var targetAgeLabel: UILabel!
    
    static let iconWidth: CGFloat = 110
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
        guard let result = data?.results.first else { return }
        
        titleLabel.text = result.trackName
        companyNameLabel.text = result.sellerName
        getButton.setTitle(result.formattedPrice, for: .normal)
        reviewAmountLabel.text = "\(result.userRatingCount)件の評価"
        targetAgeLabel.text = result.trackContentRating
        
        if let url = URL(string: result.artworkUrl100) {
            ImageClient.request(with: url) { image in
                let resizedImage = image?.resized(toWidth: type(of: self).iconWidth)
                DispatchQueue.main.async {
                    self.iconImageView.image = resizedImage
                }
            }
        }
    }
}
