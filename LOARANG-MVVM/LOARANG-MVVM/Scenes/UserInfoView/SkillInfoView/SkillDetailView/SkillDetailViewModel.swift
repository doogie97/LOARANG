//
//  SkillDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

protocol SkillDetailViewModelable: SkillDetailViewModelInput, SkillDetailViewModelOutput {}

protocol SkillDetailViewModelInput {}

protocol SkillDetailViewModelOutput {
    var skill: Skill { get }
}

final class SkillDetailViewModel: SkillDetailViewModelable {
    init(skill: Skill) {
        self.skill = skill
    }
    
    //out
    var skill: Skill
}
