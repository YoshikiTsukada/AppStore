//
//  ActionCreator.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/31.
//

import Foundation

final class ActionCreator {
    private static let dispatcher: Dispatcher = .shared
}

//
// MARK: IntroductionVC
//

extension ActionCreator {
    static func fetchApps(by urls: [URL]) {
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
    static func showIntroductionList(_ appsGroup: AppsGroup?) {
//        dispatcher.dispatch(.selectedAppsGroup(appsGroup))
        dispatcher.dispatch(.didTapAllDisplayButton(appsGroup))
    }
}

//
// MARK: AppsCarouselCell
//

extension ActionCreator {
    static func showAppDetailsFromCarousel(_ app: App) {
//        dispatcher.dispatch(.selectedApp(app))
        dispatcher.dispatch(.selectedCarouselApp(app))
    }
}

//
// MARK: IntroductionListUpCell
//

extension ActionCreator {
    static func showAppDetailsFromList(_ app: App) {
        dispatcher.dispatch(.selectedListApp(app))
    }
}
