//
//  AppsCarouselCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/30.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

final class AppsCarouselCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var getButton: UIButton!

    var iconWidth: CGFloat {
        return IntroductionDataSet.appsCarouselImageWidth
    }

    func insertSectionLineIfNeeded(_ required: Bool) {
        guard required else { return }

        let xIndex = IntroductionDataSet.appsCarouselImageWidth + IntroductionDataSet.appsCarouselImageSpacing
        let frame = CGRect(
            x: bounds.origin.x + xIndex,
            y: bounds.origin.y + bounds.height - 1,
            width: bounds.width - xIndex,
            height: 0.5
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
    }

    func apply(with app: App) {
        iconImageView.image = nil
        titleLabel.text = app.name
        if let url = URL(string: app.iconUrl) {
            iconImageView.kf.setImage(with: url)
        }
    }

    //
    // MARK: CollectionViewCellPresenter
    //

    typealias StoreType = GroupStoreBase
    var store: StoreType?
    var indexPath: IndexPath = []

    func apply(with store: StoreType?) {}
}
