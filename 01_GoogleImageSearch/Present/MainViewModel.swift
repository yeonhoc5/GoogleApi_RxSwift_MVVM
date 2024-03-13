//
//  MainViewModel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/11/24.
//

import Foundation
import RxCocoa

struct MainViewModel {
    // subView Models
    let searchBarViewModel = SearchBarViewModel()
    let collectionViewModel = ImageCollectionViewModel()
    // view Data
    //    let cellData: Driver<[GGimage]>
    
}
