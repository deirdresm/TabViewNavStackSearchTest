//
//  Item 2.swift
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
final class Instrument {
	var id: Int
	var name: String
	var player: String

	init(id: Int, name: String, player: String) {
		self.id = id
		self.name = name
		self.player = player
	}

	static var instruments: [Instrument] = [
		.init(id: 1, name: "Keyboard", player: "Rick"),
		.init(id: 2, name: "Bass VI", player: "Deirdre"),
		.init(id: 3, name: "Violin", player: "Nikki"),
	]
}
