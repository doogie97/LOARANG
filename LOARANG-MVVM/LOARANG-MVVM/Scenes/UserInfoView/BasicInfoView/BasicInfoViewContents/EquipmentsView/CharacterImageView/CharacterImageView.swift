//
//  CharacterImageView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import SnapKit

final class CharacterImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private (set) lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 25, weight: .regular), forImageIn: .normal)
        button.imageView?.tintColor = .white
        
        return button
    }()
    
    private func setLayout() {
        self.addSubview(userImageView)
        self.addSubview(shareButton)
        
        userImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(30)
        }
    }
    
    func setUserImageView(_ userImage: UIImage) {
        userImageView.image = userImage
    }
}
