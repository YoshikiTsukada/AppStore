//
//  IntroductionListUpVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class IntroductionListUpVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let groupStore: GroupStoreBase

    private let dataSource: AppsGroupListDataSource
    private let disposeBag = DisposeBag()

    private lazy var showAppDetailsDisposable: Disposable = {
        groupStore.selectedListAppObservable
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { `self`, _ in
                let vc = AppDetailsVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }()

    init(groupStore: GroupStoreBase) {
        self.groupStore = groupStore
        dataSource = .init(groupStore: groupStore)
        super.init(nibName: "IntroductionListUpVC", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configure(collectionView)

        _ = showAppDetailsDisposable

        applyNavigationItem()
    }

    func applyNavigationItem() {
        navigationItem.title = groupStore.appsGroups[groupStore.selectedIndex.item].title
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
