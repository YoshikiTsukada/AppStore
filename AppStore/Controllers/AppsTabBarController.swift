//
//  AppsTabBarController.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/21.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit

protocol ScrollableToTop: class {
    var scrollableView: Any? { get }
    func scrollToTop()
}

extension ScrollableToTop {
    func scrollToTop() {
        switch scrollableView {
        case let collectionView as UICollectionView:
            collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: true)
        case let tableView as UITableView:
            tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        case let scrollView as UIScrollView:
            scrollView.setContentOffset(.init(x: 0, y: 0 - scrollView.contentInset.top), animated: true)
        default: break
        }
    }
}

class AppsTabBarController: UITabBarController {
    private struct TabBarItem {
        let title: String
        let image: UIImage
        let rootVC: UIViewController
    }

    private let tabBarItems: [TabBarItem] = [
        .init(
            title: "ゲーム",
            image: #imageLiteral(resourceName: "games"),
            rootVC: GamesIntroductionVC()
        ),
        .init(
            title: "App",
            image: #imageLiteral(resourceName: "apps"),
            rootVC: AppsIntroductionVC()
        ),
        .init(
            title: "検索",
            image: #imageLiteral(resourceName: "search"),
            rootVC: AppsSearchVC()
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        apply()
    }

    func apply() {
        var navs: [UINavigationController] = []
        tabBarItems.enumerated().forEach { tag, item in
            let nav = UINavigationController(rootViewController: item.rootVC)
            nav.tabBarItem = .init(title: item.title, image: item.image, tag: tag)
            navs.append(nav)
        }
        setViewControllers(navs, animated: false)
    }
}

extension AppsTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard selectedViewController == viewController else { return true }
        guard let nav = viewController as? UINavigationController else { return true }

        if nav.viewControllers.count == 1 {
            if let vc = nav.viewControllers.first as? ScrollableToTop {
                vc.scrollToTop()
            }
        }
        return true
    }
}
