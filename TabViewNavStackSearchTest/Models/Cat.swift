//
//  Item.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import Foundation
import SwiftData

@Model
final class Cat {
	var id: Int
	var name: String
	var friend: String

	init(id: Int, name: String, friend: String) {
		self.id = id
		self.name = name
		self.friend = friend
	}

	static var cats: [Cat] = [
		Cat(id: 1, name: "Lily", friend: "Deirdre"),
		Cat(id: 2, name: "Gadget", friend: "Rick"),
		Cat(id: 3, name: "Momo", friend: "Nikki"),
	]
}
