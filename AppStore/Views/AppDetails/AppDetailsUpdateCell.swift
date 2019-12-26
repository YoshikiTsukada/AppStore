//
//  AppDetailsUpdateCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsUpdateCell : UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var newestVersionLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    @IBOutlet weak var updateDetailsLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = AppDetails
    var data: AppDetails?
    
    func apply(with data: AppDetails?) {
        guard let appDetails = data else { return }
        
        newestVersionLabel.text = "バージョン\(appDetails.version)"
        updateDateLabel.text = appDetails.currentVersionReleaseDate
        updateDetailsLabel.text = appDetails.releaseNotes
    }
}
