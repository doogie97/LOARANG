//
//  UserInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/27.
//

import RxSwift

final class UserInfoViewController: UIViewController {
    private let viewModel: UserInfoViewModelable
    private let pageViewList: [UIViewController]  //이건 viewModel에 있는게 맞을까 여기가 맞을까?
    
    init(viewModel: UserInfoViewModelable, viewList: [UIViewController]) {
        self.viewModel = viewModel
        self.pageViewList = viewList
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
        userInfoView.setCellContents(viewModel.userInfo)
        bindView()
    }
    
    func bindView() {
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
        
        userInfoView.segmentController.segmentController.rx.value
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSegmentControl($0)
            })
            .disposed(by: disposBag)
        
        viewModel.currentPage
             .bind(onNext: { [weak self] in
                 self?.changeView(index: $0)
             })
             .disposed(by: disposBag)
        
        userInfoView.bookMarkButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchBookmarkButton()
            })
            .disposed(by: disposBag)
        
        viewModel.isBookmarkUser
            .bind(onNext: { [weak self] in
                self?.userInfoView.bookMarkButton.setBookmarkButtonColor($0)
            })
            .disposed(by: disposBag)
        
        viewModel.showErrorAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(title: "", message: $0)
            })
            .disposed(by: disposBag)
    }
    
    private func changeView(index: Int) {
        if viewModel.previousPage.value == index {
             return
        }
        
        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([pageViewList[index]], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: userInfoView.pageView.frame.width, height: userInfoView.pageView.frame.height)
        userInfoView.pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
}
