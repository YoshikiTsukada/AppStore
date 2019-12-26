//
//  IntroductionListUpVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

class IntroductionListUpVC : BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: DataSet = .empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        applyNavigationItem()
    }

    func applyNavigationItem() {
        navigationItem.title = data.appsGroup?.title
    }
}

extension IntroductionListUpVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.appsGroup?.apps.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let app = data.appsGroup?.apps[indexPath.row] else { return UICollectionViewCell() }
        
        let cell = IntroductionListUpCell.dequeue(from: collectionView, for: indexPath, with: app)
        cell.insertSectionLineIfNeeded(indexPath.row - 1 < data.appsGroup?.apps.count ?? 0)
        return cell
    }
    
    //
    // MARK: UICollectionViewDelegate
    //
    
    //
    // MARK: UICollectionViewDelegateFlowLayout
    //
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return .init(width: DataSet.cellWidth(width), height: DataSet.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return DataSet.cellEdge
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return DataSet.cellSpacing
    }
}

extension IntroductionListUpVC {
    struct DataSet {
        var appsGroup: AppsGroup?
        static let empty: DataSet = .init()
        
        static let iconImageWidth: CGFloat = 95
        static let iconImageSpacing: CGFloat = 15
        static func cellWidth(_ collectionViewWidth: CGFloat) -> CGFloat {
            return collectionViewWidth - cellEdge.left - cellEdge.right
        }
        static var cellHeight: CGFloat {
            return iconImageWidth + iconImageSpacing * 2
        }
        static var cellEdge: UIEdgeInsets {
            return .init(
                top: 0,
                left: 20,
                bottom: 0,
                right: 20
            )
        }
        static let cellSpacing: CGFloat = 0
    }
}

extension IntroductionListUpVC : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            IntroductionListUpCell.self
        ]
    }
}
