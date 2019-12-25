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
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
        guard let result = data?.results.first else { return }
        
        newestVersionLabel.text = "バージョン\(result.version)"
        updateDateLabel.text = result.currentVersionReleaseDate
        updateDetailsLabel.text = result.releaseNotes
    }
}
