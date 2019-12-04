//
//  AppDetailsImagesCell.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/29.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

final class AppDetailsImagesCell : UICollectionViewCell, CollectionViewCellPresenter {
    //
    // MARK: CollectionViewCellPresenter
    //
    
    typealias T = App
    var data: App?
    
    func apply(with data: App?) {
    }
}
