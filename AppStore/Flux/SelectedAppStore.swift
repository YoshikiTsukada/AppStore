//
//  SelectedAppStore.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import RxCocoa
import RxSwift

final class SelectedAppStore {
    private let _app = BehaviorRelay<App?>(value: nil)

    private let disposeBag = DisposeBag()

    init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
            case let .selectedApp(app):
                self._app.accept(app)

            default: return
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension SelectedAppStore {
    var app: App? {
        return _app.value
    }
}

//
// MARK: Observable
//

extension SelectedAppStore {
    var appObservable: Observable<App?> {
        return _app.asObservable()
    }
}
