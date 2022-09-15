//
//  BasicInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift

final class BasicInfoViewController: UIViewController {
    private let viewModel: BasicInfoViewModelable
    
    init(viewModel: BasicInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let basicInfoView = BasicInfoView()
    private let disposeBag = DisposeBag()
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func loadView() {
        super.loadView()
        self.view = basicInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        viewModel.userInfo
            .bind(onNext: { [weak self] in
                guard let userInfo = $0 else {
                    return
                }
                self?.basicInfoView.setViewContents(userInfo: userInfo)
            })
            .disposed(by: disposeBag)
        
        basicInfoView.equipmentsView.segmentControl.segmentCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0.row)
            })
            .disposed(by: disposeBag)
        
        viewModel.currentPage
            .bind(onNext: { [weak self] in
                self?.changeView(index: $0)
            })
            .disposed(by: disposeBag)
        
            viewModel.engravings.bind(to: basicInfoView.engravingsView.engravingCollectionView
                .rx.items(cellIdentifier: "\(EngravigCVCell.self)", cellType: EngravigCVCell.self)) {index, engraving, cell in
                cell.setCellContents(engraving: engraving)
            }
            .disposed(by: disposeBag)
            
            basicInfoView.engravingsView.engravingCollectionView
                .rx.itemSelected
                .bind(onNext: { [weak self] in
                    self?.viewModel.touchEngravingCell($0.row)
                })
                .disposed(by: disposeBag)
            
            viewModel.showengravingDetail
                .bind(onNext: { [weak self] in
                    self?.basicInfoView.showEngravingDetail(engraving: $0)
                })
                .disposed(by: disposeBag)
            
            basicInfoView.engravingDetailView.rx.tapGesture()
                .bind(onNext: { [weak self] _ in
                    self?.basicInfoView.engravingDetailView.isHidden = true
                })
                .disposed(by: disposeBag)
        
            viewModel.cards.bind(to: basicInfoView.cardView.cardCollectionView
                .rx.items(cellIdentifier: "\(CardCVCell.self)", cellType: CardCVCell.self)) {index, card, cell in
                    cell.setCellContents(card: card)
            }
            .disposed(by: disposeBag)
        
            viewModel.cardSetEffects.bind(to: basicInfoView.cardView.cardSetEffectTableView
                .rx.items(cellIdentifier: "\(CardSetEffectTVCell.self)", cellType: CardSetEffectTVCell.self)) {index, cardSetEffect, cell in
                    cell.setCellContents(cardSetEffect: cardSetEffect)
            }
            .disposed(by: disposeBag)
        
        basicInfoView.characterImageView.shareButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchShareButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.showActivityVC
            .bind(onNext: { [weak self] in
                let activityVC = UIActivityViewController(activityItems: [$0], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self?.view
                
                self?.present(activityVC, animated: true)
                //시뮬레이터에서는 오토레이아웃 오류 발생, 실 기기에서는 정상적으로 작동 됨
                //공유 기능에 문제 있는것이 아니어서 일단 넘김
            })
            .disposed(by: disposeBag)
    }
    
    private func changeView(index: Int) {
        if viewModel.previousPage.value == index {
             return
        }
        
        guard let vc = viewModel.pageViewList[index] else {
            return
        }

        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([vc], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: basicInfoView.equipmentsView.pageView.frame.width, height: basicInfoView.equipmentsView.pageView.frame.height)
        basicInfoView.equipmentsView.pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
}
