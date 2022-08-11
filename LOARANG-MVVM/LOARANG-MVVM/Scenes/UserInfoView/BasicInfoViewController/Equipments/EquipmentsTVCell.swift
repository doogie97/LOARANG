//
//  EquipmentsTVCell.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/08/11.
//

import RxSwift

final class EquipmentsTVCell: UITableViewCell {
    private var viewModel: EquipmentsTVCellViewModelable?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private let disposBag = DisposeBag()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [segmentControll, pageView])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .cellColor
        
        segmentControll.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.1)
        }
        
        return stackView
    }()
    
    let segmentControll = SegmentControllerView(frame: .zero,
                                                segmentTitles: ["장비", "아바타", "캐릭터 이미지"])
    
    private lazy var pageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return view
    }()
    
    private func setLayout() {
        self.selectionStyle = .none
        self.backgroundColor = .cellBackgroundColor
        self.segmentControll.backgroundColor = .tableViewColor
        self.segmentControll.layer.cornerRadius = 10
        self.segmentControll.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        self.contentView.addSubview(mainStackView)

        mainStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bindView() {
        segmentControll.segmentController.rx.value
            .bind(onNext: { [weak self] in
                self?.viewModel?.touchSegmentControl($0)
            })
            .disposed(by: disposBag)
        
        viewModel?.currentPage
            .bind(onNext: { [weak self] in
                self?.changeView(index: $0)
            })
            .disposed(by: disposBag)
    }
    
    
    private func changeView(index: Int) {
        guard let viewModel = viewModel else {
            return
        }
        
        if viewModel.previousPage.value == index {
             return
        }
        
        var direction: UIPageViewController.NavigationDirection {
            index > viewModel.previousPage.value ? .forward : .reverse
        }
        
        pageVC.setViewControllers([viewModel.pageViewList[index]], direction: direction, animated: true)
        pageVC.view.frame = CGRect(x: 0, y: 0, width: pageView.frame.width, height: pageView.frame.height)
        pageView.addSubview(pageVC.view)
        viewModel.detailViewDidShow(index)
    }
    
    func setCellContents(viewModel: EquipmentsTVCellViewModelable) {
        self.viewModel = viewModel
        bindView()
    }
}
