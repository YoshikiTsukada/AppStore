//
//  AppDetailsImagesImageCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/05.
//

import Foundation
import UIKit

protocol AppDetailsImagesImageCellDelegate: class {
    func appDetailsImagesImageCell(estimatedSize size: CGSize?)
}

final class AppDetailsImagesImageCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var imageView: UIImageView!
    
    var delegate: AppDetailsImagesImageCellDelegate?
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = String
    var data: String?
    
    func apply(with data: String?) {
        guard let data = data else { return }
        
        if let url = URL(string: data) {
            ImageClient.request(with: url) { image in
                guard let image = image else { return }
                let resizedImage: UIImage?
                let width = UIScreen.main.bounds.width
                if image.size.width > image.size.height {
                    resizedImage = image.resized(toWidth: width)
                }
                else {
                    resizedImage = image.resized(toWidth: width * 2 / 3)
                }
                DispatchQueue.main.async {
                    self.imageView.image = resizedImage
                }
            }
        }
    }
}
