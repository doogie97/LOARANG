//
//  ViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "BookMarkTableViewCell")
        
        buttonSetting()
    }
//MARK: - about View
    func buttonSetting() {
        searchButton.setTitle("", for: .normal)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkTableViewCell") as? BookMarkTableViewCell else { return BookMarkTableViewCell()}
        cell.regist()
        cell.setCellLayout()
        cell.backgroundColor = #colorLiteral(red: 0.2236821055, green: 0.2327575982, blue: 0.2372712493, alpha: 1)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.2
    }
}
