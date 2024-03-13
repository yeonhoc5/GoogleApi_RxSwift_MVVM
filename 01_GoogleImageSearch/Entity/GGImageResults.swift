//
//  GGImageResults.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/11/24.
//

import Foundation

struct GGImageResults {
    let searchResult: [GGimage]
    
    enum CodingKeys: String, CodingKey {
        case searchResult = "images_results"
    }
}

struct GGimage {
    let id: Int
    let thumbnail: String
    let title: String
    let original: String
    let originalWidth: Int
    let originalHeight: Int
}
