//
//  AppsIntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/21.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation

class AppsIntroductionVC: IntroductionVC {
    override var accessUrls: [URL] {
        return [
            URLMaker.recommendedNewApps,
            URLMaker.topFree,
            URLMaker.ipadTopFree,
            URLMaker.topSales,
            URLMaker.ipadTopSales,
            URLMaker.topPaid,
        ]
    }
}
