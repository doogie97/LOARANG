//
//  CardSetCVCell.swift
//  LOARANG
//
//  Created by 최최성균 on 2022/06/21.
//

import UIKit

//MARK: - properties
final class CardSetCVCell: UICollectionViewCell {
    @IBOutlet private weak var firstCardNameLabel: UILabel!
    @IBOutlet private weak var secondCardNameLabel: UILabel!
    @IBOutlet private weak var thirdCardNameLabel: UILabel!
    @IBOutlet private weak var fourthCardNameLabel: UILabel!
    @IBOutlet private weak var fifthCardNameLabel: UILabel!
    @IBOutlet private weak var sixthCardNameLabel: UILabel!
    private lazy var cardLabels: [UILabel] = [firstCardNameLabel, secondCardNameLabel, thirdCardNameLabel, fourthCardNameLabel, fifthCardNameLabel, sixthCardNameLabel]
    
    @IBOutlet private weak var firstCardImageView: UIImageView!
    @IBOutlet private weak var secondCardImageView: UIImageView!
    @IBOutlet private weak var thirdCardImageView: UIImageView!
    @IBOutlet private weak var fourthCardImageView: UIImageView!
    @IBOutlet private weak var fifthCardImageView: UIImageView!
    @IBOutlet private weak var sixthCardImageView: UIImageView!
    private lazy var cardImageViews: [UIImageView] = [firstCardImageView, secondCardImageView, thirdCardImageView, fourthCardImageView, fifthCardImageView, sixthCardImageView]
    
    @IBOutlet private weak var firstCardGemStacView: UIStackView!
    @IBOutlet private weak var secondCardGemStackView: UIStackView!
    @IBOutlet private weak var thridCardGemStackView: UIStackView!
    @IBOutlet private weak var fourthCardGemStackView: UIStackView!
    @IBOutlet private weak var fifthCardGemStackView: UIStackView!
    @IBOutlet private weak var sixthCardGemStackView: UIStackView!
    private lazy var cardGemStackView: [UIStackView] = [firstCardGemStacView, secondCardGemStackView, thridCardGemStackView, fourthCardGemStackView, fifthCardGemStackView, sixthCardGemStackView]
    
    @IBOutlet private weak var firstCardView: UIView!
    @IBOutlet private weak var secondCardView: UIView!
    @IBOutlet private weak var thirdCardView: UIView!
    @IBOutlet private weak var fourthCardView: UIView!
    @IBOutlet private weak var fifthCardView: UIView!
    @IBOutlet private weak var sixthCardView: UIView!
    private lazy var cardViews: [UIView] = [sixthCardView, fifthCardView, fourthCardView, thirdCardView, secondCardView, firstCardView]
    
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    private var cards: [Card]?
    private var effects: [CardSetEffect]?
    
    enum TierColor: Int {
        case one = 1
        case two, three, four, five
        
        var color: UIColor {
            switch self {
            case .one:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .two:
                return #colorLiteral(red: 0.2665745945, green: 0.7807122976, blue: 0.2393269469, alpha: 1)
            case .three:
                return #colorLiteral(red: 3.330669074e-16, green: 0.5668461069, blue: 1, alpha: 1)
            case .four:
                return #colorLiteral(red: 0.6180220535, green: 0.2016021288, blue: 0.7555841048, alpha: 1)
            case .five:
                return #colorLiteral(red: 0.8724854504, green: 0.5156878221, blue: 0, alpha: 1)
            }
        }
    }
}
//MARK: - method
extension CardSetCVCell {
    func setCards(cardInfo: CardInfo) {
        cards = cardInfo.cards
        effects = cardInfo.effects
        configureCell()
    }
    
    private func configureCell() {
        guard let cards = cards else {
            return
        }
        setNameLabelFont()
        
        if cards.count != 6 {
            hideViews(cardViews.count - cards.count)
        }
        
        for (index, card) in cards.enumerated() {
            cardLabels[index].text = card.name
            setGemStacview(index: index, awakeCount: card.awakeCount, awakeTotal: card.awakeTotal)
            setTierColor(index: index, tierGrade: card.tierGrade)
        }
    }
    
    private func hideViews(_ count: Int) {
        if count >= 3 {
            secondStackView.isHidden = true
        }
        if count == 6 {
            firstStackView.addArrangedSubview(
                noCardLabel())
        }
        for index in 0...count - 1 {
            cardViews[index].isHidden = true
        }
        cardViews.reverse()
        for _ in 0...count - 1 {
            let _ = cardViews.popLast()
        }
    }
    
    private func noCardLabel() -> UILabel {
        let label = UILabel()
        label.text = "장착된 카드가 없습니다"
        label.font = UIFont.one(size: 20, family: .Bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
    
    private func setGemStacview(index: Int, awakeCount: Int, awakeTotal: Int) {
        if awakeCount != 0 {
            for _ in 0...awakeCount - 1 {
                cardGemStackView[index].addArrangedSubview(gemImage(awake: true))
            }
        }
        
        if awakeCount != 5 {
            for _ in 0...4 - awakeCount {
                cardGemStackView[index].addArrangedSubview(gemImage(awake: false))
            }
        }
    }
    
    private func gemImage(awake: Bool) -> UIImageView {
        let imageName = awake ? "activeGem" : "inActiveGem"
        let imageView = UIImageView(image: UIImage(named: imageName))
        
        return imageView
    }
}

// MARK: - font Setting
extension CardSetCVCell {
    private func setNameLabelFont() {
        for label in cardLabels {
            label.font = UIFont.one(size: 12, family: .Bold)
        }
    }
    
    private func setTierColor(index: Int, tierGrade: Int) {
        let tierColor = TierColor(rawValue: tierGrade)?.color
        cardLabels[index].textColor = tierColor
        cardImageViews[index].layer.borderColor = tierColor?.cgColor
        cardImageViews[index].layer.borderWidth = 1
    }
}
