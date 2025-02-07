//
//  CatList.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct GalleryCat: View {
	@Environment(\.modelContext) var modelContext
	@Query(sort: [SortDescriptor(\Cat.name)]) var cats: [Cat]

	private let galleryGridSize: GridItem.Size = .adaptive(minimum: 300)

	init(sort: [SortDescriptor<Cat>], searchString: String) {
		_cats = Query(filter: #Predicate {
			if searchString.isEmpty {
				return true
			} else {
				return $0.name.localizedStandardContains(searchString) || $0.friend.localizedStandardContains(searchString)
			}
		}, sort: sort)
	}

	var body: some View {
		ScrollView {
			LazyVGrid(
				columns: [GridItem(galleryGridSize)],
				spacing: 20
			) {
				ForEach(cats) { cat in
					VStack {
						NavigationLink {
							EditCatView(cat: cat)
						} label: {
							Text(cat.name)
						}

						HStack {
							Text("ID:")
							Text("\(cat.id)")
						}
						HStack {
							Text("Friend:")
							Text("\(cat.friend)")
						}
					}
				}
			}
		} // ScrollView
    }
}

#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Cat.self, configurations: config)

	let cats = Cat.cats
	GalleryCat(sort: [SortDescriptor(\Cat.name)], searchString: "Nikki")
		.modelContainer(container)
}
