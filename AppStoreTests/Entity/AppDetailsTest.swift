//
//  AppDetailsTest.swift
//  AppStoreTests
//
//  Created by Yoshiki Tsukada on 2021/02/21.
//

@testable import AppStore
import XCTest

class AppDetailsTest: XCTestCase {
    func testParse() {
        valid_json:
            do {
            let appDetails = try JSONDecoder().decode(AppDetailsModel.self, from: validJson)
            XCTAssertEqual(appDetails.id, 333_903_271)
            XCTAssertEqual(appDetails.artistId, 296_415_947)
            XCTAssertEqual(appDetails.screenshotUrls.count, 5)
            XCTAssertEqual(appDetails.iconUrl.absoluteString, "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/0e/3e/c4/0e3ec41f-fd04-9fbf-c692-45433ce3b91a/source/100x100bb.jpg")
            XCTAssertEqual(appDetails.supportedDevices.count, 64)
            XCTAssertEqual(appDetails.languageCodes.count, 33)
            XCTAssertEqual(appDetails.fileSizeBytes, "133510144")
            XCTAssertEqual(appDetails.ageLimit, "17+")
            XCTAssertEqual(appDetails.releaseDate, "2009-10-09T19:50:00Z")
            XCTAssertEqual(appDetails.releaseNotes, "Twitterをさらに快適にご利用いただくため、機能強化と不具合の修正を行いました。")
            XCTAssertEqual(appDetails.sellerName, "Twitter, Inc.")
            XCTAssertEqual(appDetails.genres.count, 2)
            XCTAssertEqual(appDetails.currentVersionReleaseDateString, "2021-02-19T01:11:14Z")
            XCTAssertEqual(appDetails.price, "無料")
            XCTAssertEqual(appDetails.version, "8.54")
            XCTAssertEqual(appDetails.trackName, "Twitter ツイッター")
            XCTAssertEqual(appDetails.description, "hogehoge")
            XCTAssertEqual(appDetails.averageUserRating, 4.39182)
            XCTAssertEqual(appDetails.userRatingCount, 1_823_139)
        } catch {
            XCTFail(error.localizedDescription)
        }

        invalid_json:
            do {
            let appDetails = try JSONDecoder().decode(AppDetailsModel.self, from: invalidJson)
            XCTAssertNil(appDetails)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

private let validJson: Data = """
{
    "screenshotUrls": [
        "https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/4f/74/1b/4f741bf3-507e-6f21-d433-d101d11fd9b7/pr_source.png/392x696bb.png",
        "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/11/53/32/11533209-1139-160e-7c55-51a902e63b37/mzl.ftcclcld.png/392x696bb.png",
        "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/da/59/e1/da59e118-a9db-27f8-3114-720554069c17/mzl.fvvoocap.png/392x696bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource114/v4/11/26/15/112615ba-c8dd-6f10-63ff-e7155c8a406b/23b29f84-87e8-4962-890e-fa77a3376fa6_CB-8911_4_HomeTimeline_IOS2_JP.png/392x696bb.png",
        "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/ab/af/d4/abafd48f-4c84-de87-c83e-7d2c065640fd/pr_source.png/392x696bb.png"
    ],
    "ipadScreenshotUrls": [
        "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/e5/93/65/e5936528-a2ad-8596-6ebb-bfd1465628c4/pr_source.png/552x414bb.png",
        "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/8a/c2/1e/8ac21e30-0a0e-9daa-ec86-d6e9ce5eebea/pr_source.png/552x414bb.png",
        "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/04/9b/e9049b02-59b0-1d77-36a9-e5415099b8f2/pr_source.png/552x414bb.png",
        "https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/fa/a9/36/faa936ba-433f-9e53-8086-9b1be813140e/4b9a3ffd-3788-4405-a78f-5d4f02925e15_CB-8911_4_HomeTimeline_iPad_2ndGen__JP.png/552x414bb.png",
        "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/0d/b7/c9/0db7c904-2ef1-edfb-5a0c-2f09fc0173e3/pr_source.png/552x414bb.png"
    ],
    "appletvScreenshotUrls": [],
    "artworkUrl60": "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/0e/3e/c4/0e3ec41f-fd04-9fbf-c692-45433ce3b91a/source/60x60bb.jpg",
    "artworkUrl512": "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/0e/3e/c4/0e3ec41f-fd04-9fbf-c692-45433ce3b91a/source/512x512bb.jpg",
    "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/0e/3e/c4/0e3ec41f-fd04-9fbf-c692-45433ce3b91a/source/100x100bb.jpg",
    "artistViewUrl": "https://apps.apple.com/jp/developer/twitter-inc/id296415947?uo=4",
    "supportedDevices": [
        "iPhone5s-iPhone5s",
        "iPadAir-iPadAir",
        "iPadAirCellular-iPadAirCellular",
        "iPadMiniRetina-iPadMiniRetina",
        "iPadMiniRetinaCellular-iPadMiniRetinaCellular",
        "iPhone6-iPhone6",
        "iPhone6Plus-iPhone6Plus",
        "iPadAir2-iPadAir2",
        "iPadAir2Cellular-iPadAir2Cellular",
        "iPadMini3-iPadMini3",
        "iPadMini3Cellular-iPadMini3Cellular",
        "iPodTouchSixthGen-iPodTouchSixthGen",
        "iPhone6s-iPhone6s",
        "iPhone6sPlus-iPhone6sPlus",
        "iPadMini4-iPadMini4",
        "iPadMini4Cellular-iPadMini4Cellular",
        "iPadPro-iPadPro",
        "iPadProCellular-iPadProCellular",
        "iPadPro97-iPadPro97",
        "iPadPro97Cellular-iPadPro97Cellular",
        "iPhoneSE-iPhoneSE",
        "iPhone7-iPhone7",
        "iPhone7Plus-iPhone7Plus",
        "iPad611-iPad611",
        "iPad612-iPad612",
        "iPad71-iPad71",
        "iPad72-iPad72",
        "iPad73-iPad73",
        "iPad74-iPad74",
        "iPhone8-iPhone8",
        "iPhone8Plus-iPhone8Plus",
        "iPhoneX-iPhoneX",
        "iPad75-iPad75",
        "iPad76-iPad76",
        "iPhoneXS-iPhoneXS",
        "iPhoneXSMax-iPhoneXSMax",
        "iPhoneXR-iPhoneXR",
        "iPad812-iPad812",
        "iPad834-iPad834",
        "iPad856-iPad856",
        "iPad878-iPad878",
        "iPadMini5-iPadMini5",
        "iPadMini5Cellular-iPadMini5Cellular",
        "iPadAir3-iPadAir3",
        "iPadAir3Cellular-iPadAir3Cellular",
        "iPodTouchSeventhGen-iPodTouchSeventhGen",
        "iPhone11-iPhone11",
        "iPhone11Pro-iPhone11Pro",
        "iPadSeventhGen-iPadSeventhGen",
        "iPadSeventhGenCellular-iPadSeventhGenCellular",
        "iPhone11ProMax-iPhone11ProMax",
        "iPhoneSESecondGen-iPhoneSESecondGen",
        "iPadProSecondGen-iPadProSecondGen",
        "iPadProSecondGenCellular-iPadProSecondGenCellular",
        "iPadProFourthGen-iPadProFourthGen",
        "iPadProFourthGenCellular-iPadProFourthGenCellular",
        "iPhone12Mini-iPhone12Mini",
        "iPhone12-iPhone12",
        "iPhone12Pro-iPhone12Pro",
        "iPhone12ProMax-iPhone12ProMax",
        "iPadAir4-iPadAir4",
        "iPadAir4Cellular-iPadAir4Cellular",
        "iPadEighthGen-iPadEighthGen",
        "iPadEighthGenCellular-iPadEighthGenCellular"
    ],
    "advisories": [
        "まれ/軽度な過激な言葉遣いまたは下品なユーモア",
        "まれ/軽度な性的表現またはヌード",
        "頻繁/極度な成人向けまたはわいせつなテーマ"
    ],
    "isGameCenterEnabled": false,
    "kind": "software",
    "features": [
        "iosUniversal"
    ],
    "trackCensoredName": "Twitter ツイッター",
    "languageCodesISO2A": [
        "AR",
        "CA",
        "HR",
        "CS",
        "DA",
        "NL",
        "EN",
        "FI",
        "FR",
        "DE",
        "EL",
        "HE",
        "HI",
        "HU",
        "ID",
        "IT",
        "JA",
        "KO",
        "MS",
        "NB",
        "PL",
        "PT",
        "RO",
        "RU",
        "ZH",
        "SK",
        "ES",
        "SV",
        "TH",
        "ZH",
        "TR",
        "UK",
        "VI"
    ],
    "fileSizeBytes": "133510144",
    "sellerUrl": "https://about.twitter.com/ja/products/iphone",
    "contentAdvisoryRating": "17+",
    "averageUserRatingForCurrentVersion": 4.39182,
    "userRatingCountForCurrentVersion": 1822704,
    "averageUserRating": 4.39182,
    "trackViewUrl": "https://apps.apple.com/jp/app/twitter-%E3%83%84%E3%82%A4%E3%83%83%E3%82%BF%E3%83%BC/id333903271?uo=4",
    "trackContentRating": "17+",
    "releaseDate": "2009-10-09T19:50:00Z",
    "trackId": 333903271,
    "trackName": "Twitter ツイッター",
    "genreIds": [
        "6009",
        "6005"
    ],
    "formattedPrice": "無料",
    "primaryGenreName": "News",
    "isVppDeviceBasedLicensingEnabled": true,
    "minimumOsVersion": "12.0",
    "sellerName": "Twitter, Inc.",
    "currentVersionReleaseDate": "2021-02-19T01:11:14Z",
    "releaseNotes": "Twitterをさらに快適にご利用いただくため、機能強化と不具合の修正を行いました。",
    "primaryGenreId": 6009,
    "currency": "JPY",
    "version": "8.54",
    "wrapperType": "software",
    "artistId": 296415947,
    "artistName": "Twitter, Inc.",
    "genres": [
        "ニュース",
        "ソーシャルネットワーキング"
    ],
    "price": 0,
    "description": "hogehoge",
    "bundleId": "com.atebits.Tweetie2",
    "userRatingCount": 1823139
}
""".data(using: .utf8)!

private let invalidJson: Data = """
""".data(using: .utf8)!
