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
        imageView.image = UIImage(named: "나는두기") //임시
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    //추후 이미지 터치하면 확대 기능 및 다운로드 기능 추가 필요
    
    private func setLayout() {
        self.addSubview(userImageView)
        
        userImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
