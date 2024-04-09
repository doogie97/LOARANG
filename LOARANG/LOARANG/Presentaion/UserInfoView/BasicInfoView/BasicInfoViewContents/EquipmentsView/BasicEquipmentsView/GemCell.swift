//
//  GemCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/22.
//

import SnapKit

final class GemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var gemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    private lazy var gemLvLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.backgroundColor = .black
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        
        return label
    }()
    
    private func setLayout() {
        self.contentView.addSubview(gemImageView)
        self.contentView.addSubview(gemLvLabel)
        
        gemImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gemLvLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.height.equalTo(gemLvLabel.snp.width)
            $0.trailing.equalTo(gemImageView.snp.trailing)
            $0.bottom.equalTo(gemImageView.snp.bottom)
        }
    }
    
    func setCellContents(gem: Gem) {
        setLayout()
        
        gemImageDataTask = gemImageView.setImage(urlString: gem.imageURL)
        gemImageView.backgroundColor = Equips.Grade(rawValue: gem.grade)?.backgroundColor
        
        gemLvLabel.text = gem.lvString.replacingOccurrences(of: "Lv.", with: "")
    }
    
    private var gemImageDataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        gemImageView.image = nil
        gemLvLabel.text = nil
        gemImageView.backgroundColor = nil
        
        gemImageDataTask?.suspend()
        gemImageDataTask?.cancel()
    }
}
