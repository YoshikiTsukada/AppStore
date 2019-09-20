//
//  AppsGroupCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/25.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit
import Foundation

protocol AppsGroupCellDelegate : class {
    var classType: String { get }
    func reload()
}

final class AppsGroupCell : UICollectionViewCell, ReusableCollectionViewCellPresenter {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var allDisplayButton: UIButton!
    @IBOutlet var appsCarousel: UIView!
    
    var appsCarouselView: AppsCarouselView?
    var delegate: AppsGroupCellDelegate?
    
    let titleLabelHeight: CGFloat = 20
    
    func setUpAppsCarouselView(with feed: Feed) {
        appsCarouselView?.removeFromSuperview()
        appsCarouselView = nil
        
        layoutIfNeeded()
        let view = AppsCarouselView(frame: appsCarousel.frame)
        view.data.results = feed.results
        view.delegate = self
        appsCarouselView = view
        contentView.addSubview(appsCarouselView!)
    }
    
    func insertSectionLine() {
        let frame = CGRect(
            x: self.bounds.origin.x + IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset,
            y: self.bounds.origin.y + self.bounds.height - 1,
            width: self.bounds.width - IntroductionVC.DataSet.appsCarouselCellHorizontalSectionInset * 2,
            height: 0.5
        )
        let view = UIView(frame: frame)
        view.backgroundColor = .lightGray
        contentView.addSubview(view)
    }
    
    func titleConversion() {
        titleLabel.text = TitleConversion(delegate?.classType, titleLabel.text)?.rawValue
    }
    
    //
    // MARK: ReusableCollectionViewCellPresenter
    //
    
    typealias T = Feed
    var data: Feed?
    
    func apply(with data: Feed) {
        let feed = data
        titleLabel.text = feed.title
        setUpAppsCarouselView(with: feed)
        insertSectionLine()
    }
}

extension AppsGroupCell {
    enum TitleConversion : String {
        case recommendedNewGames = "おすすめの新着ゲーム"
        case topFreeGames = "トップ無料ゲーム"
        case topPaidGames = "トップ有料ゲーム"
        case recommendedNewApps = "おすすめの新着App"
        case topFree = "トップ無料App"
        case ipadTopFree = "トップ無料iPad"
        case topSalesApp = "トップセールス"
        case ipadTopSales = "トップセールスiPad"
        case topPaid = "トップ有料"
        
        static let recommendedNewGamesTitle = "おすすめの新着ゲーム"
        static let topFreeGamesTitle = "Top Free iPhone Apps"
        static let topPaidGamesTitle = "Top Paid iPhone Apps"
        static let recommendedNewAppsTitle = "おすすめの新着App"
        static let topFreeTitle = "Top Free iPhone Apps"
        static let ipadTopFreeTitle = "Top Free iPad Apps"
        static let topSalesAppTitle = "Top Grossing iPhone Apps"
        static let ipadTopSalesTitle = "Top Grossing iPad Apps"
        static let topPaidTitle = "Top Paid iPhone Apps"
        
        init?(_ classType: String?, _ title: String?) {
            let game = String(describing: GamesIntroductionVC.self)
            let app = String(describing: AppsIntroductionVC.self)
            
            switch (classType, title) {
            case (game, type(of: self).recommendedNewGamesTitle): self = type(of: self).recommendedNewGames
            case (game, type(of: self).topFreeGamesTitle): self = type(of: self).topFreeGames
            case (game, type(of: self).topPaidGamesTitle): self = type(of: self).topPaidGames
            case (app, type(of: self).recommendedNewAppsTitle): self = type(of: self).recommendedNewApps
            case (app, type(of: self).topFreeTitle): self = type(of: self).topFree
            case (app, type(of: self).ipadTopFreeTitle): self = type(of: self).ipadTopFree
            case (app, type(of: self).topSalesAppTitle): self = type(of: self).topSalesApp
            case (app, type(of: self).ipadTopSalesTitle): self = type(of: self).ipadTopSales
            case (app, type(of: self).topPaidTitle): self = type(of: self).topPaid
            default: return nil
            }
        }
    }
}

extension AppsGroupCell : AppsCarouselViewDelegate {
    func reload() {
        delegate?.reload()
    }
}
