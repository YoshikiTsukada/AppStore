//
//  IntroductionListUpCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class IntroductionListUpCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var getButton: UIButton!
    
    var iconWidth: CGFloat {
        return IntroductionListUpVC.DataSet.iconImageWidth
    }
    
    func insertSectionLineIfNeeded(_ required: Bool) {
        guard required else { return }
        
        let xIndex = IntroductionListUpVC.DataSet.iconImageWidth + IntroductionListUpVC.DataSet.iconImageSpacing
        let frame = CGRect(
            x: self.bounds.origin.x + xIndex,
            y: self.bounds.origin.y + self.bounds.height - 1,
            width: self.bounds.width - xIndex,
            height: 0.5
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
    }

    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = Result
    var data: Result?
    
    func apply(with data: Result?) {
        iconImageView.image = nil
        guard let result = data else { return }
        
        titleLabel.text = result.name
        
        if let url = URL(string: result.artworkUrl100) {
            ImageClient.request(with: url) { image in
                let resizedImage = image?.resized(toWidth: self.iconWidth)
                DispatchQueue.main.async {
                    self.iconImageView.image = resizedImage
                }
            }
        }
    }
}
