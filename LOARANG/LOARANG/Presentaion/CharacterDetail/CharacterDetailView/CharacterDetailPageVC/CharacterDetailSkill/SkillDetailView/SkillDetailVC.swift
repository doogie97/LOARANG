//
//  SkillDetailVC.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import UIKit

final class SkillDetailVC: UIViewController {
    private let skill: Skill
    
    init(skill: Skill) {
        self.skill = skill
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let skillDetailView = SkillDetailView()
    
    override func loadView() {
        super.loadView()
        self.view = skillDetailView
    }
    
    override func viewDidLoad() {
        skillDetailView.closeButton.addTarget(self, action: #selector(touchCloseButton), for: .touchUpInside)
        skillDetailView.tripodsTableView.dataSource = self
        skillDetailView.setViewContents(skill)
    }
    
    @objc private func touchCloseButton() {
        self.dismiss(animated: true)
    }
}

extension SkillDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skill.tripods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(TripodTVCell.self)", for: indexPath) as? TripodTVCell,
              let tripod = skill.tripods[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.setCellContents(tripod: tripod)
        
        return cell
    }
    
    
}
