//
//  LoaderController.swift
//  EffectiveMobile
//
//  Created by Алексей on 08.05.2025.
//

import UIKit
import SnapKit
import Lottie

final class LoaderController: UIViewController {
    // MARK: – UI Elements
    private var lottieView: LottieAnimationView?
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteCustom
        view.isOpaque = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: – Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundViewLottie()
        setupLottieView()
    }
    
    // MARK: – Setup's
    private func backgroundViewLottie() {
        view.addSubview(backgroundView)

        backgroundView.snp.makeConstraints { make in
            make.width.height.equalTo(75)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupLottieView() {
        lottieView = LottieAnimationView(name: "Loader")
        lottieView?.center = backgroundView.center
        lottieView?.contentMode = .scaleAspectFit
        lottieView?.loopMode = .loop
        lottieView?.animationSpeed = 1.0
        backgroundView.addSubview(lottieView!)
        
        lottieView?.snp.makeConstraints { make in
            make.width.height.equalTo(175)
            make.centerX.centerY.equalToSuperview()
        }
        
        lottieView?.play()
    }
    
    // MARK: – Stop Animation
    func stopAnimation() {
        lottieView?.stop()
        self.dismiss(animated: true)
    }
}
