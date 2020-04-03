//
//  AppsCarouselStore.swift
//  AppStore
//
//  Created by Tsukada Yoshiki on 2020/04/03.
//

import RxCocoa
import RxSwift

final class AppsCarouselStore: StoreBase {
    private let _carouselApps = BehaviorRelay<[App]>(value: [])
    private let _selectedApp = BehaviorRelay<App?>(value: nil)
    
    private let disposeBag = DisposeBag()
    
    init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }
            
            switch action {
            case let .selectedCarouselApp(app):
                self._selectedApp.accept(app)
                
            default: break
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension AppsCarouselStore {
    var carouselApps: [App] {
        return _carouselApps.value
    }
    
    var selectedApp: App? {
        return _selectedApp.value
    }
}

//
// MARK: Observable
//

extension AppsCarouselStore {
    var carouselAppsObservable: Observable<[App]> {
        return _carouselApps.asObservable()
    }
    
    var selectedAppObservable: Observable<App?> {
        return _selectedApp.asObservable()
    }
}
