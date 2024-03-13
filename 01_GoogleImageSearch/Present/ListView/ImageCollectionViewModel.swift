//
//  ImageCollectionViewModel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/13/24.
//

import Foundation
import RxSwift
import RxCocoa

struct ImageCollectionViewModel {
    let cellData: Driver<[GGimage]>
    
    init() {
        let sample = [
            GGimage(id: 1, thumbnail: "1", title: "11", original: "111", originalWidth: 1111, originalHeight: 11111),
            GGimage(id: 1, thumbnail: "2", title: "22", original: "222", originalWidth: 2222, originalHeight: 22222),
            GGimage(id: 1, thumbnail: "3", title: "33", original: "333", originalWidth: 3333, originalHeight: 33333),
            GGimage(id: 1, thumbnail: "4", title: "44", original: "444", originalWidth: 4444, originalHeight: 44444)
        ]
        
        cellData = Observable.just(sample)
            .asDriver(onErrorDriveWith: .empty())
    }
}
