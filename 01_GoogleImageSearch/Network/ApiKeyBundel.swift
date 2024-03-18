//
//  ApiKeyBundel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/14/24.
//

import Foundation

extension Bundle {
    var google: String {
        guard let file = self.path(forResource: "ApiKeyInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["Google"] as? String else {
            fatalError("api 키를 가져오지 못했습니다.")
        }
        return key
    }
}
