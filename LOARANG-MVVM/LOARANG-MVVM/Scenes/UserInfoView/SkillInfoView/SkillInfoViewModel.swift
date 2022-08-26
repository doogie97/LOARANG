//
//  SkillInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import RxRelay

protocol SkillInfoViewModelable: SkillInfoViewModelInput, SkillInfoViewModelOutput {}

protocol SkillInfoViewModelInput {
    func touchSkillCell(_ index: Int)
}

protocol SkillInfoViewModelOutput {
    var usedSkillPoint: String { get }
    var totalSkillPoint: String { get }
    var showSkillDetailView: PublishRelay<Skill> { get }
    var skills: BehaviorRelay<[Skill]> { get }
}

final class SkillInfoViewModel: SkillInfoViewModelable {
    init(skillInfo: SkillInfo) {
        self.usedSkillPoint = skillInfo.usedSkillPoint
        self.totalSkillPoint = skillInfo.totalSkillPoint
        self.skills = BehaviorRelay<[Skill]>(value: skillInfo.skills)
    }
    
    //in
    func touchSkillCell(_ index: Int) {
        showSkillDetailView.accept(skills.value[index])
    }
    //out
    var usedSkillPoint: String
    var totalSkillPoint: String
    var showSkillDetailView = PublishRelay<Skill>()
    var skills: BehaviorRelay<[Skill]>
}
