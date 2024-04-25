//
//  CharacterDetailVC.swift
//  LOARANG
//
//  Created by Doogie on 4/15/24.
//

import UIKit
import RxSwift

final class CharacterDetailVC: UIViewController {
    private let container: Containerable
    private let viewModel: CharacterDetailVMable
    private let charcterDetailView = CharacterDetailView()
    private let disposeBag = DisposeBag()
    
    init(container: Containerable,
         viewModel: CharacterDetailVMable) {
        self.container = container
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = charcterDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func bindViewModel() {
        viewModel.isLoading.withUnretained(self)
            .subscribe { owner, isLoading in
                owner.charcterDetailView.loadingView.isLoading(isLoading)
            }
            .disposed(by: disposeBag)
        
        viewModel.changeBookmarkButton.withUnretained(self)
            .subscribe { owner, isBookmark in
                owner.charcterDetailView.changeBookmark(isBookmark: isBookmark)
            }
            .disposed(by: disposeBag)
        
        viewModel.setViewContents.withUnretained(self)
            .subscribe { owner, _ in
                owner.charcterDetailView.setViewContents(viewModel: owner.viewModel)
            }
            .disposed(by: disposeBag)
        
        viewModel.popView.withUnretained(self)
            .subscribe { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.showAlert.withUnretained(self)
            .subscribe { owner, alertInfo in
                owner.showAlert(message: alertInfo.message) {
                    if alertInfo.isPop {
                        owner.navigationController?.popViewController(animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.showNextView.withUnretained(self)
            .subscribe { owner, viewCase in
                switch viewCase {
                case .skillDetail(let skill):
                    owner.present(SkillDetailVC(skill: skill), animated: true)
                case .characterDetail(let name):
                    let characterDetailVC = owner.container.characterDetailVC(name: name, isSearch: false)
                    owner.navigationController?.pushViewController(characterDetailVC, animated: true)
                case .selectFirstTab:
                    owner.charcterDetailView.changeSegment(toMoveIndex: 0)
                    owner.charcterDetailView.setPageView(0)
                case .gemDetail:
                    owner.showGemDetail()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func showGemDetail() {
        let halfModal = CustomHalfModal()
        let gemDetailView = GemDetailView()
        halfModal.contentsView = gemDetailView
        gemDetailView.setViewContents(gems: viewModel.characterInfoData?.gems ?? [])
        self.present(halfModal, animated: false)
    }
}
