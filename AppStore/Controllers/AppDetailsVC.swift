//
//  AppDetailsVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import UIKit

class AppDetailsVC : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: DataSet = .empty
    var cellSize: CellSizePresenter = .empty
    
    var firstImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerAllCollectionViewCells(to: collectionView)
        fetchAppDetails()
    }
    
    override func loadView() {
        if let view = UINib(nibName: String(describing: AppDetailsVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    func fetchAppDetails() {
        guard let id = data.id else { return }
        
        let width: CGFloat = UIScreen.main.bounds.width - 40
        let url: URL = URLMaker.detail(id: id)
        APIClient.parseJson(from: url) { (response: App) in
            self.data.app = response
            self.fetchImage(width: width)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func fetchImage(width: CGFloat) {
        guard let urlString = data.app?.results.first?.screenshotUrls.first else { return }
        
        if let url = URL(string: urlString) {
            ImageClient.request(with: url) { image in
                guard let image = image else { return }
                
                if image.size.width > image.size.height {
                    self.firstImage = image.resized(toWidth: width)
                }
                else {
                    self.firstImage = image.resized(toWidth: width * 2 / 3)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadSections([SectionHandler.imagesSection])
                }
            }
        }
    }
}

extension AppDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHandler.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SectionHandler.defaultNumberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let app = data.app
        switch SectionHandler(indexPath.section) {
        case .header:
            let cell = AppDetailsHeaderCell.dequeue(from: collectionView, for: indexPath, with: app)
            return cell
        case .images:
            let cell = AppDetailsImagesCell.dequeue(from: collectionView, for: indexPath, with: app)
            cell.firstImage = firstImage
            cell.delegate = self
            return cell
        case .text:
            let cell = AppDetailsTextCell.dequeue(from: collectionView, for: indexPath, with: app)
            cell.buttonTapped = cellSize.showMoreButtonTapped
            cell.delegate = self
            return cell
        case .reviews:
            let cell = AppDetailsReviewsCell.dequeue(from: collectionView, for: indexPath, with: app)
            return cell
        case .update:
            let cell = AppDetailsUpdateCell.dequeue(from: collectionView, for: indexPath, with: app)
            return cell
        case .information:
            let cell = AppDetailsInformationCell.dequeue(from: collectionView, for: indexPath, with: app)
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = SectionHandler(indexPath.section)
        
        switch section {
        case .reviews, .update, .information:
            let cell = AppDetailsSectionHeaderCell.dequeue(from: collectionView, of: kind, for: indexPath, with: section?.rawValue)
            return cell
        default: return UICollectionReusableView()
        }
    }

    //
    // MARK: UICollectionViewDelegate
    //
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        switch SectionHandler(indexPath.section) {
        case .header:
            return .init(width: width, height: 190)
        case .images:
            return AppDetailsImagesCell.estimatedSize(width: width, image: firstImage)
        case .text:
            return AppDetailsTextCell.estimatedSize(width: width, height: cellSize.textCellHeight)
        case .reviews:
            return .init(width: width, height: 190)
        case .update:
            return .init(width: width, height: 190)
        case .information:
            return .init(width: width, height: 190)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        
        switch SectionHandler(section) {
        case .reviews, .update, .information:
            return .init(width: width, height: 40)
        default: return .zero
        }
    }
}

extension AppDetailsVC {
    struct DataSet {
        var id: String?
        var app: App?
        static let empty: DataSet = .init()
    }
}

extension AppDetailsVC {
    struct CellSizePresenter {
        var textCellHeight: CGFloat = 190
        var showMoreButtonTapped: Bool = false
        static let empty: CellSizePresenter = .init()
    }
}

extension AppDetailsVC {
    private enum SectionHandler : Int, CaseIterable {
        case header
        case images
        case text
        case reviews
        case update
        case information
        
        static var imagesIndexPath: IndexPath {
            return .init(item: defaultNumberOfItems - 1, section: imagesSection)
        }
        
        static var imagesSection: Int {
            return images.rawValue
        }
        
        static var textSection: Int {
            return text.rawValue
        }
        
        static let defaultNumberOfItems = 1
        
        init?(_ section: Int) {
            switch section {
            case type(of: self).header.rawValue: self = .header
            case type(of: self).images.rawValue: self = .images
            case type(of: self).text.rawValue: self = .text
            case type(of: self).reviews.rawValue: self = .reviews
            case type(of: self).update.rawValue: self = .update
            case type(of: self).information.rawValue: self = .information
            default: return nil
            }
        }
    }
}

extension AppDetailsVC : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppDetailsHeaderCell.self,
            AppDetailsImagesCell.self,
            AppDetailsTextCell.self,
            AppDetailsReviewsCell.self,
            AppDetailsUpdateCell.self,
            AppDetailsInformationCell.self,
        ]
    }
    
    var headerCellTypes: [UICollectionReusableView.Type] {
        return [
            AppDetailsSectionHeaderCell.self,
        ]
    }
}

extension AppDetailsVC : AppDetailsImageCellDelegate {
    func appDetailsImageCell(estimatedSize size: CGSize?) {
    }
}

extension AppDetailsVC : AppDetailsTextCellDelegate {
    func appDetailsTextCell(labelSizeToFit height: CGFloat) {
        cellSize.textCellHeight += height
        cellSize.showMoreButtonTapped = true
        collectionView.reloadSections([SectionHandler.textSection])
    }
}
