//
//  AppDetailsSectionHeaderCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/11/26.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import UIKit

final class AppDetailsSectionHeaderCell : UICollectionReusableView, CollectionReusableViewPresenter {
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    
    //
    // MARK: CollectionReusableViewPresenter
    //
    
    typealias T = Int
    var data: Int?
    
    func apply(with data: Int?) {
        guard let section = data else { return }
        
        var (title, buttonTitle): (String, String)
        switch section {
        case SectionHandler.reviews.rawValue:
            (title, buttonTitle) = ("評価とレビュー", "全て表示")
        case SectionHandler.update.rawValue:
            (title, buttonTitle) = ("アップデート", "バージョン履歴")
        case SectionHandler.information.rawValue:
            (title, buttonTitle) = ("情報", "")
        default:
            (title, buttonTitle) = ("", "")
        }
        
        sectionTitleLabel.text = title
        rightButton.setTitle(buttonTitle, for: .normal)
    }
}

extension AppDetailsSectionHeaderCell {
    private enum SectionHandler : Int {
        case header
        case images
        case text
        case reviews
        case update
        case information
    }
}
