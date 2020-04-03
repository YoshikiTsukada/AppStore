//
//  AppsCarouselView.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/26.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AppsCarouselView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    private var appsCarouselStore: AppsCarouselStore?
    private var dataSource: AppsCarouselDataSource?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
    }

    func loadView(appsCarouselStore: AppsCarouselStore, dataSource: AppsCarouselDataSource) {
        self.appsCarouselStore = appsCarouselStore
        self.dataSource = dataSource
        dataSource.configure(collectionView)
        collectionView.reloadData()
    }
}
