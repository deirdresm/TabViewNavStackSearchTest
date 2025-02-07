//
//  EditInstrumentView.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct EditInstrumentView: View {
	@Bindable var instrument: Instrument
    var body: some View {
		Form {
			TextField("Instrument Name", text: $instrument.name)
				.padding()

			TextField("Player Name", text: $instrument.player)
				.padding()
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Coffee.self, configurations: config)

	let coffees = Coffee.coffees
	EditCoffeeView(coffee: coffees.first!)
		.modelContainer(container)
}
