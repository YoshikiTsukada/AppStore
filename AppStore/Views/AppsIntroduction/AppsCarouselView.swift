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

    private var groupStore: GroupStoreBase?
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

    func loadView(groupStore: GroupStoreBase, carouselIndex: IndexPath) {
        self.groupStore = groupStore
        dataSource = .init(groupStore: groupStore, carouselIndex: carouselIndex)
        dataSource?.configure(collectionView)
        collectionView.reloadData()
    }
}
