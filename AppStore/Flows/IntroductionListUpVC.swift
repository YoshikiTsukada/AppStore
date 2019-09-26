//
//  IntroductionListUpVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

class IntroductionListUpVC : UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var data: DataSet = .empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        applyNavigationItem()
    }
    
    override func loadView() {
           if let view = UINib(nibName: String(describing: IntroductionListUpVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
               self.view = view
           }
    }
    
    func applyNavigationItem() {
        navigationItem.title = data.feed?.title
    }
}

extension IntroductionListUpVC : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.feed?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let result = data.feed?.results[indexPath.row] else { return UICollectionViewCell() }
        
        let cell = IntroductionListUpCell.dequeue(from: collectionView, for: indexPath, with: result)
        cell.insertSectionLineIfNeeded(indexPath.row - 1 < data.feed?.results.count ?? 0)
        return cell
    }
}

extension IntroductionListUpVC : UICollectionViewDelegateFlowLayout {
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
        var feed: Feed?
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

extension IntroductionListUpVC : CollectionViewCellRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            IntroductionListUpCell.self
        ]
    }
}
