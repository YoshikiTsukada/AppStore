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

struct App : Decodable {
    var results: [DetailResult]
}

struct DetailResult : Decodable {
    var screenshotUrls: [String]
    var artworkUrl100: String
    var advisories: [String]
    var supportedDevices: [String]
    var fileSizeBytes: String
    var trackContentRating: String
    var releaseDate: String
    var releaseNotes: String?
    var primaryGenreId: Int
    var sellerName: String
    var currentVersionReleaseDate: String
    var primaryGenreName: String
    var formattedPrice: String
    var version: String
    var trackName: String
    var trackId: Int
    var artistId: Int
    var description: String
    var averageUserRating: Float
    var userRatingCount: Int
}

public struct Review {
    public let id: Int
    public var name: String
    public var rating: String
    public var title: String
    public var content: String
    
    public init?(_ json: JSON) {
        guard let name = json["author"]["name"]["label"].string else { return nil }
        guard let rating = json["im:rating"]["label"].string else { return nil }
        guard let title = json["title"]["label"].string else { return nil }
        guard let content = json["content"]["label"].string else { return nil }
        
        id = json["id"]["label"].intValue
        self.name = name
        self.rating = rating
        self.title = title
        self.content = content
    }
    
    public static func load(_ array: [JSON]) -> [Review] {
        return array.compactMap { Review($0) }
    }
}
