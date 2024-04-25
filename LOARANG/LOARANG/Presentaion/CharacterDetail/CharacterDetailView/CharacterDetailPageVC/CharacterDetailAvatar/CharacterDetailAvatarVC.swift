//
//  CharacterDetailAvatarVC.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit

final class CharacterDetailAvatarVC: UIViewController, PageViewInnerVCDelegate {
    private weak var viewModel: CharacterDetailVMable?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentsView = UIView()
    private lazy var characterImageView = UIImageView()
    
    func setViewContents(viewModel: CharacterDetailVMable?) {
        self.viewModel = viewModel
        characterImageView.setImage(viewModel?.characterInfoData?.profile.imageUrl)
    }
    
    private func setLayout() {
        self.view.backgroundColor = #colorLiteral(red: 0.07950355858, green: 0.09458512813, blue: 0.1114221141, alpha: 1)
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentsView)
        contentsView.addSubview(characterImageView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        characterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 1.16)
        }
    }
}
