//
//  AppDetailsImagesCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol AppDetailsImageCellDelegate: class {
    func appDetailsImageCell(estimatedSize size: CGSize?)
}

final class AppDetailsImagesCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var firstImage: UIImage?
    
    var delegate: AppDetailsImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        registerAllCollectionViewCells(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    static func estimatedSize(width: CGFloat, image: UIImage?) -> CGSize {
        guard let size = image?.size else { return .zero }
        
        return .init(width: width, height: size.height + 21)
    }
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
        collectionView.reloadData()
    }
}

extension AppDetailsImagesCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //
    // MARK: UICollectionViewDataSource
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.results.first?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let url = data?.results.first?.screenshotUrls[indexPath.item] else { return UICollectionViewCell()}
        
        let cell = AppDetailsImagesImageCell.dequeue(from: collectionView, for: indexPath, with: url)
        cell.delegate = self
        return cell
    }
    
    //
    // MARK: UICollectionViewDelegate
    //
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return firstImage?.size ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension AppDetailsImagesCell : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
             AppDetailsImagesImageCell.self,
        ]
    }
}

extension AppDetailsImagesCell : AppDetailsImagesImageCellDelegate {
    func appDetailsImagesImageCell(estimatedSize size: CGSize?) {
    }
}
