//
//  PromiseOperation.swift
//  AppStore
//
//  Created by 塚田良輝 on 2019/12/31.
//

import Hydra
import SwiftyJSON

public class PromiseOperation<Value> {
    public var url: URL?
    public var jsonResponse: ((JSON) -> Value)?

    public func execute(in context: Context? = nil) -> Promise<Value> {
        return .init(in: context) { resolve, reject, _ in
            URLSession.shared.dataTask(with: self.url!) { data, _, error in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    let json = JSON(data)
                    let object = self.jsonResponse!(json)
                    resolve(object)
                }
            }.resume()
        }
    }
}
