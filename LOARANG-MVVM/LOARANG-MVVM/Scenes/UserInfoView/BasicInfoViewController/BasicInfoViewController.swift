//
//  BasicInfoViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/29.
//

import UIKit

final class BasicInfoViewController: UIViewController {
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension BasicInfoViewController: UITableViewDelegate {
}
