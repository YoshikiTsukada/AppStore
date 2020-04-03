//
//  GroupStoreBase.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import RxCocoa
import RxSwift

final class AppsGroupStore: GroupStoreBase {
    static let shared: AppsGroupStore = .init()
}

final class GamesGroupStore: GroupStoreBase {
    static let shared: GamesGroupStore = .init()
}

class GroupStoreBase: StoreBase {
    private let _appsGroups = BehaviorRelay<[AppsGroup]>(value: [])
    private let _selectedIndex = BehaviorRelay<IndexPath>(value: [])
    private let _selectedListApp = BehaviorRelay<App?>(value: nil)
    private let _selectedCarouselApp = BehaviorRelay<App?>(value: nil)

    private let disposeBag = DisposeBag()

    init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
            case let .getAppsGroup(appsGroup):
                guard let appsGroup = appsGroup else { return }
                self._appsGroups.accept(self._appsGroups.value + [appsGroup])

            case let .didTapAllDisplayButton(index):
                self._selectedIndex.accept(index)

            case let .selectedListApp(app):
                self._selectedListApp.accept(app)

            case let .selectedCarouselApp(app):
                self._selectedCarouselApp.accept(app)

            default: return
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension GroupStoreBase {
    var appsGroups: [AppsGroup] {
        return _appsGroups.value
    }
    
    var selectedIndex: IndexPath {
        return _selectedIndex.value
    }
    
    var selectedCarouselApp: App? {
        return _selectedCarouselApp.value
    }
    
    var selectedListApp: App? {
        return _selectedListApp.value
    }
}

//
// MARK: Observable
//

extension GroupStoreBase {
    var appsGroupsObservable: Observable<[AppsGroup]> {
        return _appsGroups.asObservable()
    }
    
    var selectedIndexObservable: Observable<IndexPath> {
        return _selectedIndex.asObservable()
    }
    
    var selectedCarouselAppObservable: Observable<App?> {
        return _selectedCarouselApp.asObservable()
    }
    
    var selectedListAppObservable: Observable<App?> {
        return _selectedListApp.asObservable()
    }
}
