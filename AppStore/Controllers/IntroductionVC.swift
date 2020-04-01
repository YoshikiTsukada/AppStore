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

class IntroductionVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let actionCreator: ActionCreator = .init()
    private let appsGroupStore: AppsGroupStore = .init()
    private let selectedAppStore: SelectedAppStore = .init()

    private let dataSource: AppsGroupDataSource
    private let disposeBag = DisposeBag()

    private lazy var showAppDetailsDisposable: Disposable = {
        // fix
        selectedAppStore.appObservable
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { `self`, _ in
                let vc = AppDetailsVC(selectedAppStore: self.selectedAppStore)
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }()

    private lazy var showIntroductionListDisposable: Disposable = {
        // fix
        appsGroupStore.selectedAppsGroupObservable
            .flatMap { $0 == nil ? .empty() : Observable.just(()) }
            .bind(to: Binder(self) { `self`, _ in
                let vc = IntroductionListUpVC(appsGroupStore: self.appsGroupStore)
                self.navigationController?.pushViewController(vc, animated: true)
            })
    }()

    var accessUrls: [URL] {
        return [
            // Must override `accessUrls` in IntroductionVC subclass.
        ]
    }

    init() {
        dataSource = .init(actionCreator: actionCreator, appsGroupStore: appsGroupStore)
        super.init(nibName: "IntroductionVC", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.configure(collectionView)

        appsGroupStore.appsGroupsObservable
            .map { _ in }
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)

//        _ = showAppDetailsDisposable
//        _ = showIntroductionListDisposable

        actionCreator.fetchApps(by: accessUrls)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        _ = showAppDetailsDisposable
        _ = showIntroductionListDisposable
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        showAppDetailsDisposable.dispose()
        showIntroductionListDisposable.dispose()
    }

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

extension IntroductionVC {
    struct DataSet {
        var appsGroups: [AppsGroup] = []
        static let empty: DataSet = .init()

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
}

extension IntroductionVC: ScrollableToTop {
    var scrollableView: Any? {
        return collectionView
    }
}
