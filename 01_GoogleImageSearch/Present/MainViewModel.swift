//
//  MainViewModel.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/11/24.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {
    // subView Models
    let searchBarViewModel = SearchBarViewModel()
    let collectionViewModel = ImageCollectionViewModel()
    // properties
    let disposeBag = DisposeBag()
    let showProgressView: Driver<Bool>
    
    init(){
        let queryToSearch = searchBarViewModel.btnSearchTapped
            .withLatestFrom(searchBarViewModel.stringToSearch, resultSelector: { _, text in
                return text ?? ""
            })
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
        
        let resultData = queryToSearch
            .flatMap { query in
                SearchNetwork().getData(query: query)
            }
            .share()
        
        resultData
            .compactMap { data -> [GGimage]? in
                guard case .success(let value) = data else {
                    return nil
                }
                return value.searchResult
            }
            .bind(to: collectionViewModel.cellData)
            .disposed(by: disposeBag)
        
        resultData
            .subscribe { data in
                print(data)
            }
        
        showProgressView = Observable
            .merge(queryToSearch.map { !$0.isEmpty },
                   resultData.map { _ in return false}
            )
            .asDriver(onErrorJustReturn: false)
        
    }
    
}
