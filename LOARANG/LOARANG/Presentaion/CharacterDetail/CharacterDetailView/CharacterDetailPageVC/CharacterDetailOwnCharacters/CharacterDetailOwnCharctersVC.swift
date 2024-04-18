//
//  CharacterDetailOwnCharctersVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailOwnCharctersVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private lazy var ownCharactersTV = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainBackground
        tableView.separatorStyle = .none
        tableView.register(CharacterDetailOwnCharacterCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
    }
    
    private func setLayout() {
        self.view.addSubview(ownCharactersTV)
        ownCharactersTV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CharacterDetailOwnCharctersVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.ownCharactersInfoData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.ownCharactersInfoData[safe: section]?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharacterDetailOwnCharacterCell.self)", for: indexPath) as? CharacterDetailOwnCharacterCell,
              let ownCharactersInfo = viewModel?.ownCharactersInfoData,
              let severInfo = ownCharactersInfo[safe: indexPath.section],
              let character = severInfo.characters[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(character)
        return cell
    }
}
