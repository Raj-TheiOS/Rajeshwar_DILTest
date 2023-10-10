//
//  NetworkManager.swift
//  DilTestPartOne
//
//  Created by Raj Rathod on 10/10/23.
//

import Foundation

// encapsulate common networking functionality in a reusable and testable way. It provides a central point for making network requests and handling responses. By using a singleton pattern, you can ensure that there's only one instance of the NetworkManager throughout your application.
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData(from url: URL, completion: @escaping ([Any]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
                    completion(jsonArray, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, NSError(domain: "Data error", code: -1, userInfo: nil))
            }
        }.resume()
    }
}
