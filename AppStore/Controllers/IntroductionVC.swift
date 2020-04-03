//
//  IntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/23.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class IntroductionVC<Store: GroupStoreBase>: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let groupStore: Store
//    private let dataSource: AppsGroupDataSource = .init()
    private let dataSource: AppsGroupDataSource
    private let disposeBag = DisposeBag()

    private lazy var showAppDetailsDisposable: Disposable = {
        groupStore.selectedCarouselAppObservable
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { `self`, _ in
                let vc = AppDetailsVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }()

    private lazy var showIntroductionListDisposable: Disposable = {
        groupStore.selectedIndexObservable
            .flatMap { $0 == [] ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { `self`, _ in
                let vc = IntroductionListUpVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }()

    var accessUrls: [URL] {
        return [
            // Must override `accessUrls` in IntroductionVC subclass.
        ]
    }

    init(_ store: Store) {
        groupStore = store
        dataSource = .init(groupStore: groupStore)
        super.init(nibName: "IntroductionVC", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configure(collectionView)

        groupStore.appsGroupsObservable
            .map { _ in }
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        _ = showAppDetailsDisposable
        _ = showIntroductionListDisposable

        ActionCreator.fetchApps(by: accessUrls)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        _ = showAppDetailsDisposable
//        _ = showIntroductionListDisposable
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        showAppDetailsDisposable.dispose()
//        showIntroductionListDisposable.dispose()
//    }

    override func loadView() {
        if let view = UINib(nibName: String(describing: IntroductionVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
}

// extension IntroductionVC: AppsGroupCellDelegate {
//    var classType: String {
//        return String(describing: type(of: self))
//    }
//
//    func appsGroupCell(allDisplayButtonTappedWith appsGroup: AppsGroup?) {
//        performSegue(withIdentifier: SegueType.showIntroductionListUpVC.rawValue, sender: appsGroup)
//    }
//
//    func appsGroupCell(didSelectAppIdWith id: String) {
//        performSegue(withIdentifier: SegueType.showAppDetailsVC.rawValue, sender: id)
//    }
// }

extension IntroductionVC: ScrollableToTop {
    var scrollableView: Any? {
        return collectionView
    }
}

struct IntroductionDataSet {
    var appsGroups: [AppsGroup] = []
    static let empty: IntroductionDataSet = .init()
    
    static let appsGroupTitleLabelHeight: CGFloat = 30
    static let appsGroupTitleLabelSpacing: CGFloat = 10
    static var appsGroupCellHeight: CGFloat {
        return appsGroupTitleLabelHeight
            + appsGroupTitleLabelSpacing * 2
            + appsCarouselCellHeight * 3
            + appsCarouselCellVerticalSpacing * 2
    }
    
    static var appsCarouselCellHeight: CGFloat {
        return appsCarouselImageWidth + appsCarouselImageSpacing * 2
    }
    
    static let appsCarouselImageWidth: CGFloat = 70
    static let appsCarouselImageSpacing: CGFloat = 10
    static let appsCarouselCellVerticalSpacing: CGFloat = 0
    static let appsCarouselCellHorizontalSpacing: CGFloat = 10
    static let appsCarouselCellHorizontalSectionInset: CGFloat = 20
    
    static func appsCarouselCellWidth(_ width: CGFloat) -> CGFloat {
        return width - appsCarouselCellHorizontalSectionInset * 2
    }
}
