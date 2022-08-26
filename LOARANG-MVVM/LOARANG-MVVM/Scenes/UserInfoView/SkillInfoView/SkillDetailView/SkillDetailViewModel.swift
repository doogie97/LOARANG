//
//  SkillDetailViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/26.
//

import RxRelay

protocol SkillDetailViewModelable: SkillDetailViewModelInput, SkillDetailViewModelOutput {}

protocol SkillDetailViewModelInput {
    func touchCloseButton()
}

protocol SkillDetailViewModelOutput {
    var skill: Skill { get }
    var tripods: BehaviorRelay<[Tripod]> { get }
    var dismiss: PublishRelay<Void> { get }
}

final class SkillDetailViewModel: SkillDetailViewModelable {
    init(skill: Skill) {
        self.skill = skill
        self.tripods = BehaviorRelay<[Tripod]>(value: skill.tripods)
    }
    
    //in
    func touchCloseButton() {
        dismiss.accept(())
    }
    
    //out
    let skill: Skill
    let tripods: BehaviorRelay<[Tripod]>
    let dismiss = PublishRelay<Void>()
}
