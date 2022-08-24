//
//  AvatarViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import RxSwift

final class AvatarViewController: UIViewController {
    private let viewModel: AvatarViewModelable
    private let container: Container
    
    init(viewModel: AvatarViewModelable, container: Container) {
        self.viewModel = viewModel
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarView = AvatarView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = avatarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        avatarView.leftTableView.dataSource = self
        avatarView.leftTableView.delegate = self
        avatarView.rightTableView.dataSource = self
        avatarView.rightTableView.delegate = self
        
        viewModel.showEquipmentDetail
            .bind(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                guard let equipmentInfo = $0 else {
                    return
                }
                
                self.present(self.container.makeAvatarDetailViewController(equipmentInfo: equipmentInfo), animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.specialEquipment
            .bind(to: avatarView.specialEquipmentCollectionView.rx.items(cellIdentifier: "\(SpecialEquipmentCell.self)", cellType: SpecialEquipmentCell.self)) { index, equipment, cell in
                
                let partStrings = ["나침반", "부적", "문장"]
                
                cell.setCellContents(equipmentPart: equipment,
                                     partString: partStrings[safe: index],
                                     backColor: Equips.Grade(rawValue: equipment?.basicInfo.grade ?? 0)?.backgroundColor)
            }
            .disposed(by: disposeBag)
        
        avatarView.specialEquipmentCollectionView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchSpecialEquipmentCell($0.row)
            })
            .disposed(by: disposeBag)
    }
}

extension AvatarViewController: UITableViewDataSource {
    enum LeftPartType: Int {
        case mainWeaponAvatar, mainHeadAvatar, mainTopAvatar, mainBottomAvatar, instrumentAvarat, fisrtFaceAvarat, secondFaceAvarat
        
        var partString: String {
            switch self {
            case .mainWeaponAvatar:
                return "무기 아바타"
            case .mainHeadAvatar:
                return "머리 아바타"
            case .mainTopAvatar:
                return "상의 아바타"
            case .mainBottomAvatar:
                return "하의 아바타"
            case .instrumentAvarat:
                return "악기 아바타"
            case .fisrtFaceAvarat:
                return "얼굴1 아바타"
            case .secondFaceAvarat:
                return "얼굴2 아바타"
            }
        }
    }
    
    enum RightPartType: Int {
        case subWeaponAvatar, subHeadAvatar, subTopAvatar, subBottomAvatar
        
        var partString: String {
            switch self {
            case .subWeaponAvatar:
                return "무기 덧입기 아바타"
            case .subHeadAvatar:
                return "머리 덧입기 아바타"
            case .subTopAvatar:
                return "상의 덧입기 아바타"
            case .subBottomAvatar:
                return "하의 덧입기 아바타"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == avatarView.leftTableView {
            return viewModel.mainAvatar.count
        }
        
        if tableView == avatarView.rightTableView {
            return viewModel.subAvatar.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var info: (equipments: EquipmentPart?, pratString: String?) {
            if tableView == avatarView.leftTableView {
                return (viewModel.mainAvatar[indexPath.row], LeftPartType(rawValue: indexPath.row)?.partString)
            }
            
            if tableView == avatarView.rightTableView {
                return (viewModel.subAvatar[indexPath.row], RightPartType(rawValue: indexPath.row)?.partString)
            }
            
            return (nil, nil)
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EquipmentCell.self)", for: indexPath) as? EquipmentCell else {
            return UITableViewCell()
        }
        
        cell.setCellContents(equipmentPart: info.equipments,
                             partString: info.pratString,
                             backColor: Equips.Grade(rawValue: info.equipments?.basicInfo.grade ?? 0)?.backgroundColor)
        
        return cell
    }
}

extension AvatarViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == avatarView.leftTableView {
            viewModel.touchLeftCell(indexPath.row)
        }
        
        if tableView == avatarView.rightTableView {
            viewModel.touchRightCell(indexPath.row)
        }
    }
}
