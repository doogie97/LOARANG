//
//  BasicInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

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
    
    private let basicInfoView = BasicInfoView()
    
    override func loadView() {
        super.loadView()
        self.view = basicInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicTableView()
    }
    
    private func setBasicTableView() {
        basicInfoView.basicInfoTableView.dataSource = self
        basicInfoView.basicInfoTableView.delegate = self
    }
}

extension BasicInfoViewController: UITableViewDataSource {
    enum CellType: Int, CaseIterable {
        case mainInfo = 0
        case basicEffect
        case equipment
        
        var cellHeight: CGFloat {
            switch self {
            case .mainInfo:
                return UIScreen.main.bounds.width * 0.5
            case .basicEffect:
                return UIScreen.main.bounds.width * 0.4
            case .equipment:
                return UIScreen.main.bounds.width * 1.2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == CellType.mainInfo.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(UserMainInfoTVCell.self)") as? UserMainInfoTVCell else {
                return UITableViewCell()
            }
            cell.setCellContents(viewModel.userInfo)
            
            return cell
        }
        
        if indexPath.row == CellType.basicEffect.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(BasicEffectTVCell.self)") as? BasicEffectTVCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
        return UITableViewCell()
        
    }
}

extension BasicInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = CellType(rawValue: indexPath.row) else {
            return 0
        }
        return cell.cellHeight
    }
}
