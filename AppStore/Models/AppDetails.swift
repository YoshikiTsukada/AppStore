//
//  AppDetails.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/26.
//

import SwiftyJSON
import SwiftDate

public struct AppDetails {
    public let id: Int
    public let artistId: Int
    public var screenshotUrls: [String]
    public var iconUrl: String
    public var advisories: [String]
    public var supportedDevices: [String]
    public var languageCodes: [String]
    public var fileSizeBytes: String
    public var ageLimit: String
    public var releaseDate: String
    public var releaseNotes: String
    public var primaryGenreId: Int
    public var sellerName: String
    public var genres: [String]
    public var currentVersionReleaseDateString: String
    public var currentVersionReleaseDate: DateInRegion? {
        return DateInRegion(currentVersionReleaseDateString)
    }
    
    public var primaryGenreName: String
    public var price: String
    public var version: String
    public var trackName: String
    public var description: String
    public var averageUserRating: Float
    public var userRatingCount: Int
    
    public init?(_ json: JSON) {
        guard let id = json["trackId"].int else { return nil }
        guard let artistId = json["artistId"].int else { return nil }
        guard let screenshotUrls = json["screenshotUrls"].array else { return nil }
        guard let iconUrl = json["artworkUrl100"].string else { return nil }
        guard let advisories = json["advisories"].array else { return nil }
        guard let supportedDevices = json["supportedDevices"].array else { return nil }
        guard let languageCodes = json["languageCodesISO2A"].array else { return nil }
        guard let fileSizeBytes = json["fileSizeBytes"].string else { return nil }
        guard let ageLimit = json["contentAdvisoryRating"].string else { return nil }
        guard let releaseDate = json["releaseDate"].string else { return nil }
        guard let releaseNotes = json["releaseNotes"].string else { return nil }
        guard let primaryGenreId = json["primaryGenreId"].int else { return nil }
        guard let sellerName = json["sellerName"].string else { return nil }
        guard let genres = json["genres"].array else { return nil }
        guard let currentVersionReleaseDateString = json["currentVersionReleaseDate"].string else { return nil }
        guard let primaryGenreName = json["primaryGenreName"].string else { return nil }
        guard let price = json["formattedPrice"].string else { return nil }
        guard let version = json["version"].string else { return nil }
        guard let trackName = json["trackName"].string else { return nil }
        guard let description = json["description"].string else { return nil }
        guard let averageUserRating = json["averageUserRating"].float else { return nil }
        guard let userRatingCount = json["userRatingCount"].int else { return nil }
        
        self.id = id
        self.artistId = artistId
        self.screenshotUrls = screenshotUrls.compactMap { $0.string }
        self.iconUrl = iconUrl
        self.advisories = advisories.compactMap { $0.string }
        self.supportedDevices = supportedDevices.compactMap { $0.string }
        self.languageCodes = languageCodes.compactMap { $0.string }
        self.fileSizeBytes = fileSizeBytes
        self.ageLimit = ageLimit
        self.releaseDate = releaseDate
        self.releaseNotes = releaseNotes
        self.primaryGenreId = primaryGenreId
        self.sellerName = sellerName
        self.genres = genres.compactMap { $0.string }
        self.currentVersionReleaseDateString = currentVersionReleaseDateString
        self.primaryGenreName = primaryGenreName
        self.price = price
        self.version = version
        self.trackName = trackName
        self.description = description
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
    }
    
    static func load(_ array: [JSON]) -> [AppDetails] {
        return array.compactMap { AppDetails($0) }
    }
}
