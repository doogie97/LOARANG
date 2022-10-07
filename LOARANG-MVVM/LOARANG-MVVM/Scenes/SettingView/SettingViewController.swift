//
//  SettingViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift

final class SettingViewController: UIViewController {
    private let viewModel: SettingViewModelable
    private let container: Container
    
    init(viewModel: SettingViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let settingView = SettingView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = settingView
        setTableView()
        bindContents()
    }
    
    private func bindContents() {
        viewModel.checkUser
            .bind(onNext: { [weak self] in
                let mainUser = $0
                self?.showCheckUserAlert(mainUser, action: {
                    self?.viewModel.changeMainUser(mainUser)
                })
            })
            .disposed(by: disposeBag)
        
        viewModel.showAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(message: $0)
            })
            .disposed(by: disposeBag)
        
        viewModel.startedLoading
            .bind(onNext: { [weak self] in
                self?.settingView.activityIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.finishedLoading
            .bind(onNext: { [weak self] in
                self?.settingView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        viewModel.showWebView
            .withUnretained(self)
            .bind(onNext: { owner, contents in
                let webView = owner.container.makeWebViewViewController(url: contents.url, title: contents.title)
                
                owner.navigationController?.pushViewController(webView, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        settingView.menuTableView.dataSource = self
        settingView.menuTableView.delegate = self
    }
}

extension SettingViewController: UITableViewDataSource {
    enum CellType: Int, CaseIterable {
        case changeMainUser = 0
        case notice = 1
        case suggestion = 2
        
        var title: String {
            switch self {
            case .changeMainUser:
                return "대표 캐릭터 변경"
            case .notice:
                return "공지 사항"
            case .suggestion:
                return "버그제보 및 건의"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SettingTVCell.self)", for: indexPath) as? SettingTVCell else {
            return UITableViewCell()
        }
        guard let title = CellType(rawValue: indexPath.row)?.title else {
            return UITableViewCell()
        }
        cell.setCellContents(title: title)
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == CellType.changeMainUser.rawValue {
            self.showSetMainCharacterAlert {
                self.viewModel.touchSearchButton($0)
            }
        } else if indexPath.row == CellType.notice.rawValue {
            self.viewModel.touchNoticeCell()
        }
    }
}
