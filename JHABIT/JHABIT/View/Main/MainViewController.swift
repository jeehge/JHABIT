//
//  MainViewController.swift
//  JHABIT
//
//  Created by JH on 2022/03/26.
//

import Alamofire
import SwiftSoup
import UIKit

final class MainViewController: UIViewController {
    
	// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlStr = "https://www.github.com/jeehge"

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
					let commit = Commit(count: count, date: date, level: level)
					print(commit)
                }
            } catch {
                print("crawl error")
            }
        }
    }
}
