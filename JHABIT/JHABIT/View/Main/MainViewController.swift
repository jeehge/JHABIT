//
//  MainViewController.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import Alamofire
import SwiftSoup
import UIKit

final class MainViewController: BaseViewController {
    
	// MARK: - @IBOutlet
	let infoView = MainInfoView().then {
		$0.translatesAutoresizingMaskIntoConstraints = false
		$0.backgroundColor = .white
		$0.clipsToBounds = true
		$0.layer.cornerRadius = 18
	}
	
	let tableView = UITableView().then {
		$0.backgroundColor = .green
		$0.register(CommitCell.self)
	}
	
	// MARK: - Properties
    private var list: [Commit] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .lightGray
		
		dddd()
		setupUI()
//		configTableView()
    }
	
	// MARK: - config
	private func setupUI() {
		view.addSubviews(infoView, tableView)
		
		infoView.snp.makeConstraints {
			$0.top.equalTo(view.layoutMarginsGuide.snp.top).inset(16)
			$0.left.right.equalToSuperview().inset(16)
			$0.height.equalTo(90)
		}
		
		configTableView()
	}
	
	private func configTableView() {
		tableView.dataSource = self
//		tableView.delegate = self
		
		tableView.snp.makeConstraints {
			$0.top.equalToSuperview().inset(300)
			$0.left.right.equalToSuperview()
			$0.bottom.equalToSuperview()
		}
	}
	
	func dddd() {
		guard let id = Storage.githubID else { return }
		let urlStr = "https://www.github.com/\(id)"

		let manager = CoreDataManager(name: "Commit")

		// Handle multiple entity types
//		for object in manager.fetch() {
//			print(object)
//			if let object = object as? Commit {
//				list.append(object)
//			}
//		}

//		if list.count == 0 {
			AF.request(urlStr).responseString { response in
				guard let html = response.value else {
					return
				}

				do {
					let doc: Document = try SwiftSoup.parse(html)
					// #newsContents > div > div.postRankSubjectList.f_clear
					let elements: Elements = try doc.select("svg.js-calendar-graph-svg > g > g > rect")
					for element in elements {
						let count: String = try element.attr("data-count")
						let date: String = try element.attr("data-date")
						let level: String = try element.attr("data-level")
						let commit = Commit(id: UUID(), count: count, date: date, level: level)
						
						self.list.append(commit)
//						print("날짜 : \(commit.date)\n커밋: \(commit.count)")
//						manager.save(data: commit)
					}
					self.list = self.list.reversed()
					self.tableView.reloadData()
				} catch {
					print("crawl error")
				}
			}
//		}
	}
	
	
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return list.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CommitCell.identifier, for: indexPath) as! CommitCell
		cell.setCell(info: list[indexPath.row])
		return cell
	}
}
