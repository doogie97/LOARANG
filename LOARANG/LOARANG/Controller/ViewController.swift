//
//  ViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var mainTableView: UITableView!
    @IBOutlet private weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitailStatus()
    }
    private func setInitailStatus() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
        mainTableView.register(UINib(nibName: "BookMarkTableViewCell", bundle: nil), forCellReuseIdentifier: "BookMarkTableViewCell")
        mainTableView.register(UINib(nibName: "MianUserTableViewCell", bundle: nil), forCellReuseIdentifier: "MianUserTableViewCell")
    }
    
    @IBAction func touchSearchButton(_ sender: UIButton) {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MianUserTableViewCell") as? MianUserTableViewCell else { return MianUserTableViewCell()}
            cell.setCell()
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkTableViewCell") as? BookMarkTableViewCell else { return BookMarkTableViewCell()}
            cell.setTVCell()
            return cell
        default:
            break
        }

        return BookMarkTableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UIScreen.main.bounds.height * 0.3
        }
        return UIScreen.main.bounds.height * 0.2
    }
}
