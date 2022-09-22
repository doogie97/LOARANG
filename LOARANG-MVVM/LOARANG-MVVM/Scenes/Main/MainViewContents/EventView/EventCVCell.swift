//
//  EventCVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/22.
//

import SnapKit

final class EventCVCell: UICollectionViewCell {    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var endDataLabel: PaddingLabel = {
        let label = PaddingLabel(top: 5, bottom: 5, left: 5, right: 5)
        label.font = .one(size: 15, family: .Bold)
        label.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
        
        return label
    }()
    
    private func setLayout() {
        self.contentView.addSubview(eventImageView)
        self.contentView.addSubview(endDataLabel)
        
        eventImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        endDataLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setCellContents(_ event: LostArkEvent) {
        eventImageViewDataTask = eventImageView.setImage(urlString: event.imageURL)
        endDataLabel.text = "~ " + event.endDate
    }
    
    private var eventImageViewDataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        eventImageView.image = nil
        endDataLabel.text = nil
        
        eventImageViewDataTask?.suspend()
        eventImageViewDataTask?.cancel()
    }
}
