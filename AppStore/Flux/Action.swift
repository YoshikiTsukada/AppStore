//
//  Action.swift
//  AppStore
//
//  Created by Yoshiki Tsukada on 2020/03/30.
//

import Foundation

enum Action {
    case getAppsGroup(AppsGroup?)
//    case selectedAppsGroup(AppsGroup?)
    case didTapAllDisplayButton(IndexPath)
//    case selectedApp(App)
    case selectedListApp(App)
    case selectedCarouselApp(App)
}
