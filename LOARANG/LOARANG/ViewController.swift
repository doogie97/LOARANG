//
//  ViewController.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/05/23.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSetting()
    }
//MARK: - about View
    func buttonSetting() {
        searchButton.setTitle("", for: .normal)
    }
}

