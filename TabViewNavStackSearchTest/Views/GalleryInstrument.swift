//
//  CatList 3.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//


//
//  CatList.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

struct GalleryInstrument: View {
	@Environment(\.modelContext) var modelContext
	@Query(sort: [SortDescriptor(\Instrument.name)]) var instruments: [Instrument]

	private let galleryGridSize: GridItem.Size = .adaptive(minimum: 300)

	init(sort: [SortDescriptor<Instrument>], searchString: String) {
		_instruments = Query(filter: #Predicate {
			if searchString.isEmpty {
				return true
			} else {
				return $0.name.localizedStandardContains(searchString) || $0.player.localizedStandardContains(searchString)
			}
		}, sort: sort)
	}

    var body: some View {
		ScrollView {
			LazyVGrid(
				columns: [GridItem(galleryGridSize)],
				spacing: 20
			) {
				ForEach(instruments) { instrument in
					VStack {
						NavigationLink {
							EditInstrumentView(instrument: instrument)
						} label: {
							Text(instrument.name)
						}

						HStack {
							Text("ID:")
							Text("\(instrument.id)")
						}
						HStack {
							Text("Player:")
							Text("\(instrument.player)")
						}
					}
				}
			}
		} // ScrollView
    }
}

#Preview {
	let config = ModelConfiguration(isStoredInMemoryOnly: true)
	let container = try! ModelContainer(for: Instrument.self, configurations: config)

	let instruments = Instrument.instruments
}
