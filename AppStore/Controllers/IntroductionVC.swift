//
//  IntroductionVC.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/23.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit
import Foundation

class IntroductionVC : UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    var data: DataSet = .empty
    var accessUrls: [URL] { return [] }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAllCollectionViewCells(to: collectionView)
        fetchApps()
    }
    
    override func loadView() {
        if let view = UINib(nibName: String(describing: IntroductionVC.self), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (SegueType(segue.identifier), segue.destination) {
        case let (.showIntroductionListUpVC, vc as IntroductionListUpVC):
            guard let feed = sender as! Feed? else { return }
            vc.data.feed = feed
        default: break
        }
    }
    
    func fetchApps() {
        accessUrls.forEach { url in
            APIClient.parseJson(from: url) { (response: AppsGroup) in
                self.data.appsGroup.append(response)
                let index = IndexPath(row: self.data.appsGroup.count - 1, section: SectionHandler.appsGroup.rawValue)
                DispatchQueue.main.async {
                    self.collectionView.insertItems(at: [index])
                }
            }
        }
    }
}

extension IntroductionVC : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionHandler.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionHandler(section) {
        case .appsGroupHeader?:
            return 0
        case .appsGroup?:
            return data.appsGroup.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return UICollectionViewCell()
        case .appsGroup?:
            let feed = data.appsGroup[indexPath.row].feed
            let cell = AppsGroupCell.dequeue(from: collectionView, for: indexPath, with: feed)
            cell.delegate = self
            cell.titleConversion()
            return cell
        default: return UICollectionViewCell()
        }
    }
}

extension IntroductionVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        
        switch SectionHandler(indexPath.section) {
        case .appsGroupHeader?:
            return .zero
        case .appsGroup?:
            return .init(width: width, height: DataSet.appsGroupCellHeight)
        default: return .zero
        }
    }
}

extension IntroductionVC : AppsGroupCellDelegate {
    var classType: String {
        return String(describing: type(of: self))
    }
    
    func allDisplayButtonTapped(feed: Feed?) {
        performSegue(withIdentifier: SegueType.showIntroductionListUpVC.rawValue, sender: feed)
    }
}

extension IntroductionVC {
    struct DataSet {
        var heading: AppsGroupHeading?
        var appsGroup: [AppsGroup] = []
        static let empty: DataSet = .init()
        
        static let appsGroupTitleLabelHeight: CGFloat = 30
        static let appsGroupTitleLabelSpacing: CGFloat = 10
        static var appsGroupCellHeight: CGFloat {
            return appsGroupTitleLabelHeight
                + appsGroupTitleLabelSpacing * 2
                + appsCarouselCellHeight * 3
                + appsCarouselCellVerticalSpacing * 2
        }
        
        static var appsCarouselCellHeight: CGFloat {
            return appsCarouselImageWidth + appsCarouselImageSpacing * 2
        }
        static let appsCarouselImageWidth: CGFloat = 70
        static let appsCarouselImageSpacing: CGFloat = 10
        static let appsCarouselCellVerticalSpacing: CGFloat = 0
        static let appsCarouselCellHorizontalSpacing: CGFloat = 10
        static let appsCarouselCellHorizontalSectionInset: CGFloat = 20
        
        static func appsCarouselCellWidth(_ width: CGFloat) -> CGFloat {
            return width - appsCarouselCellHorizontalSectionInset * 2
        }
    }
}

extension IntroductionVC {
    private enum SectionHandler : Int, CaseIterable {
        case appsGroupHeader
        case appsGroup
        
        init?(_ section: Int) {
            switch section {
            case type(of: self).appsGroupHeader.rawValue: self = .appsGroupHeader
            case type(of: self).appsGroup.rawValue: self = .appsGroup
            default: return nil
            }
        }
    }
}

extension IntroductionVC {
    enum SegueType : String {
        case showIntroductionListUpVC
        
        init?(_ identifier: String?) {
            self.init(rawValue: identifier ?? "")
        }
    }
}

extension IntroductionVC : CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            AppsGroupCell.self
        ]
    }
}
