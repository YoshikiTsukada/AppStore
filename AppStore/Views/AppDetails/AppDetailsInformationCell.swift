//
//  AppDetailsInformationCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsInformationCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    private var cellKind: CellKindPresenter?
    
//    var isTapEnable: Bool? {
//        return cellKind?.isTapEnable
//    }
    
    var title: String? {
        return cellKind?.title
    }
    
    static func estimatedSize(with width: CGFloat) -> CGSize {
        return .init(width: width, height: 50)
    }

    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = (App, CellKindPresenter)
    var data: (App, CellKindPresenter)?
    
    func apply(with data: (App, CellKindPresenter)?) {
        cellKind = data?.1
        titleLabel.text = title
        
        guard let app = data?.0.results.first else { return }
        
        switch cellKind {
        case .distributor:
            itemLabel.text = app.sellerName
        case .dataSize:
            itemLabel.text = "\(app.fileSizeBytes)Bytes"
        case .category:
            itemLabel.text = app.genres.first
        case .compatible:
            itemLabel.text = app.supportedDevices.first
        case .language:
            itemLabel.text = app.languageCodesISO2A.first
        case .ageLimit:
            itemLabel.text = app.contentAdvisoryRating
        case .billing:
            itemLabel.text = "なし"
        default: break
        }
    }
}

extension AppDetailsInformationCell {
    enum CellKindPresenter : Int, CaseIterable {
        case distributor
        case dataSize
        case category
        case compatible
        case language
        case ageLimit
        case billing

        init?(_ index: Int) {
            switch index {
            case type(of: self).distributor.rawValue: self = .distributor
            case type(of: self).dataSize.rawValue: self = .dataSize
            case type(of: self).category.rawValue: self = .category
            case type(of: self).compatible.rawValue: self = .compatible
            case type(of: self).language.rawValue: self = .language
            case type(of: self).ageLimit.rawValue: self = .ageLimit
            case type(of: self).billing.rawValue: self = .billing
            default: return nil
            }
        }
        
//        var isTapEnable: Bool {
//            switch self {
//            case .distributor, .dataSize:
//                return false
//            case .category, .compatible, .language, .ageLimit, .billing:
//                return true
//            default: return false
//            }
//        }
        
        var title: String {
            switch self {
            case .distributor:
                return "販売元"
            case .dataSize:
                return "サイズ"
            case .category:
                return "カテゴリ"
            case .compatible:
                return "互換性"
            case .language:
                return "言語"
            case .ageLimit:
                return "年齢制限"
            case .billing:
                return "App内課金"
            default: return ""
            }
        }
    }
}
