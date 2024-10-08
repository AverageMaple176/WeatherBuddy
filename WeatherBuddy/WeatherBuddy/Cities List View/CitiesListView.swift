//
//  CitiesListView.swift
//  WeatherBuddy
//
//  Created by Peter Berning on 9/14/24.
//

import SwiftUI

struct CitiesListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DataStore.self) private var store
    let currentLocation: City?
    @Binding var selectedCity: City?
    @State private var isSearching = false
    @FocusState private var isFocused: Bool
    @State private var sheetShown: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Add a City")
                            .focused($isFocused)
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.blue)
                            )
                        
                    }
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            isSearching.toggle()
                        }
                    }
                    Divider()
                    List {
                        Group {
                            if let currentLocation {
                                CityRowView(city: currentLocation)
                                    .onTapGesture {
                                        selectedCity = currentLocation
                                        dismiss()
                                    }
                            }
                            ForEach(store.cities.sorted(using: KeyPathComparator(\.name))) { city in
                                CityRowView(city: city)
                                    .swipeActions {
                                        Button(role: .destructive) {
                                            if let index = store.cities.firstIndex(where: {$0.id == city.id}) {
                                                store.cities.remove(at: index)
                                                store.saveCities()
                                            }
                                        } label: {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    .onTapGesture {
                                        selectedCity = city
                                        dismiss()
                                    }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .listRowInsets(.init(top: 0, leading: 20, bottom: 5, trailing: 20))
                    }
                    .listStyle(.plain)
                    .navigationTitle("WeatherBuddy")
                    .navigationBarTitleDisplayMode(.automatic)
                    .preferredColorScheme(.dark)
                }
                if isSearching || isFocused {
                    SearchOverlay(isSearching: $isSearching)
                        .zIndex(1.0)
                }
            }
        }
    }
}

#Preview {
    CitiesListView(currentLocation: City.mockCurrent, selectedCity: .constant(nil))
        .environment(LocationManager())
        .environment(DataStore(forPreviews: true))
}
