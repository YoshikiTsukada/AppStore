//
//  ImageClient.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/09/01.
//  Copyright © 2019 塚田良輝. All rights reserved.
//

import UIKit
import Foundation

class ImageClient {
    static func request(with url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                completion(UIImage(data: data))
            }
        }.resume()
    }
}
