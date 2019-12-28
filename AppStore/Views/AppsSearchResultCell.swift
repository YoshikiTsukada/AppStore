//
//  AppsSearchResultCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/28.
//

import UIKit

final class AppsSearchResultCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var reviewAmountLabel: UILabel!
    @IBOutlet weak var imagesBackView: UIView!
    @IBOutlet weak var getButton: UIButton!
    
    var firstImage: UIImage?
    var imageWidth: CGFloat? {
        return firstImage?.size.width
    }
    
    var images: [UIImage]?
    
    var numberOfImages: Int?

    func addImagesToBackView() {
        DispatchQueue.main.async {
            let imageView = UIImageView(image: self.firstImage)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            self.imagesBackView.addSubview(imageView)
        }
        
        if numberOfImages == 3 {
            guard data?.screenshotUrls.count ?? 0 >= 3 else { return }
            
            [data?.screenshotUrls[1], data?.screenshotUrls[2]].enumerated().forEach { index, urlString in
                if let url = URL(string: urlString ?? "") {
                    ImageClient.request(with: url) { image in
                        let resizedImage = image?.resized(toWidth: self.firstImage?.size.width ?? 100)
                        DispatchQueue.main.async {
                            let imageView = UIImageView(image: resizedImage)
                            imageView.clipsToBounds = true
                            imageView.layer.cornerRadius = 10
                            imageView.frame.origin.x += CGFloat(index + 1) * (self.imageWidth! + 10)
                            self.imagesBackView.addSubview(imageView)
                        }
                    }
                }
            }
        }
    }
    
    func removeAllSubviews(parentView: UIView) {
        parentView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
    static func estimatedSize(with width: CGFloat) -> CGSize {
        let cellWidth = width - 20 * 2
        let backViewHeight = (cellWidth - 10 * 2) / 3 * (667 / 375)
        let cellHeight = 80 + 20 + backViewHeight
        return .init(width: cellWidth, height: cellHeight)
    }
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = AppDetails
    var data: AppDetails?
    
    func apply(with data: AppDetails?) {
        removeAllSubviews(parentView: imagesBackView)
        guard let appDetails = data else { return }
        
        titleLabel.text = appDetails.trackName
        reviewAmountLabel.text = String(appDetails.userRatingCount)
        getButton.setTitle(appDetails.price, for: .normal)
        
        if let url = URL(string: appDetails.iconUrl) {
            ImageClient.request(with: url) { image in
                let resizedImage = image?.resized(toWidth: 80)
                DispatchQueue.main.async {
                    self.iconImageView.image = resizedImage
                }
            }
        }
        
        guard let urlString = appDetails.screenshotUrls.first else { return }
        
        if let url = URL(string: urlString) {
            ImageClient.request(with: url) { image in
                guard let image = image else { return }
                
                let width = UIScreen.main.bounds.width - 20 * 2
                if image.size.width > image.size.height {
                    self.firstImage = image.resized(toWidth: width)
                    self.numberOfImages = 1
                }
                else {
                    self.firstImage = image.resized(toWidth: (width - 10 * 2) / 3)
                    self.numberOfImages = 3
                }
                
                self.addImagesToBackView()
            }
        }
    }
}
