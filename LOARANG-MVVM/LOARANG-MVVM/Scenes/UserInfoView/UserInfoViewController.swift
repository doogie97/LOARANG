//
//  UserInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

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
        viewModel.searchUser()
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
                self?.showAlert(title: "", message: $0)
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
            })
            .disposed(by: disposBag)
    }

    private func bindPageVC() {
        viewModel.pageViewList
            .bind(onNext: { [weak self] in
                self?.setPageView(pageViewList: $0, index: self?.viewModel.currentPage.value ?? 0)
            })
            .disposed(by: disposBag)
        
        userInfoView.segmentControl.segmentCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0.row)
            })
            .disposed(by: disposBag)
        
        viewModel.currentPage
             .bind(onNext: { [weak self] in
                 self?.setPageView(pageViewList: self?.viewModel.pageViewList.value ?? [], index: $0)
             })
             .disposed(by: disposBag)
    }
    
    private func bindUserInfo() {
        userInfoView.setViewContents(viewModel.userName)
        
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

    private func setPageView(pageViewList: [UIViewController?] ,index: Int) {
        guard let vc = pageViewList[safe: index] else {
            return
        }
        
        if viewModel.previousPage.value == index {
             return
        }
        
        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([vc ?? UIViewController()], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: userInfoView.pageView.frame.width, height: userInfoView.pageView.frame.height)
        userInfoView.pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
}
