//
//  IntroViewController.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import Lottie
import UIKit

final class IntroViewController: BaseViewController {
    
	// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initIntroAnimation()
    }

    // MARK: - initialize
    private func initIntroAnimation() {
		let animationView: AnimationView = .init(name: "5694-growing")
		view.addSubview(animationView)

		// animationView의 설정 작업은 알아서 하세요
		animationView.frame = self.view.bounds
		animationView.center = self.view.center
		animationView.contentMode = .scaleAspectFit
		
		// 애니메이션을 1번만 실행함
		animationView.loopMode = .playOnce
		animationView.play()

		Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false, block: { _ in
			self.nextMainViewController()
		})
    }

    private func nextMainViewController() {
        let mainVC: MainViewController = MainViewController.viewController(from: .main)
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        present(mainVC, animated: true, completion: nil)
    }
}
