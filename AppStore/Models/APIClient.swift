//
//  APIClient.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/25.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIClient {
    static func parseJson<T: Decodable>(from url: URL, completion: @escaping ((T) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                print(error)
                return
            }

            do {
                let object = try JSONDecoder().decode(T.self, from: data!)
                completion(object)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func parseJsonToAppsGroup(from url: URL, completion: @escaping (AppsGroup?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                print(error)
                return
            }
            
            do {
                let json = JSON(data)
                let appsGroup = AppsGroup(json["feed"])
                completion(appsGroup)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func parseJsonToAppDetails(from url: URL, completion: @escaping (AppDetails?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                print(error)
                return
            }
            
            do {
                let json = JSON(data)
                guard let detailsJson = json["results"].array?.first else { return }
                let appDetails = AppDetails(detailsJson)
                completion(appDetails)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func parseJsonToReviews(from url: URL, completion: @escaping ([Review]) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                print(error)
                return
            }
            
            do {
                let json = JSON(data)
                let reviews = Review.load(json["feed"]["entry"].arrayValue)
                completion(reviews)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func parseJsonToSearchResults(from url: URL, completion: @escaping ([AppDetails]) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(url)
            if let error = error {
                print(error)
                return
            }
            
            do {
                let json = JSON(data)
                let appDetails = AppDetails.load(json["results"].arrayValue)
                completion(appDetails)
            } catch {
                print(error)
            }
        }.resume()
    }
}
