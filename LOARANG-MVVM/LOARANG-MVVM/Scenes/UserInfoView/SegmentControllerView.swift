//
//  SegmentControllerView.swift
//  LOARANG-MVVM
//
//  Created by 최최성균 on 2022/07/31.
//

import SnapKit

final class SegmentControllerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var segmentController: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.selectedSegmentTintColor = .clear // 없어도되는거 같은데 이거는
        
        // 백그라운트 이미지 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // 구분선 제거
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // 선택안된 버튼 폰트
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont.one(size: 15, family: .Light)
        ], for: .normal)
        
        // 선택된 버튼 폰트
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1),
            NSAttributedString.Key.font: UIFont.one(size: 15, family: .Bold)
        ], for: .selected)
        
        segment.insertSegment(withTitle: "기본 정보", at: 0, animated: true)
        segment.insertSegment(withTitle: "스킬", at: 1, animated: true)
        segment.insertSegment(withTitle: "카드", at: 3, animated: true)
        segment.insertSegment(withTitle: "보유캐릭터", at: 4, animated: true)

        segment.selectedSegmentIndex = 0
        
        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        return segment
    }()
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1)
        
        return view
    }()
    
    private func setLayout() {
        self.addSubview(segmentController)
        self.addSubview(underLineView)
        
        segmentController.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.top.equalTo(segmentController.snp.bottom)
            $0.height.equalTo(2)
            
            $0.leading.equalTo(segmentController)
            
            $0.width.equalTo(segmentController.snp.width).dividedBy(segmentController.numberOfSegments)
        }
    }
    
    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentController.selectedSegmentIndex)
        let segmentWidth = segmentController.frame.width / CGFloat(segmentController.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self = self else {
                return
            }

            self.underLineView.snp.updateConstraints {
                $0.leading.equalTo(self.segmentController).inset(leadingDistance)
            }
            self.layoutIfNeeded()
        })
    }
}
