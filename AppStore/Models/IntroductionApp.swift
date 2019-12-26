//
//  IntroductionApp.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/24.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AppsGroupHeading {
    var tag: String
    var apps: [Result]
}

struct AppsGroup : Decodable {
    var feed: Feed
}

struct Feed : Decodable {
    var title: String
    var results: [Result]
}

struct Result : Decodable {
    var artistName: String
    var id: String
    var name: String
    var artistId: String
    var artworkUrl100: String
}
