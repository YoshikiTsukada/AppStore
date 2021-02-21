//
//  AppsGroupTest.swift
//  AppStoreTests
//
//  Created by Yoshiki Tsukada on 2021/02/21.
//

@testable import AppStore
import XCTest

class AppsGroupTest: XCTestCase {
    func testParse() {
        valid_json:
            do {
            let appsGroup = try JSONDecoder().decode(AppsGroup.self, from: validJson)
            XCTAssertEqual(appsGroup.title, "Top Free iPhone Apps")
            XCTAssertEqual(appsGroup.apps.count, 10)
            let app = appsGroup.apps.first!
            XCTAssertEqual(app.id, "1504185645")
            XCTAssertEqual(app.name, "NieR Re[in]carnation")
            XCTAssertEqual(app.artistName, "SQUARE ENIX")
            XCTAssertEqual(app.iconUrl.absoluteString, "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/2d/13/d8/2d13d860-0cfe-3ee3-a834-f04cfa696bc5/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png")
        } catch {
            XCTFail(error.localizedDescription)
        }

        invalid_json:
            do {
            let appsGroup = try JSONDecoder().decode(AppsGroup.self, from: invalidJson)
            XCTAssertNil(appsGroup)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}

private let validJson: Data = """
{
    "feed": {
        "title": "Top Free iPhone Apps",
        "id": "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-free/all/10/explicit.json",
        "author": {
            "name": "iTunes Store",
            "uri": "http://wwww.apple.com/jp/itunes/"
        },
        "links": [
            {
                "self": "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-free/all/10/explicit.json"
            },
            {
                "alternate": "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewTop?genreId=36&popId=27"
            }
        ],
        "copyright": "Copyright © 2018 Apple Inc. Все права защищены.",
        "country": "jp",
        "icon": "http://itunes.apple.com/favicon.ico",
        "updated": "2021-02-20T03:18:03.000-08:00",
        "results": [
            {
                "artistName": "SQUARE ENIX",
                "id": "1504185645",
                "releaseDate": "2021-02-17",
                "name": "NieR Re[in]carnation",
                "kind": "iosSoftware",
                "copyright": "© 2021 SQUARE ENIX CO., LTD. All Rights Reserved.  Developed by Applibot,Inc.",
                "artistId": "300186801",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://apps.apple.com/jp/developer/square-enix/id300186801",
                "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/2d/13/d8/2d13d860-0cfe-3ee3-a834-f04cfa696bc5/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6014",
                        "name": "ゲーム",
                        "url": "https://itunes.apple.com/jp/genre/id6014"
                    },
                    {
                        "genreId": "7014",
                        "name": "ロールプレイング",
                        "url": "https://itunes.apple.com/jp/genre/id7014"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/nier-re-in-carnation/id1504185645"
            },
            {
                "artistName": "Popcore GmbH",
                "id": "1498229533",
                "releaseDate": "2020-02-08",
                "name": "Parking Jam 3D",
                "kind": "iosSoftware",
                "copyright": "© Popcore GmbH",
                "artistId": "1375461777",
                "artistUrl": "https://apps.apple.com/jp/developer/popcore-gmbh/id1375461777",
                "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Purple124/v4/3a/de/cc/3adecc28-5196-e851-62a1-cef2c48eb158/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6014",
                        "name": "ゲーム",
                        "url": "https://itunes.apple.com/jp/genre/id6014"
                    },
                    {
                        "genreId": "7012",
                        "name": "パズル",
                        "url": "https://itunes.apple.com/jp/genre/id7012"
                    },
                    {
                        "genreId": "7004",
                        "name": "ボード",
                        "url": "https://itunes.apple.com/jp/genre/id7004"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/parking-jam-3d/id1498229533"
            },
            {
                "artistName": "Lawson, Inc.",
                "id": "515191813",
                "releaseDate": "2012-06-28",
                "name": "ローソン",
                "kind": "iosSoftware",
                "copyright": "© Lawson, Inc.",
                "artistId": "515191816",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://apps.apple.com/jp/developer/lawson-inc/id515191816",
                "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/f3/ae/e4/f3aee4f7-9666-c775-54ee-7e858105e676/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6012",
                        "name": "ライフスタイル",
                        "url": "https://itunes.apple.com/jp/genre/id6012"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/%E3%83%AD%E3%83%BC%E3%82%BD%E3%83%B3/id515191813"
            },
            {
                "artistName": "LINE Corporation",
                "id": "443904275",
                "releaseDate": "2011-06-20",
                "name": "LINE",
                "kind": "iosSoftware",
                "copyright": "© LINE Corporation",
                "artistId": "359067226",
                "artistUrl": "https://apps.apple.com/jp/developer/line-corporation/id359067226",
                "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/55/ad/9c/55ad9c5f-76cf-f59f-4b48-02208fe29380/AppIcon-0-0-1x_U007emarketing-0-0-0-5-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6005",
                        "name": "ソーシャルネットワーキング",
                        "url": "https://itunes.apple.com/jp/genre/id6005"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/line/id443904275"
            },
            {
                "artistName": "PayPay Corporation",
                "id": "1435783608",
                "releaseDate": "2018-10-05",
                "name": "PayPay-ペイペイ(キャッシュレスでスマートにお支払い)",
                "kind": "iosSoftware",
                "copyright": "© Copyright (C) PayPay Corporation. All Rights Reserved.",
                "artistId": "1435783607",
                "artistUrl": "https://apps.apple.com/jp/developer/paypay-corporation/id1435783607",
                "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/e6/c4/c6/e6c4c6cb-c655-1025-2fef-2d3b8bcf95c8/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6015",
                        "name": "ファイナンス",
                        "url": "https://itunes.apple.com/jp/genre/id6015"
                    },
                    {
                        "genreId": "6012",
                        "name": "ライフスタイル",
                        "url": "https://itunes.apple.com/jp/genre/id6012"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/paypay-%E3%83%9A%E3%82%A4%E3%83%9A%E3%82%A4-%E3%82%AD%E3%83%A3%E3%83%83%E3%82%B7%E3%83%A5%E3%83%AC%E3%82%B9%E3%81%A7%E3%82%B9%E3%83%9E%E3%83%BC%E3%83%88%E3%81%AB%E3%81%8A%E6%94%AF%E6%89%95%E3%81%84/id1435783608"
            },
            {
                "artistName": "Zoom",
                "id": "546505307",
                "releaseDate": "2012-08-15",
                "name": "ZOOM Cloud Meetings",
                "kind": "iosSoftware",
                "copyright": "© Zoom Video Communications, Inc",
                "artistId": "530594111",
                "artistUrl": "https://apps.apple.com/jp/developer/zoom/id530594111",
                "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/c4/05/97/c40597b4-ea60-d8ee-3fbf-832977bf43bc/AppIcon-0-0-1x_U007emarketing-0-0-0-9-0-85-220.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6000",
                        "name": "ビジネス",
                        "url": "https://itunes.apple.com/jp/genre/id6000"
                    },
                    {
                        "genreId": "6007",
                        "name": "仕事効率化",
                        "url": "https://itunes.apple.com/jp/genre/id6007"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/zoom-cloud-meetings/id546505307"
            },
            {
                "artistName": "FamilyMart Co.,Ltd.",
                "id": "1138196572",
                "releaseDate": "2016-09-05",
                "name": "ファミペイ-クーポン・ポイント・決済でお得にお買い物",
                "kind": "iosSoftware",
                "copyright": "© FamilyMart Co.,Ltd.",
                "artistId": "968346046",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://apps.apple.com/jp/developer/familymart-co-ltd/id968346046",
                "artworkUrl100": "https://is5-ssl.mzstatic.com/image/thumb/Purple114/v4/97/b5/26/97b526fa-cc9c-765c-5cd5-92291a1ce016/AppIcon_Release-1x_U007emarketing-0-5-0-0-85-220.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6012",
                        "name": "ライフスタイル",
                        "url": "https://itunes.apple.com/jp/genre/id6012"
                    },
                    {
                        "genreId": "6023",
                        "name": "フード／ドリンク",
                        "url": "https://itunes.apple.com/jp/genre/id6023"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/%E3%83%95%E3%82%A1%E3%83%9F%E3%83%9A%E3%82%A4-%E3%82%AF%E3%83%BC%E3%83%9D%E3%83%B3-%E3%83%9D%E3%82%A4%E3%83%B3%E3%83%88-%E6%B1%BA%E6%B8%88%E3%81%A7%E3%81%8A%E5%BE%97%E3%81%AB%E3%81%8A%E8%B2%B7%E3%81%84%E7%89%A9/id1138196572"
            },
            {
                "artistName": "総務省自治行政局",
                "id": "1487419316",
                "releaseDate": "2019-12-19",
                "name": "マイナポイント",
                "kind": "iosSoftware",
                "copyright": "© 2019 Ministry of Internal Affairs and Communications All Rights Reserved.",
                "artistId": "1353341720",
                "artistUrl": "https://apps.apple.com/jp/developer/%E7%B7%8F%E5%8B%99%E7%9C%81%E8%87%AA%E6%B2%BB%E8%A1%8C%E6%94%BF%E5%B1%80/id1353341720",
                "artworkUrl100": "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/c0/7e/6e/c07e6eea-6fd5-9b2a-6cd8-f66751afb40a/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6000",
                        "name": "ビジネス",
                        "url": "https://itunes.apple.com/jp/genre/id6000"
                    },
                    {
                        "genreId": "6007",
                        "name": "仕事効率化",
                        "url": "https://itunes.apple.com/jp/genre/id6007"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/%E3%83%9E%E3%82%A4%E3%83%8A%E3%83%9D%E3%82%A4%E3%83%B3%E3%83%88/id1487419316"
            },
            {
                "artistName": "Google LLC",
                "id": "544007664",
                "releaseDate": "2012-09-11",
                "name": "YouTube",
                "kind": "iosSoftware",
                "copyright": "© 2020 Google Inc.",
                "artistId": "281956209",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://apps.apple.com/jp/developer/google-llc/id281956209",
                "artworkUrl100": "https://is4-ssl.mzstatic.com/image/thumb/Purple124/v4/56/99/53/569953de-69b9-76b1-98bd-a25f99ccd8df/logo_youtube_color-0-0-1x_U007emarketing-0-0-0-6-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6008",
                        "name": "写真／ビデオ",
                        "url": "https://itunes.apple.com/jp/genre/id6008"
                    },
                    {
                        "genreId": "6016",
                        "name": "エンターテインメント",
                        "url": "https://itunes.apple.com/jp/genre/id6016"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/youtube/id544007664"
            },
            {
                "artistName": "Alpha Exploration Co.",
                "id": "1503133294",
                "releaseDate": "2020-09-26",
                "name": "Clubhouse: Drop-in audio chat",
                "kind": "iosSoftware",
                "copyright": "© 2020 Alpha Exploration Co., Inc.",
                "artistId": "1481002987",
                "contentAdvisoryRating": "Explicit",
                "artistUrl": "https://apps.apple.com/jp/developer/alpha-exploration-co/id1481002987",
                "artworkUrl100": "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/4c/d0/60/4cd06056-5da0-7619-e89f-dd7139958707/AppIcon-1x_U007emarketing-0-6-0-85-220.png/200x200bb.png",
                "genres": [
                    {
                        "genreId": "6005",
                        "name": "ソーシャルネットワーキング",
                        "url": "https://itunes.apple.com/jp/genre/id6005"
                    }
                ],
                "url": "https://apps.apple.com/jp/app/clubhouse-drop-in-audio-chat/id1503133294"
            }
        ]
    }
}
""".data(using: .utf8)!

private let invalidJson: Data = """
""".data(using: .utf8)!
