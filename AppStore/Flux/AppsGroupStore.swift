//
//  AppsGroupStore.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import RxCocoa
import RxSwift

final class AppsGroupStore: StoreBase {
    private let _appsGroups = BehaviorRelay<[AppsGroup]>(value: [])
    private let _selectedAppsGroup = BehaviorRelay<AppsGroup?>(value: nil)

    private let disposeBag = DisposeBag()

    init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
            case let .getAppsGroup(appsGroup):
                guard let appsGroup = appsGroup else { return }
                self._appsGroups.accept(self._appsGroups.value + [appsGroup])

            case let .selectedAppsGroup(appsGroup):
                self._selectedAppsGroup.accept(appsGroup)

            default: return
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension AppsGroupStore {
    var appsGroups: [AppsGroup] {
        return _appsGroups.value
    }

    var selectedAppsGroup: AppsGroup? {
        return _selectedAppsGroup.value
    }
}

//
// MARK: Observable
//

extension AppsGroupStore {
    var appsGroupsObservable: Observable<[AppsGroup]> {
        return _appsGroups.asObservable()
    }

    var selectedAppsGroupObservable: Observable<AppsGroup?> {
        return _selectedAppsGroup.asObservable()
    }
}
