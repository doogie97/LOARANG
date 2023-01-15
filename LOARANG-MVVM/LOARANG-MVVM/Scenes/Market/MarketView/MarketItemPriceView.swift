//
//  MarketItemPriceView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2023/01/15.
//

import SnapKit

final class MarketItemPriceView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var minimumPriceView = priceView(titleLabel: priceTitleLabel(text: "최저가"),
                                                  priceLabel: minimumPriceLabel)
    private lazy var yesterDayAVGPriceView = priceView(titleLabel: priceTitleLabel(text: "전날 평균"),
                                                  priceLabel: yesterDayAVGPriceLabel)
    private lazy var recentPriceView = priceView(titleLabel: priceTitleLabel(text: "최근 구매가"),
                                                  priceLabel: recentPriceLabel)
    
    private lazy var minimumPriceLabel = priceLabel()
    private lazy var yesterDayAVGPriceLabel = priceLabel()
    private lazy var recentPriceLabel = priceLabel()
    
    
    private func priceTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .one(size: 14, family: .Bold)
        
        return label
    }
    
    private func priceLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .one(size: 14, family: .Bold)
        
        return label
    }
    
    private func priceView(titleLabel: UILabel, priceLabel: UILabel) -> UIView {
        let view = UIView()
        let coinImageView = UIImageView(image: UIImage(named: "goldCoin"))
        
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(coinImageView)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(coinImageView.snp.leading).inset(-4)
        }
        
        coinImageView.snp.makeConstraints {
            $0.width.height.equalTo(12)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(priceLabel)
        }
        
        return view
    }
    
    private func setLayout() {
        self.addSubview(minimumPriceView)
        self.addSubview(yesterDayAVGPriceView)
        self.addSubview(recentPriceView)
        
        minimumPriceView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        yesterDayAVGPriceView.snp.makeConstraints {
            $0.top.equalTo(minimumPriceView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        recentPriceView.snp.makeConstraints {
            $0.top.equalTo(yesterDayAVGPriceView.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setPrice(minimum: Double?, yesterday: Double?, recent: Double?) {
        minimumPriceLabel.text = minimum == 0 ? "-" : "\(minimum ?? 0)"
        yesterDayAVGPriceLabel.text = yesterday == 0 ? "-" : "\(yesterday ?? 0)"
        recentPriceLabel.text = recent == 0 ? "-" : "\(recent ?? 0)"
    }
}
