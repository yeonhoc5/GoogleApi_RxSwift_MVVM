//
//  ImageDetailViewController.swift
//  01_GoogleImageSearch
//
//  Created by yeonhoc5 on 3/18/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class ImageDetailViewController: UIViewController {
    // subView
    let imgView = UIImageView()
    let progressView = UIProgressView()
    let lblPercentage = UILabel()
    // property
    let cache = ImageCache(name: "detailViewCache")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    deinit {
        cache.clearMemoryCache()
    }
    
    func bind(_ viewModel: ImageDetailViewModel) {
        viewModel.percentage
            .map { Float($0 ?? 1.0) }
            .asDriver(onErrorJustReturn: 1.0)
            .drive(progressView.rx.progress)
            .disposed(by: disposeBag)
        
        viewModel.percentage
            .map({ float in
                return "\(String(Int((float ?? 0) * 100)))%"
            })
            .startWith("0%")
            .asDriver(onErrorJustReturn: "100%")
            .drive(lblPercentage.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.hideProgressView
            .drive(lblPercentage.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.hideProgressView
            .drive(progressView.rx.isHidden)
            .disposed(by: disposeBag)
        
        let url = URL(string: viewModel.item.original)
        imgView.kf.setImage(with: url,
                            options: [.transition(.fade(0.3)),
                                      .targetCache(cache)],
                            progressBlock: { receivedSize, totalSize in
            
            let received = Observable.just(receivedSize)
            let total = Observable.just(totalSize)
            Observable
                .combineLatest(received, total) { Float($0 / $1) }
                .bind(to: viewModel.percentage)
                .disposed(by: self.disposeBag)
        })
    }
    
    private func attribute() {
        view.backgroundColor = .white
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.kf.indicatorType = .activity
    }
    private func layout() {
        [imgView, progressView, lblPercentage].forEach {
            self.view.addSubview($0)
        }
        imgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        progressView.snp.makeConstraints {
            $0.bottom.equalTo(lblPercentage.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }
        lblPercentage.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
    }
}
