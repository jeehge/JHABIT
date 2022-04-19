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
		
		animationView.frame = self.view.bounds
		animationView.center = self.view.center
		animationView.contentMode = .scaleAspectFit
		
		animationView.loopMode = .playOnce
		animationView.play()

		Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { _ in
			self.nextViewController()
		})
    }

    private func nextViewController() {
		if let _ = Storage.githubID {
			let mainVC: MainViewController = MainViewController.viewController(from: .main)
			mainVC.modalPresentationStyle = .fullScreen
			mainVC.modalTransitionStyle = .crossDissolve
			present(mainVC, animated: true, completion: nil)
		} else {
			let inputVC: InputViewController = InputViewController.viewController(from: .main)
			inputVC.modalPresentationStyle = .fullScreen
			inputVC.modalTransitionStyle = .crossDissolve
			present(inputVC, animated: true, completion: nil)
		}
        
    }
}
