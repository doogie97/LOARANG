//
//  OwnCharacterViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import RxSwift
import RxDataSources

final class OwnCharacterViewController: UIViewController {
    private let viewModel: OwnCharacterViewModelable
    
    init(viewModel: OwnCharacterViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let ownCharacterView = OwnCharacterView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = ownCharacterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        let dataSource = RxTableViewSectionedReloadDataSource<OwnCharacterSection>(configureCell: { dataSource, tableView, indexpath, ownCharacter in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OwnCharacterCell.self)", for: indexpath) as? OwnCharacterCell else {
                return UITableViewCell()
            }
            cell.setCellContents(ownCharacter: ownCharacter)
            
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.sections
            .bind(to: ownCharacterView.charactersTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.sections
            .bind(onNext: { [weak self] in
                if $0.isEmpty {
                    self?.ownCharacterView.activityIndicator.startAnimating()
                } else {
                    self?.ownCharacterView.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
}

struct OwnCharacterSection {
    var header: String
    var items: [Item]
}

extension OwnCharacterSection: SectionModelType {
    typealias Item = OwnCharacter
    
    init(original: OwnCharacterSection, items: [OwnCharacter]) {
        self = original
        self.items = items
    }
}
