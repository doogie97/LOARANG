//
//  BasicInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class BasicInfoViewController: UIViewController {
    private let container: Container
    
    init(container: Container) {
        self.container = container
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
        case equipment = 1
        case stat = 2
        
        var cellHeight: CGFloat {
            switch self {
            case .mainInfo:
                return UIScreen.main.bounds.width * 0.5
            case .equipment:
                return UIScreen.main.bounds.width * 1.2
            case .stat:
                return UIScreen.main.bounds.width * 0.6
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == CellType.mainInfo.rawValue {
            return container.makeUserMainInfoTVCell(tableView: tableView, userInfo: fakeUser().user3)
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
