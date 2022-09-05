//
//  CollectionInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift

final class CollectionInfoViewController: UIViewController {
    private let viewModel: CollectionInfoViewModelable
    
    init(CollectionInfoViewModel: CollectionInfoViewModelable) {
        self.viewModel = CollectionInfoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionInfoView = CollectionInfoView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = collectionInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }

    private func bindView() {
        collectionInfoView.segmentControl.segmentCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0.row)
            })
            .disposed(by: disposeBag)
    }
}
