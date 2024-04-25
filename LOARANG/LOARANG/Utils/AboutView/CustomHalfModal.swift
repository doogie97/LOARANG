//
//  CustomHalfModal.swift
//  LOARANG
//
//  Created by Doogie on 4/25/24.
//

import UIKit
import SnapKit
protocol CustomHalfModalDelegate: AnyObject {
    func animate(isShow: Bool, duration: Double)
}

final class CustomHalfModal: UIViewController, CustomHalfModalDelegate {
    var contentsView: UIView?
    var animationDuration = 0.3
    var blurViewOpacity = 0.7
    var grabberIsHidden = false {
        didSet {
            grabberView.backgroundColor = grabberIsHidden ? .clear : .systemGray
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var blurBackView = {
        let button = UIView()
        button.backgroundColor = .black
        button.layer.opacity = 0
        
        return button
    }()
    
    private lazy var gestureView = {
        let view = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal(_:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(slideModal(_:)))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(panGesture)
        
        return view
    }()
    
    @objc private func dismissModal(_ gesture: UITapGestureRecognizer) {
        animate(isShow: false, duration: animationDuration)
    }
    
    private var startSlideY = 0.0
    
    @objc private func slideModal(_ gesture: UIPanGestureRecognizer) {
        guard let contentsView = self.contentsView else {
            return
        }
        
        let touchPoint = gesture.location(in: view.window)
        switch gesture.state {
        case .began:
            self.startSlideY = touchPoint.y
        case .changed:
            slideAction(startSlideY: startSlideY, yPoint: touchPoint.y, contentsView: contentsView)
        case .ended, .cancelled:
            endAction(startSlideY: startSlideY,
                      yPoint: touchPoint.y,
                      contentsView: contentsView,
                      velocity: gesture.velocity(in: view).y)
        default:
            break
        }
    }
    
    private func slideAction(startSlideY: Double, yPoint: Double, contentsView: UIView) {
        if startSlideY < yPoint {
            let inset = yPoint - startSlideY
            contentsView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(-inset)
            }
            blurBackView.layer.opacity = Float(blurViewOpacity - blurViewOpacity * inset / contentsView.frame.height)
        }
    }
    
    private func endAction(startSlideY: Double, yPoint: Double, contentsView: UIView, velocity: Double) {
        let inset = yPoint - startSlideY
        let contentsViewHeight = contentsView.frame.height
        if contentsViewHeight / 2 < inset {
            animate(isShow: false, duration: 0.3)
        } else {
            if velocity > 2000 {
                animate(isShow: false, duration: 0.2)
            } else {
                animate(isShow: true, duration: 0.1)
            }
        }
    }
    
    private lazy var grabberView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate(isShow: true, duration: self.animationDuration)
    }
    
    func animate(isShow: Bool, duration: Double) {
        if isShow {
            UIView.animate(withDuration: duration) { [weak self] in
                self?.blurBackView.layer.opacity = Float(self?.blurViewOpacity ?? 0)
                if let contentsView = self?.contentsView {
                    contentsView.snp.remakeConstraints {
                        $0.leading.trailing.bottom.equalToSuperview()
                    }
                }
                self?.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: duration) { [weak self] in
                self?.blurBackView.layer.opacity = 0
                if let contentsView = self?.contentsView,
                   let view = self?.view {
                    contentsView.snp.remakeConstraints {
                        $0.top.equalTo(view.snp.bottom)
                        $0.leading.trailing.equalToSuperview()
                    }
                }
                self?.view.layoutIfNeeded()
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { [weak self] in
                self?.dismiss(animated: false)
            }
        }
    }
    
    private func setLayout() {
        self.view.addSubview(blurBackView)
        blurBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        if let contentsView = contentsView {
            contentsView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            contentsView.layer.cornerRadius = 6
            contentsView.clipsToBounds = true
            self.view.addSubview(contentsView)
            contentsView.snp.makeConstraints {
                $0.top.equalTo(self.view.snp.bottom)
                $0.leading.trailing.equalToSuperview()
            }
            
            if !grabberIsHidden {
                contentsView.addSubview(grabberView)
                
                grabberView.snp.makeConstraints {
                    $0.top.equalToSuperview().inset(12)
                    $0.centerX.equalToSuperview()
                    $0.height.equalTo(4)
                    $0.width.equalTo(80)
                }
            }
            
            self.view.addSubview(gestureView)
            gestureView.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
                $0.bottom.equalTo(contentsView.snp.top).inset(28)
            }
        }
    }
}

