//
//  SettingViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import RxSwift
import GoogleMobileAds

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView.bannerView.rootViewController = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingView.bannerView.load(GADRequest())
    }
    
    private func bindContents() {
        viewModel.showAlert.withUnretained(self)
            .subscribe { owner, alert in
                switch alert {
                case .basic(let message):
                    owner.showAlert(message: message)
                case .checkUser(let userInfo):
                    owner.showCheckUserAlert(userInfo) {
                        owner.viewModel.changeMainUser(userInfo)
                    }
                case .deleteMainUser:
                    let alert = UIAlertController(title: nil, message: "대표 캐릭터를 삭제할까요?", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "취소", style: .cancel)
                    let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                        owner.viewModel.deleteMainUser()
                    }
                    alert.addAction(cancelAction)
                    alert.addAction(deleteAction)
                    owner.present(alert, animated: true)
                }
            }
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
        
        viewModel.showSafari
            .bind(onNext: {
                UIApplication.shared.open($0)
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
        case deleteMainUser
        case notice
        case suggestion
        
        var title: String {
            switch self {
            case .changeMainUser:
                return "대표 캐릭터 변경"
            case .deleteMainUser:
                return "대표 캐릭터 삭제"
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
        guard let cellType = CellType(rawValue: indexPath.row) else {
            return
        }
        
        switch cellType {
        case .changeMainUser:
            self.showSetMainCharacterAlert {
                self.viewModel.touchSearchButton($0)
            }
        case .deleteMainUser:
            self.viewModel.touchDeleteMainUserCell()
        case .notice:
            self.viewModel.touchNoticeCell()
        case .suggestion:
            self.viewModel.touchSuggestioinCell()
        }
    }
}
