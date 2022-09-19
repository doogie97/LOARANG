//
//  OwnCharacterViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import RxRelay
import RxSwift

protocol OwnCharacterViewModelable: OwnCharacterViewModelInput, OwnCharacterViewModelOutput {}

protocol OwnCharacterViewModelInput {}

protocol OwnCharacterViewModelOutput {
    var totalCharacters: BehaviorRelay<Int> { get }
    var sections: BehaviorRelay<[OwnCharacterSection]>{ get }
}

final class OwnCharacterViewModel: OwnCharacterViewModelable {
    private let disposeBag = DisposeBag()
    
    init(ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?>) {
        bind(ownCharacterInfo: ownCharacterInfo)
    }
    
    private func bind(ownCharacterInfo: BehaviorRelay<OwnCharacterInfo?>) {
        ownCharacterInfo.bind(onNext: { [weak self] in
            guard let ownCharacterInfo = $0 else {
                return
            }
            
            let ownCharacters = ownCharacterInfo.ownCharacters.sorted {$0.itemLV.toDouble ?? 0 > $1.itemLV.toDouble ?? 0}
            
            self?.totalCharacters.accept(ownCharacters.count)

            var ninaveCharacters: [OwnCharacter] = []
            var loopaeonCharacters: [OwnCharacter] = []
            var silianCharacters: [OwnCharacter] = []
            var armanCharacters: [OwnCharacter] = []
            var abrelshudCharacters: [OwnCharacter] = []
            var kadanCharacters: [OwnCharacter] = []
            var kharmineCharacters: [OwnCharacter] = []
            var kazerosCharacters: [OwnCharacter] = []
            
            ownCharacters.forEach {
                switch $0.server.replacingOccurrences(of: "@", with: "") {
                case "니나브":
                    ninaveCharacters.append($0)
                case "루페온":
                    loopaeonCharacters.append($0)
                case "실리안":
                    silianCharacters.append($0)
                case "아만":
                    armanCharacters.append($0)
                case "아브렐슈드":
                    abrelshudCharacters.append($0)
                case "카단":
                    kadanCharacters.append($0)
                case "카마인":
                    kharmineCharacters.append($0)
                case "카제로스":
                    kazerosCharacters.append($0)
                default:
                    return
                }
            }
            
            var sections: [OwnCharacterSection] = []
            
            if !ninaveCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "니나브", items: ninaveCharacters))
            }
            
            if !loopaeonCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "루페온", items: loopaeonCharacters))
            }
            
            if !silianCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "실리안", items: silianCharacters))
            }
            
            if !armanCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "아만", items: armanCharacters))
            }
            
            if !abrelshudCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "아브렐슈드", items: abrelshudCharacters))
            }
            
            if !kadanCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "카단", items: kadanCharacters))
            }
            
            if !kharmineCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "카마인", items: kharmineCharacters))
            }
            
            if !kazerosCharacters.isEmpty {
                sections.append(OwnCharacterSection(header: "카제로스", items: kazerosCharacters))
            }
            
            self?.sections.accept(sections)
        })
        .disposed(by: disposeBag)
    }
    
    //out
    let totalCharacters = BehaviorRelay<Int>(value: 0)
    let sections = BehaviorRelay<[OwnCharacterSection]>(value: [])
}
