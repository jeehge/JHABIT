//
//  InputViewController.swift
//  JHABIT
//
//  Created by JH on 2022/03/27.
//

import UIKit

final class InputViewController: BaseViewController {
	
	// MARK: - Properties
	@IBOutlet private weak var infoLabel: UILabel!
	@IBOutlet private weak var inputTextFiled: UITextField!
	@IBOutlet private weak var saveButton: UIButton!
	
	// MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configView()
	}
	
	// MARK: - Initialize
	private func configView() {
		infoLabel.text = "Github 아이디를 입력해주세요 🌱"
		
		saveButton.setTitle("저장", for: .normal)
	}
	
	// MARK: - IBAction
	@IBAction private func saveButtonTouchUpInside(_ sender: UIButton) {
		Storage.githubID = inputTextFiled.text
		
		let mainVC: MainViewController = MainViewController.viewController(from: .main)
		mainVC.modalPresentationStyle = .fullScreen
		mainVC.modalTransitionStyle = .crossDissolve
		present(mainVC, animated: true, completion: nil)
	}
}
