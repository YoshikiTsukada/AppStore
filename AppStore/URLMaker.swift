//
//  URLMaker.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/20.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation

class URLMaker {
    static let searchBase = "https://itunes.apple.com/search?"
    static let rssBase = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/"
    
    static var recommendedNewApps: URL {
        return URL(string: "\(rssBase)new-apps-we-love/all/10/explicit.json")!
    }
    
    static var recommendedNewGames: URL {
        return URL(string: "\(rssBase)new-games-we-love/all/10/explicit.json")!
    }
    
    static var topFree: URL {
        return URL(string: "\(rssBase)top-free/all/10/explicit.json")!
    }
    
    static var topFreeGames: URL {
        return URL(string: "\(rssBase)top-free/games/10/explicit.json")!
    }
    
    static var ipadTopFree: URL {
        return URL(string: "\(rssBase)top-free-ipad/all/10/explicit.json")!
    }
    
    static var topSales: URL {
        return URL(string: "\(rssBase)top-grossing/all/10/explicit.json")!
    }
    
    static var ipadTopSales: URL {
        return URL(string: "\(rssBase)top-grossing-ipad/all/10/explicit.json")!
    }
    
    static var topPaid: URL {
        return URL(string: "\(rssBase)top-paid/all/10/explicit.json")!
    }
    
    static var topPaidGames: URL {
        return URL(string: "\(rssBase)top-paid/games/10/explicit.json")!
    }
    
    static func search(term: String) -> URL {
        return URL(string: "\(searchBase)term=\(term.urlEncoded)&country=jp&media=software&entity=software&lang=ja_jp")!
    }
    
    static func review(id: Int) -> URL {
        return URL(string: "http://itunes.apple.com/jp/rss/customerreviews/id=id/json")!
    }
}
