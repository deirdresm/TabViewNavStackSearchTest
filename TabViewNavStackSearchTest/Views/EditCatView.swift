//
//  EditCat.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct EditCatView: View {
	@Bindable var cat: Cat
    var body: some View {
		Form {
			TextField("ID", value: $cat.id, format: IntegerFormatStyle())

			TextField("Cat's Name", text: $cat.name)
				.padding()

			TextField("Cat's BFF", text: $cat.friend)
				.padding()
		}
		.textFieldStyle(.roundedBorder)
    }
}

#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Cat.self, configurations: config)

	let cats = Cat.cats
	EditCatView(cat: cats.first!)
		.modelContainer(container)
}
