//
//  CharactersViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit
import RxSwift
import RxDataSources

final class CharactersViewController: UIViewController {
    private let viewModel: CharactersViewModelable
    
    init(viewModel: CharactersViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let charactersView = CharactersView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = charactersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        let dataSource = RxTableViewSectionedReloadDataSource<CharactersSection>(configureCell: { dataSource, tableView, indexpath, characterInfo in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OwnCharacterCell.self)", for: indexpath) as? OwnCharacterCell else {
                return UITableViewCell()
            }
            cell.setCellContents(characterInfo: characterInfo)
            
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        viewModel.sections
            .bind(to: charactersView.charactersTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        charactersView.charactersTableView.rx.itemSelected
            .bind(onNext: { [weak self] in
                self?.viewModel.touchCell($0)
            })
            .disposed(by: disposeBag)
        
        viewModel.sections
            .bind(onNext: { [weak self] in
                if $0.isEmpty {
                    self?.charactersView.activityIndicator.startAnimating()
                } else {
                    self?.charactersView.activityIndicator.stopAnimating()
                }
            }).disposed(by: disposeBag)
    }
}

struct CharactersSection {
    var header: String
    var items: [Item]
}

extension CharactersSection: SectionModelType {
    typealias Item = CharacterBasicInfoDTO
    
    init(original: CharactersSection, items: [CharacterBasicInfoDTO]) {
        self = original
        self.items = items
    }
}
