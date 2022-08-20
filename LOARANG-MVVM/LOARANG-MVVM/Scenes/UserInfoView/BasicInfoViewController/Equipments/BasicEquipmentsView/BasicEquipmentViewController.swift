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
        
        viewModel.showEquipmentDetail
            .bind(onNext: { [weak self] in
                print($0?.name?.htmlToString)
            })
            .disposed(by: disposeBag)
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
    
    enum Grade: Int {
        case nomal
        case advanced
        case rare
        case hero
        case legendary
        case artifact
        case ancient
        case esther
        
        var color: UIColor {
            switch self {
            case .nomal:
                return #colorLiteral(red: 0.593928329, green: 0.580765655, blue: 0.5510483948, alpha: 1)
            case .advanced:
                return #colorLiteral(red: 0.1626245975, green: 0.2453864515, blue: 0.06184400618, alpha: 1)
            case .rare:
                return #colorLiteral(red: 0.06879425794, green: 0.2269216776, blue: 0.347065717, alpha: 1)
            case .hero:
                return #colorLiteral(red: 0.2530562878, green: 0.06049384922, blue: 0.3300251961, alpha: 1)
            case .legendary:
                return #colorLiteral(red: 0.5773422718, green: 0.3460586369, blue: 0.01250262465, alpha: 1)
            case .artifact:
                return #colorLiteral(red: 0.4901602268, green: 0.2024044096, blue: 0.03712747619, alpha: 1)
            case .ancient:
                return #colorLiteral(red: 0.7324138284, green: 0.6683282852, blue: 0.5068081021, alpha: 1)
            case .esther:
                return #colorLiteral(red: 0.1580955684, green: 0.5807852149, blue: 0.567861557, alpha: 1)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.battleEquips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EquipmentCell.self)", for: indexPath) as? EquipmentCell else { return UITableViewCell() }
        cell.setCellContents(equipmentPart: viewModel.battleEquips[indexPath.row],
                             partString: Part(rawValue: indexPath.row)?.partString,
                             backColor: Grade(rawValue: viewModel.battleEquips[indexPath.row]?.grade ?? 0)?.color)
        
        return cell
    }
}

extension BasicEquipmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.touchCell(indexPath.row)
    }
}
