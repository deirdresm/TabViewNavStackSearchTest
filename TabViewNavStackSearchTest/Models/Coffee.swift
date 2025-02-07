//
//  Item 3.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//


//
//  Item.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import Foundation
import SwiftData

@Model
final class Coffee {
	var id: Int
	var name: String
	var consumer: String

	init(id: Int, name: String, consumer: String) {
		self.id = id
		self.name = name
		self.consumer = consumer
	}

	static var coffees: [Coffee] = [
		.init(id: 1, name: "Arabian Mocha Sanani", consumer: "Deirdre"),
		.init(id: 2, name: "Tea, please", consumer: "Nikki"),
		.init(id: 3, name: "Major Dickasons", consumer: "Rick"), // sorry
	]
}
