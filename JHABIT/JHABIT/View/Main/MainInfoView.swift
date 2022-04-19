//
//  MainInfoView.swift
//  JHABIT
//
//  Created by JH on 2022/04/02.
//

import UIKit

final class MainInfoView: UIView {
	
	// MARK: - Properties
	let githubIdLabel = UILabel().then {
		$0.text = "Github ID 🌱"
		$0.font = .systemFont(ofSize: 24, weight: .medium)
	}

	let githubIdValueLabel = UILabel().then {
		$0.text = Storage.githubID
		$0.font = .systemFont(ofSize: 16, weight: .bold)
	}

	let settingButton = UIButton().then {
		$0.setTitle("설정", for: .normal)
	}
	
	// MARK: - Initialization
	convenience init() {
		self.init(frame: .zero)
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

		initialize()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Initialize
	func initialize() {
		addSubviews(githubIdLabel, githubIdValueLabel, settingButton)

		githubIdLabel.snp.makeConstraints {
			$0.top.equalToSuperview().inset(16)
			$0.left.equalToSuperview().inset(16)
		}

		githubIdValueLabel.snp.makeConstraints {
			$0.top.equalTo(githubIdLabel.snp.bottom).offset(8)
			$0.left.equalToSuperview().inset(16)
		}

		settingButton.snp.makeConstraints {
			$0.top.equalTo(githubIdLabel)
			$0.right.equalToSuperview().inset(16)
			$0.width.height.equalTo(44)
		}

		settingButton.addTarget(self, action: #selector(settingButtonTouched(_:)), for: .touchUpInside)
	}
	
	// MARK: - Action
	@objc
	private func settingButtonTouched(_ sender: UIButton) {
//		let settingVC = SettingViewController.viewController(from: .setting)
//		navigationController?.pushViewController(settingVC, animated: true)
	}
}
