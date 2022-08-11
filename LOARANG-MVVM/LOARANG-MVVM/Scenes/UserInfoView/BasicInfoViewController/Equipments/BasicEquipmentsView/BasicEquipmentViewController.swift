//
//  BasicEquipmentViewController.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import UIKit

final class BasicEquipmentViewController: UIViewController {
    private let basicEquipmentView = BasicEquipmentView()
    
    override func loadView() {
        super.loadView()
        self.view = basicEquipmentView
    }
}
