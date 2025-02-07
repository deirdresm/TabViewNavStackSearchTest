//
//  BackgroundImporter.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import Foundation
import Cocoa
import SwiftData

actor BackgroundImporter {
	var catModelActor: CatModelActor
	var coffeeModelActor: CoffeeModelActor
	var instrumentModelActor: InstrumentModelActor

	init(modelContainer: ModelContainer) async throws {
		catModelActor = CatModelActor(modelContainer: modelContainer)
		try? await catModelActor.insertPreload()

		coffeeModelActor = CoffeeModelActor(modelContainer: modelContainer)
		try? await coffeeModelActor.insertPreload()

		instrumentModelActor = InstrumentModelActor(modelContainer: modelContainer)
		try? await instrumentModelActor.insertPreload()
	}

}

@ModelActor public actor CatModelActor {
	func insertPreload() async throws {
		for cat in Cat.cats {
			let catid = cat.id
			var catFetchDescriptor = FetchDescriptor<Cat>(
				predicate: #Predicate { $0.id == catid }
			)
			catFetchDescriptor.fetchLimit = 1

			if try modelContext.fetch(catFetchDescriptor).count == 0 {

				modelContext.insert(cat)
				try? modelContext.save()
			}
		}
	}
}


@ModelActor public actor CoffeeModelActor {
	func insertPreload() async throws {
		for coffee in Coffee.coffees {
			let coffeeid = coffee.id
			var coffeeFetchDescriptor = FetchDescriptor<Coffee>(
				predicate: #Predicate { $0.id == coffeeid }
			)
			coffeeFetchDescriptor.fetchLimit = 1

			if try modelContext.fetch(coffeeFetchDescriptor).count == 0 {

				modelContext.insert(coffee)
				try? modelContext.save()
			}
		}
	}
}

@ModelActor public actor InstrumentModelActor {
	func insertPreload() async throws {
		for instrument in Instrument.instruments {
			let instrumentid = instrument.id
			var instrumentFetchDescriptor = FetchDescriptor<Instrument>(
				predicate: #Predicate { $0.id == instrumentid }
			)
			instrumentFetchDescriptor.fetchLimit = 1

			if try modelContext.fetch(instrumentFetchDescriptor).count == 0 {

				modelContext.insert(instrument)
				try? modelContext.save()
			}
		}
	}
}
