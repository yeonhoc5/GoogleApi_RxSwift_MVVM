//
//  SearchBarView.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/13/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchBarView: UISearchBar {
    // sub View
    let btnSearch = UIButton()
    // properties
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        Observable
            .merge(
                btnSearch.rx.tap.asObservable(),
                self.rx.searchButtonClicked.asObservable()
            )
            .bind(to: viewModel.btnSearchTapped)
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .map { $0 ?? ""}
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .bind(to: viewModel.stringToSearch)
            .disposed(by: disposeBag)
        
        viewModel.btnSearchTapped
            .bind(to: self.rx.endEditing)
            .disposed(by: disposeBag)
            
    }
    
    private func attribute() {
        // searchbar
        self.barTintColor = .systemGray4
        searchTextField.backgroundColor = .white
        searchTextField.tintColor = .gray
        // btnSearch
        btnSearch.setTitle("검색", for: .normal)
        btnSearch.setTitleColor(.systemTeal, for: .normal)
        btnSearch.setTitleColor(.lightGray, for: .highlighted)
    }
    private func layout() {
        self.addSubview(btnSearch)
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        btnSearch.snp.makeConstraints {
            $0.leading.equalTo(searchTextField.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}


extension Reactive where Base: SearchBarView {
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
        }
    }
}
