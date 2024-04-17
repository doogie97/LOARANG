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
    func viewDidLoad(_ characterDetail: CharacterDetailEntity)
    func touchSkillCell(_ index: Int)
}

protocol SkillInfoViewModelOutput {
    var skillInfo: BehaviorRelay<SkillInfo?> { get }
    var skills: BehaviorRelay<[Skill]> { get }
    var showSkillDetailView: PublishRelay<Skill> { get }
}

final class SkillInfoViewModel: SkillInfoViewModelable {
    private let disposeBag = DisposeBag()
    
    func bind() {
        skillInfo.bind(onNext: { [weak self] in
            guard let skillInfo = $0 else {
                return
            }
            
            self?.skills.accept(skillInfo.skills)
        })
        .disposed(by: disposeBag)
    }
    
    //MARK: - Input
    func viewDidLoad(_ characterDetail: CharacterDetailEntity) {
        self.skillInfo.accept(characterDetail.skillInfo)
        bind()
    }
    
    func touchSkillCell(_ index: Int) {
        showSkillDetailView.accept(skills.value[index])
    }
    
    //MARK: - Output
    let skillInfo = BehaviorRelay<SkillInfo?>(value: nil)
    let showSkillDetailView = PublishRelay<Skill>()
    let skills = BehaviorRelay<[Skill]>(value: [])
}
