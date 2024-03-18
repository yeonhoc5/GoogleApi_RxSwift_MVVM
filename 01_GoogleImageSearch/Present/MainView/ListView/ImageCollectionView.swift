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
    var screenSize: CGSize {
        get {
            return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.bounds.size ?? .zero
        }
    }
    
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
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { cv, row, item in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "ImageViewCell", for: indexPath) as? ImageViewCell else { return UICollectionViewCell() }
                let viewModel = ImageViewModel(ggItem: item)
                cell.bind(viewModel)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .lightGray
        self.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageViewCell")
        
    }
    private func layouts() {
        let layout = UICollectionViewFlowLayout()
        let count: CGFloat = 4
        let width = (screenSize.width - count + 1) / count
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        self.collectionViewLayout = layout
    }
    
    
}
