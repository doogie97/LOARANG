//
//  CharactersViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/09/16.
//

import RxRelay
import RxSwift

protocol CharactersViewModelable: CharactersViewModelInput, CharactersViewModelOutput {}

protocol CharactersViewModelInput {
    func touchCell(_ index: IndexPath)
}

protocol CharactersViewModelOutput {
    var sections: BehaviorRelay<[CharactersSection]>{ get }
}

final class CharactersViewModel: CharactersViewModelable {
    private let networkManager = NetworkManager()
    private weak var userInfoViewModelDelegate: UserInfoViewModelDelegate?
    
    init(userName: String, userInfoViewModelDelegate: UserInfoViewModelDelegate) {
        self.userInfoViewModelDelegate = userInfoViewModelDelegate
        getCharacters(userName)
    }
    
    private func getCharacters(_ name: String) {
        Task {
            do {
                let characters = try await networkManager.request(OwnCharactersGET(name: name),
                                                                  resultType: [CharacterBasicInfoDTO].self)
                categorizeCharacters(characters.sorted {
                    $0.itemAvgLevel?.toDouble ?? 0 > $1.itemAvgLevel?.toDouble ?? 0 })
            } catch let error {
                await MainActor.run {
                    debugPrint(error)
                    userInfoViewModelDelegate?.showErrorAlert()
                }
            }
        }
    }
    
    //이 코드는 분명히 개선 해야함...
    private func categorizeCharacters(_ characters: [CharacterBasicInfoDTO]) {
        var ninaveCharacters: [CharacterBasicInfoDTO] = []
        var loopaeonCharacters: [CharacterBasicInfoDTO] = []
        var silianCharacters: [CharacterBasicInfoDTO] = []
        var armanCharacters: [CharacterBasicInfoDTO] = []
        var abrelshudCharacters: [CharacterBasicInfoDTO] = []
        var kadanCharacters: [CharacterBasicInfoDTO] = []
        var kharmineCharacters: [CharacterBasicInfoDTO] = []
        var kazerosCharacters: [CharacterBasicInfoDTO] = []
        
        characters.forEach {
            switch $0.serverName {
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
        
        var sections: [CharactersSection] = []
        
        if !ninaveCharacters.isEmpty {
            sections.append(CharactersSection(header: "니나브(\(ninaveCharacters.count))", items: ninaveCharacters))
        }
        
        if !loopaeonCharacters.isEmpty {
            sections.append(CharactersSection(header: "루페온(\(loopaeonCharacters.count))", items: loopaeonCharacters))
        }
        
        if !silianCharacters.isEmpty {
            sections.append(CharactersSection(header: "실리안(\(silianCharacters.count))", items: silianCharacters))
        }
        
        if !armanCharacters.isEmpty {
            sections.append(CharactersSection(header: "아만(\(armanCharacters.count))", items: armanCharacters))
        }
        
        if !abrelshudCharacters.isEmpty {
            sections.append(CharactersSection(header: "아브렐슈드(\(abrelshudCharacters.count))", items: abrelshudCharacters))
        }
        
        if !kadanCharacters.isEmpty {
            sections.append(CharactersSection(header: "카단(\(kadanCharacters.count))", items: kadanCharacters))
        }
        
        if !kharmineCharacters.isEmpty {
            sections.append(CharactersSection(header: "카마인(\(kharmineCharacters.count))", items: kharmineCharacters))
        }
        
        if !kazerosCharacters.isEmpty {
            sections.append(CharactersSection(header: "카제로스(\(kazerosCharacters.count))", items: kazerosCharacters))
        }
        
        self.sections.accept(sections)
    }
    
    //in
    func touchCell(_ index: IndexPath) {
        guard let userName = sections.value[safe: index.section]?.items[safe: index.row]?.characterName else {
            return
        }
        
        userInfoViewModelDelegate?.searchOwnCharacter(userName)
    }
    
    //out
    let sections = BehaviorRelay<[CharactersSection]>(value: [])
}
