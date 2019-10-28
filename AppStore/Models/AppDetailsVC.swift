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
    @IBOutlet var collectionView: UICollectionView!
    
    var data: DataSet = .empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
    }
    
    override func loadView() {
        if let view = UINib(nibName: String(describing: AppDetailsVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    func fetchAppDetails() {
        guard let id = data.id else { return }
        let url = URLMaker.detail(id: id)
        APIClient.parseJson(from: url) { (response: App) in
            self.data.app = response
        }
    }
}

extension AppDetailsVC : UICollectionViewDataSource, UICollectionViewDelegate {
}

extension AppDetailsVC {
    struct DataSet {
        var id: Int?
        var app: App?
        static let empty: DataSet = .init()
    }
}

extension AppDetailsVC : CollectionViewCellRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppDetailsHeaderCell.self,
            AppDetailsImageCell.self,
            AppDetailsTextCell.self,
            AppDetailsReviewsCell.self,
            AppDetailsUpdateCell.self,
            AppDetailsInfomationCell.self,
        ]
    }
}
