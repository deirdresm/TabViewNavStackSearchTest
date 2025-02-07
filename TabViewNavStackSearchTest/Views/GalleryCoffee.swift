//
//  CoffeeList.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct GalleryCoffee: View {
	@Environment(\.modelContext) var modelContext
	@Query(sort: [SortDescriptor(\Coffee.name)]) var coffees: [Coffee]

	private let galleryGridSize: GridItem.Size = .adaptive(minimum: 300)

	init(sort: [SortDescriptor<Coffee>], searchString: String) {
		_coffees = Query(filter: #Predicate {
			if searchString.isEmpty {
				return true
			} else {
				return $0.name.localizedStandardContains(searchString) || $0.consumer.localizedStandardContains(searchString)
			}
		}, sort: sort)
	}

    var body: some View {
		ScrollView {
			LazyVGrid(
				columns: [GridItem(galleryGridSize)],
				spacing: 20
			) {
				ForEach(coffees) { coffee in
					VStack {
						NavigationLink {
							EditCoffeeView(coffee: coffee)
						} label: {
							Text(coffee.name)
						}

						HStack {
							Text("ID:")
							Text("\(coffee.id)")
						}
						HStack {
							Text("Primary Consumer:")
							Text("\(coffee.consumer)")
						}
					}
				}
			}
		} // ScrollView
    }
}

#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Coffee.self, configurations: config)

	let coffees = Coffee.coffees
}
