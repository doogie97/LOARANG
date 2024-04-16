//
//  CharacterDetailSkillsVC.swift
//  LOARANG
//
//  Created by Doogie on 4/16/24.
//

import UIKit
import SnapKit

final class CharacterDetailSkillsVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    private var character: CharacterDetailEntity?
    
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
    
    private lazy var skillsTV = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainBackground
        tableView.register(CharacterDetailSkillCell.self)
        
        return tableView
    }()
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
    }
    
    private func setLayout() {
        self.view.backgroundColor = .mainBackground
        self.view.addSubview(skillsTV)
        skillsTV.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension CharacterDetailSkillsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characterInfoData?.skills.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CharacterDetailSkillCell.self)") as? CharacterDetailSkillCell else {
            return UITableViewCell()
        }
        cell.setCellContents()
        
        return cell
    }
}
