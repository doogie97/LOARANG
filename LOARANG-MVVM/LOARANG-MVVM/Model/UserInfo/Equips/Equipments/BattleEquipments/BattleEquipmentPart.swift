//
//  BattleEquipmentPart.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/14.
//
protocol EquipmentPartable {
    var name: String? { get }
    var quality: Int? { get }
    var grade: Int? { get }
    var imageURL: String? { get }
}
struct BattleEquipmentPart: EquipmentPartable {
    let name: String?
    let part: String?
    let lv: String?
    let quality: Int?
    let grade: Int?
    let imageURL: String?
    let battleEffects: String?
}
