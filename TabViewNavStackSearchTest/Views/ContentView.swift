//
//  ContentView.swift
//  TabViewNavStackSearchTest
//
//  Created by Deirdre Saoirse Moen on 2/6/25.
//

import SwiftUI
import SwiftData

enum TabChoice: Identifiable, CaseIterable {
	case cats
	case coffees
	case instruments

	var id: Self { self }

	var description: String {
		switch self {
		case .cats: return "Cats"
		case .coffees: return "Coffees"
		case .instruments: return "Instruments"
		}
	}
}

struct ContentView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var currentTab: TabChoice = .cats
	@State private var searchText = ""

	#if os(macOS)
	   @State private var backgroundImporter: BackgroundImporter?
	#endif


	// Query for each model
	@Query private var cats: [Cat]
	@Query private var coffees: [Coffee]
	@Query private var instruments: [Instrument]

	// Sort for each model
	@State private var catSortOrder = [SortDescriptor(\Cat.name)]
	@State private var coffeeSortOrder = [SortDescriptor(\Coffee.name)]
	@State private var instrumentSortOrder = [SortDescriptor(\Instrument.name)]

	// Nav paths
	@State private var catNavPath: [Cat] = []
	@State private var coffeeNavPath: [Coffee] = []
	@State private var instrumentNavPath: [Instrument] = []

	var body: some View {
		TabView(selection: $currentTab) {
			catsView
				.tabItem { // Label("Cats", systemImage: "cat")
					Image(systemName: "cat")
					Text("Cat")
				}
				.tag(TabChoice.cats)

			coffeesView
				.tabItem { // Label("Coffees", systemImage: "cup.and.heat.waves")
					Image(systemName: "cup.and.heat.waves")
					Text("Coffee")
				}
				.tag(TabChoice.coffees)
			instrumentsView
				.tabItem { // Label("Instruments", systemImage: "guitars")
					Image(systemName: "guitars")
					Text("Instruments")
				}
				.tag(TabChoice.instruments)
		}
	}

	private func addCat() {
		withAnimation {
			let newCat = Cat(id: 999, name: "New Cat Name", friend: "New Cat Friend")
			modelContext.insert(newCat)
		}
	}

	private func addCoffee() {
		withAnimation {
			let newCoffee = Coffee(id: 998, name: "New Coffee", consumer: "New Coffee Friend")
			modelContext.insert(newCoffee)
		}
	}

	private func addInstrument() {
		withAnimation {
			let newInstrument = Instrument(id: 997, name: "New Instrument", player: "New Player")
			modelContext.insert(newInstrument)
		}
	}

	var catsView: some View {
		NavigationStack(path: $catNavPath) {
			GalleryCat(sort: catSortOrder, searchString: searchText)
				.navigationTitle("Neighborhood Cats")
				.navigationDestination(for: Cat.self, destination: EditCatView.init)
				.toolbar {
					catsToolbar()
				} // .toolbar
				.searchable(text: $searchText, prompt: "Search")
		} // NavigationStack
	}

	var coffeesView: some View {
		NavigationStack(path: $coffeeNavPath) {
			GalleryCoffee(sort: coffeeSortOrder, searchString: searchText)
				.navigationTitle("Coffees")
				.navigationDestination(for: Coffee.self, destination: EditCoffeeView.init)
				.toolbar {
					coffeesToolbar()
				}
				.searchable(text: $searchText, prompt: "Search")
		} // NavigationStack
	}

	var instrumentsView: some View {
		NavigationStack(path: $instrumentNavPath) {
			GalleryInstrument(sort: instrumentSortOrder, searchString: searchText)
				.navigationTitle("Instruments")
				.navigationDestination(for: Instrument.self, destination: EditInstrumentView.init)
				.toolbar {
					instrumentsToolbar()
				}
				.searchable(text: $searchText, prompt: "Search")
		} // NavigationStack
	}

	@ToolbarContentBuilder
	func catsToolbar() -> some ToolbarContent {
		ToolbarItem {
			Button(action: addCat) {
				withAnimation {
					Label("Add Cat", systemImage: "plus")
				}
			}
		}

		#if os(macOS)
		ToolbarItem {
			Button(action: backgroundImport) {
				Label("Import", systemImage: "bolt.horizontal")
			}
		}
		#endif

		ToolbarItem {
			Menu("Sort", systemImage: "arrow.up.and.down") {
				Picker("Sort", selection: $catSortOrder) {

					Text("Name")
						.tag([
							SortDescriptor(\Cat.name),
						])

					Text("Friend")
						.tag([
							SortDescriptor(\Cat.friend),
						])

				} // Picker
				.pickerStyle(.inline)
			} // Menu
		} // Toolbar Item
	} // catsToolbar

	@ToolbarContentBuilder
	func coffeesToolbar() -> some ToolbarContent {
		ToolbarItem {
			Button(action: addCoffee) {
				Label("Add Coffee", systemImage: "plus")
			}
		}

		ToolbarItem {
			Menu("Sort", systemImage: "arrow.up.and.down") {
				Picker("Sort", selection: $coffeeSortOrder) {

					Text("Name")
						.tag([
							SortDescriptor(\Coffee.name),
						])

					Text("Consumer")
						.tag([
							SortDescriptor(\Coffee.consumer),
						])

				} // Picker
				.pickerStyle(.inline)
			} // Menu
		} // Toolbar Item
	} // coffeesToolbar

	@ToolbarContentBuilder
	func instrumentsToolbar() -> some ToolbarContent {
		ToolbarItem {
			Button(action: addInstrument) {
				Label("Add Instrument", systemImage: "plus")
			}
		}

		ToolbarItem {
			Menu("Sort", systemImage: "arrow.up.and.down") {
				Picker("Sort", selection: $instrumentSortOrder) {

					Text("Name")
						.tag([
							SortDescriptor(\Instrument.name),
						])

					Text("Consumer")
						.tag([
							SortDescriptor(\Instrument.player),
						])

				} // Picker
				.pickerStyle(.inline)
			} // Menu
		} // Toolbar Item
	} // instrumentsToolbar

#if os(macOS)
private func backgroundImport() {
	withAnimation {
		Task {
			backgroundImporter = try? await BackgroundImporter(modelContainer: modelContext.container)
		}
	}
}
#endif

}

#Preview {
    ContentView()
        .modelContainer(for: Cat.self, inMemory: true)
}
