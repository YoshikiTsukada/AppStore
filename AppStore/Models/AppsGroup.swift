//
//  AppsGroup.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/27.
//

import SwiftyJSON

public struct AppsGroup {
    public var title: String
    public var apps: [App]
    
    public init?(_ json: JSON) {
        guard let title = json["title"].string else { return nil }
        guard let appsArray = json["results"].array else { return nil }
        
        self.title = title
        self.apps = App.load(appsArray)
    }
}

public struct App {
    public let id: String
    public let artistId: String
    public var name: String
    public var artistName: String
    public var iconUrl: String
    
    public init?(_ json: JSON) {
        guard let id = json["id"].string else { return nil }
        guard let artistId = json["artistId"].string else { return nil }
        guard let name = json["name"].string else { return nil }
        guard let artistName = json["artistName"].string else { return nil }
        guard let iconUrl = json["artworkUrl100"].string else { return nil }
        
        self.id = id
        self.artistId = artistId
        self.name = name
        self.artistName = artistName
        self.iconUrl = iconUrl
    }
    
    static func load(_ array: [JSON]) -> [App] {
        return array.compactMap { App($0) }
    }
}

public class GetAppsGroup: PromiseOperation<AppsGroup?> {
    public init(url: URL) {
        super.init()
        
        self.url = url
        
        jsonResponse = { json in
            AppsGroup(json["feed"])
        }
    }
}
