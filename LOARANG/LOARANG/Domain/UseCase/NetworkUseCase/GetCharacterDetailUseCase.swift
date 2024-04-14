//
//  GetCharacterDetailUseCase.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

struct GetCharacterDetailUseCase {
    private let crawlManagerable: CrawlManagerable //추후 networkmanager로 구현 예정
    init(crawlManagerable: CrawlManagerable) {
        self.crawlManagerable = crawlManagerable
    }
    
    func excute(name: String) async throws -> CharacterDetailEntity {
        let characterDTO = try await crawlManagerable.getUserInfo(name)
        let charterEntity = CharacterDetailEntity(
            gameServer: GameServer(rawValue: characterDTO.mainInfo.server.replacingOccurrences(of: "@", with: "")) ?? .unknown,
            battleLevel: characterDTO.mainInfo.battleLV,
            itemLevel: characterDTO.mainInfo.itemLV,
            expeditionLevel: characterDTO.mainInfo.expeditionLV,
            characterName: characterDTO.mainInfo.name,
            characterClass: CharacterClass(rawValue: characterDTO.mainInfo.class) ?? .unknown, 
            imageUrl: characterDTO.mainInfo.imageUrl
        )
        return charterEntity
    }
}
