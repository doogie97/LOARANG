//
//  EquipmentDetailViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/20.
//

import UIKit
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
        setViewContents()
        bindView()
    }
    
    private func setViewContents() {
        equipmentDetailView.setViewContents(viewModel.equipmentInfo)
        
        if viewModel.equipmentInfo.basicInfo.part?.contains("어빌리티 스톤") == true {
            equipmentDetailView.hideQuality()
        }
        
        if viewModel.equipmentInfo.basicInfo.part?.contains("팔찌") == true {
            equipmentDetailView.hideQuality()
        }
    }
    
    private func bindView() {
        viewModel.dismiss
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        equipmentDetailView.closeButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCloseButton()
            })
            .disposed(by: disposeBag)
    }
}
