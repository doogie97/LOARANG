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
    }
    @IBAction func touchSearchButton(_ sender: UIButton) {
        guard let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarkTableViewCell") as? BookMarkTableViewCell else { return BookMarkTableViewCell()}
        cell.setTVCell()
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.2
    }
}
