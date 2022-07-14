//
//  FakeUserInfo.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/15.
//

struct fakeUser {
    let user = UserInfo(basicInfo: BasicInfo(server: "니나브",
                                             name: "최지근",
                                             battleLV: "60",
                                             itemLV: "1506.67",
                                             expeditionLV: "119",
                                             title: "넌 나의 션샤인",
                                             guild: "미지근",
                                             pvp: "20급",
                                             wisdom: "Lv.39 미지근",
                                             class: "블레이드",
                                             userImageURL: "null"),
                        stat: Stat(basicEffect: BasicEffect(attack: "30000",
                                                            vitality: "30000",
                                                            crit: "1000",
                                                            specialization: "1000",
                                                            domination: "1000",
                                                            swiftness: "1000",
                                                            endurance: "1000",
                                                            expertise: "1000"),
                                   propensities: Propensities(intellect: "500",
                                                              courage: "500",
                                                              charm: "500",
                                                              kindness: "500"),
                                   engravigs: [Engraving(title: "원한",
                                                         describtion: "강력해!")]),
                        equips: Equips(gems: [Gem(name: "7레벨 홍염의 보석",
                                                  grade: 4,
                                                  lvString: "7레벨",
                                                  effect: "어쩌고저쩌고가 60% 세졌음",
                                                  imageURL: "null")],
                                       cardInfo: CardInfo(cards: [Card(name: "웨이",
                                                                       tierGrade: 3,
                                                                       awakeCount: 5,
                                                                       awakeTotal: 5,
                                                                       imageURL: "Null")],
                                                          effects: [CardSetEffect(desc: "세구빛 18강",
                                                                                  title: "나도 세구빛 오우너")]),
                                       equipments: Equipments(haed: nil,
                                                              shoulder: nil,
                                                              top: nil,
                                                              bottom: nil,
                                                              gloves: nil,
                                                              weapon: nil),
                                       avatar: Avatar(mainAvatar: MainAvatar(), subAvatar: SubAvatar())))
}
