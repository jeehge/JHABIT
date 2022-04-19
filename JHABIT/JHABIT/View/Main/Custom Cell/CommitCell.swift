//
//  CommitCell.swift
//  JHABIT
//
//  Created by JH on 2022/04/03.
//

import UIKit

final class CommitCell: UITableViewCell {
	// MARK: - Initialization
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		selectionStyle = .none
		initialize()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Methods
	func initialize() {
		
	}
	
	func setCell(info: Commit) {
		textLabel?.text = "\(info.date) \t | \t \(info.count)"
	}
}
