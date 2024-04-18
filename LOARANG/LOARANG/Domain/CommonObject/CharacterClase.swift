//
//  CharacterClase.swift
//  LOARANG
//
//  Created by Doogie on 3/22/24.
//

enum CharacterClass: String {
    //전사(남)
    case berserker = "버서커"
    case destroyer = "디스트로이어"
    case warlord = "워로드"
    case holyknight = "홀리나이트"
    //전사(여)
    case slayer = "슬레이어"
    //무도가(여)
    case battleMaster = "배틀마스터"
    case infighter = "인파이터"
    case soulMaster = "기공사"
    case lanceMaster = "창술사"
    //무도가(남)
    case striker = "스트라이커"
    case breaker = "브레이커"
    //헌터(남)
    case devilHunter = "데빌헌터"
    case blaster = "블래스터"
    case hawkEye = "호크아이"
    case scouter = "스카우터"
    //헌터(여)
    case gunslinger = "건슬링어"
    //마법사(여)
    case arcana = "아르카나"
    case summoner = "서머너"
    case bard = "바드"
    case sorceress = "소서리스"
    //암살자(여)
    case demonic = "데모닉"
    case blade = "블레이드"
    case reaper = "리퍼"
    case souleater = "소울이터"
    //스페셜리스트(여)
    case artist = "도화가"
    case aeromancer = "기상술사"
    
    //전직 전
    case specialist = "스페셜리스트"
    case magician = "마법사"
    case warrior = "전사(남)"
    case warrior_female = "전사(여)"
    case hunter = "헌터(남)"
    case hunter_female = "헌터(여)"
    case assassin = "암살자"
    case fighter = "무도가(여)"
    case fighter_male = "무도가(남)"
    case unknown = "알 수 없음"
}

//emblem
extension CharacterClass {
    var classImageURL: String? {
        let baseURL = "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/emblem_"
        switch self {
            
            //전직 후
        case .destroyer:
            return baseURL + "destroyer.png"
        case .warlord:
            return baseURL + "warlord.png"
        case .berserker:
            return baseURL + "berserker.png"
        case .holyknight:
            return baseURL + "holyknight.png"
        case .striker:
            return baseURL + "battle_master_male.png"
        case .breaker:
            return baseURL + "infighter_male.png"
        case .battleMaster:
            return baseURL + "battle_master.png"
        case .infighter:
            return baseURL + "infighter.png"
        case .soulMaster:
            return baseURL + "force_master.png"
        case .lanceMaster:
            return baseURL + "lance_master.png"
        case .devilHunter:
            return baseURL + "devil_hunter.png"
        case .blaster:
            return baseURL + "blaster.png"
        case .hawkEye:
            return baseURL + "hawk_eye.png"
        case .scouter:
            return baseURL + "scouter.png"
        case .gunslinger:
            return baseURL + "devil_hunter_female.png"
        case .bard:
            return baseURL + "bard.png"
        case .summoner:
            return baseURL + "summoner.png"
        case .arcana:
            return baseURL + "arcana.png"
        case .sorceress:
            return baseURL + "elemental_master.png"
        case .blade:
            return baseURL + "blade.png"
        case .demonic:
            return baseURL + "demonic.png"
        case .reaper:
            return baseURL + "reaper.png"
        case .artist:
            return baseURL + "yinyangshi.png"
        case .aeromancer:
            return baseURL + "weather_artist.png"
        case .slayer:
            return baseURL + "berserker_female.png"
        case .souleater:
            return baseURL + "soul_eater.png"
            //전직 전
        case .specialist:
            return baseURL + "specialist.png"
        case .magician:
            return baseURL + "magician.png"
        case .warrior:
            return baseURL + "warrior.png"
        case .warrior_female:
            return baseURL + "warrior_female.png"
        case .hunter:
            return baseURL + "hunter.png"
        case .hunter_female:
            return baseURL + "hunter_female.png"
        case .assassin:
            return baseURL + "assassin.png"
        case .fighter_male:
            return baseURL + "fighter_male.png"
        case .fighter:
            return baseURL + "fighter.png"
        default:
            return nil
        }
    }
}
