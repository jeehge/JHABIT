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
	@IBOutlet private weak var infoView: UIView!
	@IBOutlet private weak var collectionView: UICollectionView!
	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: - Properties
    private var list: [Commit] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		dddd()
		cofigInfoView()
		configTableView()
    }
	
	// MARK: - config
	private func cofigInfoView() {
		infoView.backgroundColor = .gray
		infoView.clipsToBounds = true
		infoView.layer.cornerRadius = infoView.frame.size.width / 18
		
		let githubIdLabel = UILabel().then {
			$0.text = "Github ID 🌱"
			$0.font = .systemFont(ofSize: 16, weight: .medium)
		}
		
		let githubIdValueLabel = UILabel().then {
			$0.text = Storage.githubID
			$0.font = .systemFont(ofSize: 14, weight: .bold)
		}
		
		let settingButton = UIButton().then {
			$0.setTitle("설정", for: .normal)
		}
		
		infoView.addSubviews(githubIdLabel, githubIdValueLabel, settingButton)
		
		githubIdLabel.snp.makeConstraints {
			$0.top.equalToSuperview().inset(8)
			$0.left.equalToSuperview().inset(16)
		}
		
		githubIdValueLabel.snp.makeConstraints {
			$0.top.equalTo(githubIdLabel.snp.bottom).inset(8)
			$0.left.equalToSuperview().inset(16)
		}
	}
	
	private func configCollectionView() {
		
	}
	
	private func configTableView() {
		tableView.dataSource = self
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
		let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath)
		cell.textLabel?.text = "날짜 : \(list[indexPath.row].date) 커밋 개수 :\(list[indexPath.row].count)"
		return cell
	}
}
