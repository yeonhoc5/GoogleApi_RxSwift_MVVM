//
//  SearchBarViewModel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/13/24.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchBarViewModel {
    let btnSearchTapped = PublishRelay<Void>()
    let stringToSearch = PublishSubject<String?>()
}
