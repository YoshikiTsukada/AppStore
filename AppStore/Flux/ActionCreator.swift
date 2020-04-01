//
//  ActionCreator.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import Foundation

final class ActionCreator {
    private let dispatcher: Dispatcher = .shared
}

//
// MARK: IntroductionVC
//

extension ActionCreator {
    func fetchApps(by urls: [URL]) {
        urls.forEach { [dispatcher] url in
            GetAppsGroup(url: url).execute(in: .background).then(in: .main) { appsGroup in
                dispatcher.dispatch(.getAppsGroup(appsGroup))
            }
        }
    }
}

//
// MARK: AppsGroupCell
//

extension ActionCreator {
    func showIntroductionList(_ appsGroup: AppsGroup?) {
        dispatcher.dispatch(.selectedAppsGroup(appsGroup))
    }
}

//
// MARK: AppsCarouselCell
//

extension ActionCreator {
    func showAppDetails(_ app: App) {
        dispatcher.dispatch(.selectedApp(app))
    }
}
