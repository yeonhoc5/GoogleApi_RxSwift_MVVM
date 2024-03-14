//
//  GoogleAPI.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/14/24.
//

import Foundation

struct GoogleAPI {
    let schem = "https"
    let host = "serpapi.com"
    let path = "search"
    
    func urlComponents(query: String) -> URLComponents {
        var components = URLComponents()
        
        components.scheme = schem
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "engine", value: "google_images"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "api_key", value: Bundle.main.google)
        ]
        
        return components
    }
}
