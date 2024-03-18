//
//  ImageDetailViewModel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/18/24.
//

import Foundation
import RxSwift
import RxCocoa

struct ImageDetailViewModel {
    let item: GGimage
    let percentage = PublishRelay<Float?>()
    let hideProgressView: Driver<Bool>
    
    init(item: GGimage) {
        self.item = item
        
        hideProgressView = percentage
            .map { $0 == 1 }
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .startWith(false)
            .asDriver(onErrorJustReturn: true)
    }
}
