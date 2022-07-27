//
//  ViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private let container: Container
    
    init(viewModel: MainViewModel, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        bindView()
        setMainTableView()
    }
    
    private func bindView() {
        //MARK: - searchButton
        mainView.searchButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSerachButton()
            })
            .disposed(by: disposeBag)
        
        viewModel.showSearchView.bind(onNext: { [weak self] in
            guard let self = self else {
                return
            }
            self.navigationController?.pushViewController(self.container.makeSearchViewController(), animated: true)
        })
        .disposed(by: disposeBag)
    }

    private func setMainTableView() {
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.delegate = self
        mainView.mainTableView.register(MainUserTVCell.self)
        mainView.mainTableView.register(BookmarkTVCell.self)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.makeTableViewCell(index: indexPath.row,
                                    tableView: tableView,
                                    container: container)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.setTableViewHeight(index: indexPath.row)
    }
}
