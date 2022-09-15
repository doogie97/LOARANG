//
//  SkillInfoViewModel.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/24.
//

import RxRelay
import RxSwift

protocol SkillInfoViewModelable: SkillInfoViewModelInput, SkillInfoViewModelOutput {}

protocol SkillInfoViewModelInput {
    func touchSkillCell(_ index: Int)
}

protocol SkillInfoViewModelOutput {
    var skillInfo: BehaviorRelay<SkillInfo?> { get }
    var skills: BehaviorRelay<[Skill]> { get }
    var showSkillDetailView: PublishRelay<Skill> { get }
}

final class SkillInfoViewModel: SkillInfoViewModelable {
    private let disposeBag = DisposeBag()
    
    init(skillInfo: BehaviorRelay<SkillInfo?>) {
        self.skillInfo = skillInfo
        bind()
    }
    
    func bind() {
        skillInfo.bind(onNext: { [weak self] in
            guard let skillInfo = $0 else {
                return
            }
            
            self?.skills.accept(skillInfo.skills)
        })
        .disposed(by: disposeBag)
    }
    
    //in
    func touchSkillCell(_ index: Int) {
        showSkillDetailView.accept(skills.value[index])
    }
    //out
    let skillInfo: BehaviorRelay<SkillInfo?>
    let showSkillDetailView = PublishRelay<Skill>()
    let skills = BehaviorRelay<[Skill]>(value: [])
}
