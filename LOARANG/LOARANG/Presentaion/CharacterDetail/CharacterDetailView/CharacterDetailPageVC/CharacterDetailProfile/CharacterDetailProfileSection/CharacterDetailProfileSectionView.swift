//
//  CharacterDetailProfileSectionView.swift
//  LOARANG
//
//  Created by Doogie on 4/19/24.
//

import UIKit
import SnapKit

final class CharacterDetailProfileSectionView: UIView {
    private weak var viewModel: CharacterDetailVMable?
    enum ProfileSectionCase {
        case basicInfo
        case battleEquipment
    }
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        setLayout()
    }
    
    private func setLayout() {
        
    }
}
