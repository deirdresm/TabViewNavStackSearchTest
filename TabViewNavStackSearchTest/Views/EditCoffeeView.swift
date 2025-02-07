//
//  EditCatView 2.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//


//
//  EditCat.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct EditCoffeeView: View {
	@Bindable var coffee: Coffee
    var body: some View {
		Form {
			TextField("Coffee Name", text: $coffee.name)
				.padding()

			TextField("Coffee's Chief Consumer", text: $coffee.consumer)
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
