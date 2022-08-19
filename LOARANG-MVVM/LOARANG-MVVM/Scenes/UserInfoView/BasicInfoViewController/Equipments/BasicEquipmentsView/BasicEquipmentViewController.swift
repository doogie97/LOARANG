//
//  BasicEquipmentViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit
import RxSwift

final class BasicEquipmentViewController: UIViewController {
    private let viewModel: BasicEquipmentViewModelable
    private let container: Container
    
    init(viewModel: BasicEquipmentViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let basicEquipmentView = BasicEquipmentView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = basicEquipmentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        basicEquipmentView.equipmentTableView.dataSource = self
        basicEquipmentView.equipmentTableView.delegate = self
    }
}

extension BasicEquipmentViewController: UITableViewDataSource {
    enum Part: Int {
        case head
        case shoulder
        case top
        case bottom
        case glove
        case weapon
        
        var partString: String {
            switch self {
            case .head:
                return "머리 방어구"
            case .shoulder:
                return "어깨 방어구"
            case .top:
                return "상의"
            case .bottom:
                return "하의"
            case .glove:
                return "장갑"
            case .weapon:
                return "무기"
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.battleEquips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EquipmentCell.self)", for: indexPath) as? EquipmentCell else { return UITableViewCell() }
        cell.setLayout(equipmentPart: viewModel.battleEquips[indexPath.row])
        
        return cell
    }
}

extension BasicEquipmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
}
