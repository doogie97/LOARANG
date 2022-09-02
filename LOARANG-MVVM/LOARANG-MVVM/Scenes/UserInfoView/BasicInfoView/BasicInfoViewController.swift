//
//  BasicInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift

final class BasicInfoViewController: UIViewController {
    private let container: Container
    private let viewModel: BasicInfoViewModelable
    
    init(container: Container, viewModel: BasicInfoViewModelable) {
        self.container = container
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var basicInfoView = BasicInfoView(engravingsViewHeight: engravingHeight())
    private let disposeBag = DisposeBag()
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func loadView() {
        super.loadView()
        self.view = basicInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContents()
        bindView()
    }
    
    private func setViewContents() {
        basicInfoView.mainInfoView.setViewContents(viewModel.userInfo.mainInfo)
        basicInfoView.basicAbillityView.setViewContents(viewModel.userInfo.stat.basicAbility)
        basicInfoView.propensitiesView.setViewContents(propensities: viewModel.userInfo.stat.propensities)
        if viewModel.engravings.value.count == 0 {
            basicInfoView.engravingsView.showNoEngravingLabel()
        }
        basicInfoView.characterImageView.setUserImageView(viewModel.userInfo.mainInfo.userImage)
    }
    
    private func bindView() {
        basicInfoView.equipmentsView.segmentControllView.segmentController
            .rx.value
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0)
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

        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([viewModel.pageViewList[index]], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: basicInfoView.equipmentsView.pageView.frame.width, height: basicInfoView.equipmentsView.pageView.frame.height)
        basicInfoView.equipmentsView.pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
    
    private func engravingHeight() -> CGFloat {
        switch viewModel.userInfo.stat.engravigs.count {
        case 0..<3:
            return UIScreen.main.bounds.width * 0.2
        case 3..<5:
            return UIScreen.main.bounds.width * 0.275
        case 5..<7:
            return UIScreen.main.bounds.width * 0.35
        default:
            return UIScreen.main.bounds.width * 0.425
        }
    }
}
