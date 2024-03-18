//
//  ImageDetailViewController.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/18/24.
//

import UIKit
import SnapKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    // subView
    let imgView = UIImageView()
    // property
    let cache = ImageCache.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    deinit {
        cache.clearMemoryCache()
    }
    
    func bind(_ viewModel: ImageDetailViewModel) {
        let url = URL(string: viewModel.item.original)
        
        imgView.kf.setImage(with: url,
                            placeholder: UIImage(systemName: "photo"),
                            options: [.transition(.flipFromRight(0.3))])
        { resut, error in
            
        }
    }
    
    private func attribute() {
        view.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.kf.indicatorType = .activity
    }
    private func layout() {
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
