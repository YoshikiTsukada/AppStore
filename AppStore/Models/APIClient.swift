//
//  APIClient.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/08/25.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import Foundation

class APIClient {
    static func parseJson<T: Decodable>(from url: URL, completion: @escaping ((T) -> Void)) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
}
