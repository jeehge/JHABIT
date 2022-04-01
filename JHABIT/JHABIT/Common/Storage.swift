//
//  Storage.swift
//  JHABIT
//
//  Created by JH on 2022/04/01.
//

import Foundation

public struct Storage {
	
	public init() {}
	
	static var githubID: String? {
		get {
			UserDefaults.standard.string(forKey: "githubID")
		}
		
		set {
			UserDefaults.standard.set(newValue, forKey: "githubID")
			UserDefaults.standard.synchronize()
		}
	}
}
