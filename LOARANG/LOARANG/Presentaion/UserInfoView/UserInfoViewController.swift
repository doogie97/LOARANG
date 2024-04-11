//
//  UserInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import UIKit
import RxSwift

final class UserInfoViewController: UIViewController {
    private let viewModel: UserInfoViewModelable
    
    init(viewModel: UserInfoViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let userInfoView = UserInfoView()
    private let disposBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = userInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel.searchWholeUserInfo()
        userInfoView.bannerView.rootViewController = self
    }
    
    private func bindView() {
        userInfoView.backButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBackButton()
            })
            .disposed(by: disposBag)
        
        viewModel.popView
            .bind(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposBag)

        userInfoView.bookMarkButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBookmarkButton()
            })
            .disposed(by: disposBag)
        
        viewModel.showAlert
            .bind(onNext: { [weak self] in
                if $0.isPop {
                    self?.showAlert(message: $0.message, action: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                } else {
                    self?.showAlert(message: $0.message)
                }
            })
            .disposed(by: disposBag)
        
        bindLoadingView()
        bindPageVC()
        bindUserInfo()
        bindReload()
    }
    
    private func bindLoadingView() {
        viewModel.startedLoading
            .bind(onNext: { [weak self] in
                self?.userInfoView.activityIndicator.startAnimating()
                self?.userInfoView.isUserInteractionEnabled = false
            })
            .disposed(by: disposBag)
        
        viewModel.finishedLoading
            .bind(onNext: { [weak self] in
                self?.userInfoView.activityIndicator.stopAnimating()
                self?.userInfoView.isUserInteractionEnabled = true
                self?.setPageView(index: self?.viewModel.currentPage.value ?? 0)
            })
            .disposed(by: disposBag)
        
        viewModel.sucssesSearching
            .bind(onNext: { [weak self] in
                self?.userInfoView.showContentsView()
                self?.userInfoView.setViewContents(self?.viewModel.userName)
            })
            .disposed(by: disposBag)
    }

    private func bindPageVC() {
        userInfoView.segmentControl.segmentCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0.row)
            })
            .disposed(by: disposBag)
        
        viewModel.currentPage
             .bind(onNext: { [weak self] in
                 self?.setPageView(index: $0)
             })
             .disposed(by: disposBag)
        
        viewModel.changeSegment
            .bind(onNext: { [weak self] in
                self?.userInfoView.segmentControl.changeSegment(index: $0)
            })
            .disposed(by: disposBag)
    }
    
    private func bindUserInfo() {
        viewModel.isBookmarkUser
            .bind(onNext: { [weak self] in
                self?.userInfoView.bookMarkButton.setBookmarkButtonColor($0)
            })
            .disposed(by: disposBag)
    }
    
    private func bindReload() {
        userInfoView.reloadButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchReloadButton()
            })
            .disposed(by: disposBag)
        
    }

    private func setPageView(index: Int) {
        if viewModel.previousPage.value == index {
             return
        }
        
        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([viewModel.pageViewList[index]], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: userInfoView.pageView.frame.width, height: userInfoView.pageView.frame.height)
        userInfoView.pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
}
