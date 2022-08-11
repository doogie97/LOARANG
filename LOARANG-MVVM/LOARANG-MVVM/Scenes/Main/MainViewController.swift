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
        //SearchButton
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
        
        //ShowUserInfo
        viewModel.showUserInfo
            .bind(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                self.navigationController?
                    .pushViewController(self.container.makeUserInfoViewController($0), animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(title: "", message: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.startedLoading
            .bind(onNext: { [weak self] in
                self?.mainView.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.finishedLoading
            .bind(onNext: { [weak self] in
                self?.mainView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
    }

    private func setMainTableView() {
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.delegate = self
    }
}

//MARK: - about TableView
extension MainViewController: UITableViewDataSource {
    enum CellType: Int, CaseIterable {
        case mainUser = 0
        case bookmark = 1
        
        var cellHeight: CGFloat {
            switch self {
            case .mainUser:
                return UIScreen.main.bounds.width * 0.75
            case .bookmark:
                return UIScreen.main.bounds.width * 0.58
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == CellType.mainUser.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MainUserTVCell.self)") as? MainUserTVCell else {
                return MainUserTVCell()
            }
            
            viewModel.mainUser
                .bind(onNext: {
                    cell.setUserInfo($0)
                })
                .disposed(by: disposeBag)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BookmarkTVCell.self)") as? BookmarkTVCell else {
                return BookmarkTVCell()
            }
            
            cell.setContainer(container: container, delegate: viewModel)
            
            return cell
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = CellType(rawValue: indexPath.row) else {
            return 0
        }
        return cell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == CellType.mainUser.rawValue {
            viewModel.touchMainUserCell()
        }
    }
}
