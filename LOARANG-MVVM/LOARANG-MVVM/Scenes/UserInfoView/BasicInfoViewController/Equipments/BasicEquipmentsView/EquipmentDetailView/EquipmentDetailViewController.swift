//
//  EquipmentDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/20.
//

import RxSwift

final class EquipmentDetailViewController: UIViewController {
    private let viewModel: EquipmentDetailViewModelable
    
    init(viewModel:  EquipmentDetailViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let equipmentDetailView = EquipmentDetailView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = equipmentDetailView
    }
    
    override func viewDidLoad() {
        equipmentDetailView.setCellContents(viewModel.equipmentInfo)
        bindView()
    }
    
    private func bindView() {
        equipmentDetailView.closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
