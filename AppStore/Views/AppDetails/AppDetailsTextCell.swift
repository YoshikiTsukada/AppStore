//
//  AppDetailsTextCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol AppDetailsTextCellDelegate : class {
    func appDetailsTextCell()
}

final class AppDetailsTextCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var mainTextLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var developerView: UIStackView!
    @IBOutlet weak var developerNameLabel: UILabel!
    
    var delegate: AppDetailsTextCellDelegate?
    
    @IBAction func showMoreButtonTapped(_ sender: Any) {
    }
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
        guard let result = data?.results.first else { return }
        
        mainTextLabel.text = result.description
        developerNameLabel.text = result.sellerName
    }
}
