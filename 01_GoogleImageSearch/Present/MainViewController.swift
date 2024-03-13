//
//  MainViewController.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/11/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    // subViews
    let searchBar = SearchBarView()
    let collectionView = ImageCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    // rx
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func bind(_ viewModel: MainViewModel) {
        searchBar.bind(viewModel.searchBarViewModel)
        collectionView.bind(viewModel.collectionViewModel)
    }
    
    private func attribute() {
        self.title = "구글 이미지 검색"
        view.backgroundColor = .systemTeal
        collectionView.backgroundColor = .lightGray
    }
    private func layout() {
        [searchBar, collectionView].forEach {
            view.addSubview($0)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
