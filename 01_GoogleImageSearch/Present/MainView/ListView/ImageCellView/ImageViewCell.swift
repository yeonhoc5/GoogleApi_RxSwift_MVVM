//
//  ImageViewCell.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/18/24.
//

import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    // sub view
    let imgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: ImageViewModel) {
        let url = URL(string: viewModel.ggItem.thumbnail)
        imgView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
    }
    
    private func attribute() {
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    }
    private func layout() {
        contentView.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
