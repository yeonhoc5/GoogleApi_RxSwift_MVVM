//
//  SearchBarView.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/13/24.
//

import UIKit
import SnapKit

class SearchBarView: UISearchBar {
    // sub View
    let btnSearch = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        
    }
    
    private func attribute() {
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
