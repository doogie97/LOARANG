//
//  SettingViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//

import UIKit
import RxSwift

final class SettingViewController: UIViewController {
    private let viewModel: SettingViewModelable
    
    init(viewModel: SettingViewModelable) {
        self.viewModel = viewModel
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
                self?.showCheckUserAlert($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.showErrorAlert
            .bind(onNext: { [weak self] in
                self?.showAlert(title: nil, message: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func setTableView() {
        settingView.menuTableView.dataSource = self
        settingView.menuTableView.delegate = self
    }
    
    private func showTextFieldAlert() {
        let alert = UIAlertController(title: "", message: "대표 캐릭터로 설정할 캐릭터를 입력해 주세요", preferredStyle: .alert)
        let yesction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.viewModel.touchSearchButton(alert.textFields?[0].text ?? "")
        }
        
        alert.addAction(yesction)
        alert.addTextField()
        
        self.present(alert, animated: true)
    }
    
    private func showCheckUserAlert(_ mainUser: MainUser) {
        let alert = UIAlertController(title: "\(mainUser.name) Lv.\(mainUser.itemLV)(\(mainUser.`class`))",
                                      message: "대표 캐릭터를 설정 하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.viewModel.changeMainUser(mainUser)
        }
        let noAction = UIAlertAction(title: "취소", style: .destructive)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        
        self.present(alert, animated: true)
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
            showTextFieldAlert()
        }
    }
}
