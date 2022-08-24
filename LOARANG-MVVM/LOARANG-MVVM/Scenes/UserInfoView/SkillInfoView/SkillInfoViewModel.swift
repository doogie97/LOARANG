//
//  SkillInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import RxRelay

protocol SkillInfoViewModelable: SkillInfoViewModelInput, SkillInfoViewModelOutput {}

protocol SkillInfoViewModelInput {}

protocol SkillInfoViewModelOutput {
    var usedSkillPoint: String { get }
    var totalSkillPoint: String { get }
    var skills: BehaviorRelay<[Skill]> { get }
}

final class SkillInfoViewModel: SkillInfoViewModelable {
    init(skillInfo: SkillInfo) {
        self.usedSkillPoint = skillInfo.usedSkillPoint
        self.totalSkillPoint = skillInfo.totalSkillPoint
        self.skills = BehaviorRelay<[Skill]>(value: skillInfo.skills)
    }
    
    //out
    var usedSkillPoint: String
    var totalSkillPoint: String
    var skills: BehaviorRelay<[Skill]>
}
