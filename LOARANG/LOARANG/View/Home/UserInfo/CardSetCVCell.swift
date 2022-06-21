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
    
    @IBOutlet private weak var firstCardGemStacView: UIStackView!
    @IBOutlet private weak var secondCardGemStackView: UIStackView!
    @IBOutlet private weak var thridCardGemStackView: UIStackView!
    @IBOutlet private weak var fourthCardGemStackView: UIStackView!
    @IBOutlet private weak var fifthCardGemStackView: UIStackView!
    @IBOutlet private weak var sixthCardGemStackView: UIStackView!
    
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
        if cards.count != 6 {
            hideViews(cardViews.count - cards.count)
        }
        
        for (index, card) in cards.enumerated() {
            cardLabels[index].text = card.name
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
    
}
