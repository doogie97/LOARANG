//
//  SearchViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/25.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func touchBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
