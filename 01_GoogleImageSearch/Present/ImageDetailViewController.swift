//
//  ImageDetailViewController.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/18/24.
//

import UIKit
import SnapKit
class ImageDetailViewController: UIViewController {
    // subView
    let imgView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    func bind(_ viewModel: ImageDetailViewModel) {
        let url = URL(string: viewModel.item.original)
        imgView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")) { resut, error in
            
        }
    }
    
    private func attribute() {
        view.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
    }
    private func layout() {
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
