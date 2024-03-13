//
//  ImageCollectionView.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/13/24.
//

import UIKit
import RxSwift
import RxCocoa

class ImageCollectionView: UICollectionView {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        attribute()
        layouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: ImageCollectionViewModel) {
        viewModel.cellData
            .drive(self.rx.items) { cv, row, item in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .orange
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    private func layouts() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        self.collectionViewLayout = layout
    }
    
    
}
